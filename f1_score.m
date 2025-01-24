function [score, TPR, TNR, Accuracy,pre] = f1_score(label, predict)
   M = confusionmat(label, predict);
   TP = M(1,1);
   TN = M(2,2);
   FP = M(1,2);
   FN = M(2,1);
   %以下两行为二分类时用
   TPR = M(2,2) / (M(2,1) + M(2,2)); %SE: TP/(TP+FN)
   TNR = M(1,1) / (M(1,1) + M(1,2)); %SP: TN/(TN+FP)
   Accuracy = (TP + TN) / (TP + TN + FP + FN);
   pre = M(1,1) / (M(1,1) + M(2,1));
   %转置，可以不转同时调换方向
   M = M';
   precision = diag(M)./(sum(M,2) + 0.0001);  %按列求和: TP/(TP+FP)
   recall = diag(M)./(sum(M,1)+0.0001)'; %按行求和: TP/(TP+FN)
   precision = mean(precision);
   recall = mean(recall);
   score = 2*precision*recall/(precision + recall);
end
