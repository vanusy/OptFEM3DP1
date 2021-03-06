function K=StiffElasAssembling3DP1OptV2(nq,nme,q,me,volumes,lambda,mu,Num)
% function K=StiffElasAssembling3DP1OptV2(nq,nme,q,me,volumes,lambda,mu,Num)
%   Assembly of the Stiffness Elasticity Matrix by P1-Lagrange finite elements in 3D
%   - OptV2 version (see report).
%
% Parameters:
%  nq: total number of vertices of the 3D mesh,
%  nme: total number of elements.
%  q: Array of vertices coordinates, 3-by-nq array.
%     q(il,j) is the il-th coordinate of the j-th vertex, il in {1,3}
%     and j in {1,...,nq}.
%  me: Connectivity array, 4-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex
%      of the k-th tetrahedron in the array q of vertices coordinates,
%      jl in {1,..,4} and k in {1,...,nme}.
%  volumes: Array of volumes, 1-by-nme array. volumes(k) is the volume
%         of the k-th tetrahedron.
%  lambda: the first Lame coefficient in Hooke's law
%  mu: the second Lame coefficient in Hooke's law
%  Num: 
%    0 global alternate numbering with local alternate numbering (classical method), 
%    1 global block numbering with local alternate numbering,
%    2 global alternate numbering with local block numbering,
%    3 global block numbering with local block numbering.
%
% Return values:
%  K: Global stiffness elasticity matrix, (3xnq)-by-(3xnq) sparse matrix.
%
% Example:
%    Th=CubeMesh(10);
%    KK=StiffElasAssembling3DP1OptV2(Th.nq,Th.nme,Th.q,Th.me,Th.volumes,1.,0.25,0);
%
% See also:
%   BuildIgJgP1VF, BuildElemStiffElasMatFuncVec


%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details

[Ig,Jg]=BuildIgJgP1VF(Num,me,nq);
ElemStiffElasMatVec=BuildElemStiffElasMatFuncVec(Num);
[Kg]=ElemStiffElasMatVec(q,me,volumes,lambda,mu);

K=sparse(Ig(:),Jg(:),Kg(:),3*nq,3*nq);
