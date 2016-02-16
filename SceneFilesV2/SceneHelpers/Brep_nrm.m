function n = Brep_nrm( obj )

for i = size(obj.tri,2):-1:1
  p = obj.p( 1:3, obj.tri(:,i) );
  n(:,i) = cross( p(:,2)-p(:,1), p(:,3)-p(:,1) );
  n(:,i)= n(:,i) ./ norm(n(:,i));
end

