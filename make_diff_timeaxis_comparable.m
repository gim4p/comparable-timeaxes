
function [d1_result,d2_result]=make_diff_timeaxis_comparable(d1,d2)

if size(d1,1) > size(d1,2)
    d1=d1';
    d2=d2';
end

%% d1
intd1d2 = intersect(d1,d2);
[a,b] = histc(d1,unique(d1));
countvec_d1=[a;unique(d1)];
countvec_d1=countvec_d1(:,ismember(countvec_d1(2,:),intd1d2));

%% d2
intd1d2 = intersect(d2,d1);
[a,b] = histc(d2,unique(d2));
countvec_d2=[a;unique(d2)];
countvec_d2=countvec_d2(:,ismember(countvec_d2(2,:),intd1d2));

%%
counts_d1d2 = max([countvec_d1(1,:);countvec_d2(1,:)]);

IDXsource=cumsum(counts_d1d2);
idxd1=counts_d1d2-countvec_d1(1,:);
NaN_pos_d1 = IDXsource(idxd1>0);
while any(idxd1(:) > 1)
    idxd1=idxd1-1;idxd1(idxd1<0)=0;
    IDXsource=IDXsource-1;
    NaN_pos_d1=[NaN_pos_d1,IDXsource(idxd1>0)];
end

IDXsource=cumsum(counts_d1d2);
idxd2=counts_d1d2-countvec_d2(1,:);
NaN_pos_d2 = IDXsource(idxd2>0);
while any(idxd2(:) > 1)
    idxd2=idxd2-1;idxd2(idxd2<0)=0;
    IDXsource=IDXsource-1;
    NaN_pos_d2=[NaN_pos_d2,IDXsource(idxd2>0)];
end

%%
output_nonanyet = repelem(intd1d2,counts_d1d2);
d1_result = output_nonanyet;
d1_result(NaN_pos_d1)=NaN;

d2_result = output_nonanyet;
d2_result(NaN_pos_d2)=NaN;

%%



%{
clear all;close all;clc
d1     =[ 1 1 2 2 2 4 4 4 9 10 10 10 12  ]; %12
x1(1,:)=randi(10,length(d1),1);
d2     =[ 2 2 2 3 3 3 3 4 4 9  9  10 12 12 12 14 ]; %13
x2(1,:)=randi(10,length(d2),1);
[d1result,d2result]=make_diff_timeaxis_comparable(d1,d2);
d1result
d2result
% d1result = [2 2 2 4 4 4 9 NaN 10 10 10 12 NaN NaN]
% d2result = [2 2 2 4 4 NaN 9 9 10 NaN NaN 12 12 12]


x1NaN=NaN(size(d1result));
x1NaN((ismember(d1result,d1)~=0))=x1(ismember(d1,d1result))

x2NaN=NaN(size(d1result));
x2NaN((ismember(d2result,d2)~=0))=x2(ismember(d2,d2result))
%}



