function scene = scene_fscanf( fid )
% scene = scene_fscanf( fid )
% Read in scene data
% e.g. scene = scene_fscanf(fopen('shadowscene.dat'))
% note that 'simplescene.m' may set up more than this old version, but
% this allows more general scenes (specified as .dat files).

Nobj = fscanf( fid, '%d' );

scene.objects = cell(0);
for i = 1:Nobj  
  % read a new object
  s = '';
  while isempty(s)
    s = fgetl( fid );
  end
  fidobj = fopen( s );
  name = s;
  obj = Brep_fscanf( fidobj );
  fclose( fidobj );
  % read a transform as a string (so can contain commands)
  s = '';
  while isempty(s)
    s = fgetl( fid );
  end
  M = eval(s);
  
  % move the object
  obj = Brep_move( obj, M );
  % compute object surface normals of MOVED object
  obj.n = Brep_nrm( obj );

  s = strfind(name,'.brep');
  obj.name = name(1:s(1)-1);
  % merge it with the last
  scene.objects{end+1} = obj;
end

% read the camera -pixels in x and y, and width in x and y
scene.camera.N = fscanf(fid,'%d',2);
scene.camera.N = scene.camera.N(:);
scene.camera.w = fscanf(fid,'%f',2);
scene.camera.w = scene.camera.w(:);

% now read light direction
scene.light.amb = fscanf(fid,'%f', 3 );
scene.light.amb = scene.light.amb(:);
scene.light.u = fscanf( fid, '%f', 3 );
scene.light.u = uvec(scene.light.u);


return;
