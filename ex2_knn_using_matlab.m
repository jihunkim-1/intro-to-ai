%% 데이터 불러오기
clear; close all; clc;

load fisheriris;
%%각 종을 숫자로 표현 1: versicolor, 2:virginica
spcs2num=[];
for k=1:1:length(species)
    if strcmp(species(k),'versicolor')==1
        spcs2num(k,1)=1;
    elseif strcmp(species(k),'virginica')==1
            spcs2num(k,1)=2;
    end
end

%%학습데이터와 평가데이터 나누기
%두개의 그룹만 먼저 나누기 versicolor vs virginica
%1~50:setosa 51~100: versicolor,101~150:virginica
%학습데이터: 71~100: versicolor,121~150:virginica 총 60개
%평가데이터: 51~70: versicolor,101~120:virginica 총 40개

% 사용할 특징은 sepal length와 width =1열과 2열
tr_id=[71:1:100 121:1:150];
Training_data=meas(tr_id,:);
Training_label=spcs2num(tr_id,:);

ts_id=[51:1:70 101:1:120];
Test_data=meas(ts_id,:);
Test_label=spcs2num(ts_id,:);

%%매트랩 내부 함수를 이용한 KNN모델 만들기(학습,결정해야할 것:k,거리를 어떤 방법으로 할지)
k=3; %인접한 이웃 3개를 보겠다
md1= fitcknn(Training_data, Training_label,'NumNeighbors',k,'Distance','euclidean');
%md1= fitcknn(Training_data, Training_label,'NumNeighbors',k); 
%knn에서 거리를 계산하는 default 방법은 유클리디안 이므로,이렇게 작성

%%평가해보기 # 1
% test의 첫번째 데이터를 넣어보기
result = predict(md1,Test_data(1,:))

%%평가해보기 # 2:한번에 다해보기
result = predict(md1,Test_data)

%그려보기
figure;
subplot(211); bar(Test_label); axis tight;
subplot(212); bar(result); axis tight;

figure;
subplot(311); bar(Test_label); axis tight;
subplot(312); bar(result); axis tight;
subplot(313); bar(Test_label); axis tight;