function  auc = plot_roc_ECBAM(T_train,T_sim)  
% INPUTS  
%  predict       - 分类器对测试集的分类结果  
%  ground_truth - 测试集的正确标签,这里只考虑二分类，即0和1  
% OUTPUTS  
%  auc            - 返回ROC曲线的曲线下的面积  
  
%初始点为（1.0, 1.0）  
x = 1.0;  
y = 1.0;  
%计算出ground_truth中正样本的数目pos_num和负样本的数目neg_num  
pos_num = sum(T_sim==1);  
neg_num = sum(T_sim==0);  
%根据该数目可以计算出沿x轴或者y轴的步长  
x_step = 1.0/neg_num;  
y_step = 1.0/pos_num;  
%首先对predict中的分类器输出值按照从小到大排列  
[T_train,index] = sort(T_train);  
T_sim = T_sim(index);  
%对predict中的每个样本分别判断他们是FP或者是TP  
%遍历ground_truth的元素，  
%若ground_truth[i]=1,则TP减少了1，往y轴方向下降y_step  
%若ground_truth[i]=0,则FP减少了1，往x轴方向下降x_step  
for i=1:length(T_sim)  
    if T_sim(i) == 1  
        y = y - y_step;  
    else  
        x = x - x_step;  
    end  
    X(i)=x;  
    Y(i)=y;  
end  
%画出图像       
plot(X,Y,'color','r','LineWidth',2);  
xlabel('False Positive Rate','FontSize',18,'Fontname','Times New Roman');  
ylabel('True Positive Rate','FontSize',18,'Fontname','Times New Roman');  
set(gca, 'Box', 'on', ...                                % 边框
         'Layer','bottom',...                             % 图层
         'LineWidth',1.5,...                                % 线宽
         'XGrid', 'on', 'YGrid', 'on', ...              % 网格
         'TickDir', 'out', 'TickLength', [0 0], ...       % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...    % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1], ...
         'XLim',[-0.01 1],'YLim',[0 1.01])  % 坐标轴颜色
%计算小矩形的面积,返回auc  
auc = -trapz(X,Y);
hold on
x=[0:0.1:1];
y=x;
plot(x,y,'color',[0 0 0],'LineWidth',2,'LineStyle','--')
legend('Logistic(AUC=0.7004)','SVM(AUC=0.7779)','BP(AUC=0.9214)','Bagging(AUC=0.8991)','ECBAM(AUC=0.9473)','AUC=0.5','FontSize',18,'Fontname','Times','location','SouthEast')
legend boxoff
end  