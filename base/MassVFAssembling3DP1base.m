function M=MassVFAssembling3DP1base(nq,nme,me,volumes,Num)
% function M=MassVFAssembling3DP1base(nq,nme,me,volumes,Num)
%   Assembly of the Mass vectors fields Matrix by P1-Lagrange finite elements in 3D
%   - basic version (see report).
%
% Parameters:
%  nq: total number of vertices of the 3D mesh,
%  nme: total number of elements.
%  me: Connectivity array, 4-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex
%      of the k-th tetrahedron in the array q of vertices coordinates,
%      jl in {1,..,4} and k in {1,...,nme}.
%  volumes: Array of volumes, 1-by-nme array. volumes(k) is the volume
%         of the k-th tetrahedron.
%  Num: 
%    0 global alternate numbering with local alternate numbering (classical method), 
%    1 global block numbering with local alternate numbering,
%    2 global alternate numbering with local block numbering,
%    3 global block numbering with local block numbering.
%
% Return values:
%  M: Global Mass vectors fields matrix, (3xnq)-by-(3xnq) sparse matrix.
%
% Example:
%    Th=CubeMesh(10);
%    Mvf=MassVFAssembling3DP1base(Th.nq,Th.nme,Th.me,Th.volumes,0);
%
% See also:
%   BuildIkFunc, BuildElemMassVFMatFunc
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
M=sparse(3*nq,3*nq);
GetI=BuildIkFunc(Num,nq);
ElemMassVFMat=BuildElemMassVFMatFunc(Num);
E=ElemMassVFMat(1);
for k=1:nme
    %E=ElemStiffElasMat(q(:,me(:,k)),volumes(k),H);
    I=GetI(me,k);
    for il=1:12
        for jl=1:12
            M(I(il),I(jl))=M(I(il),I(jl))+volumes(k)*E(il,jl);
        end
    end
end
