function test_algorithms_real_data()
    MAdata = csvread('MA_edudata.csv',1,3);
    MAtot_revenue = MAdata(:,2);
    MAmath_grade_4 = MAdata(:,19);
    MAinstr_expenditure = MAdata(:,7);
    MAenroll = MAdata(:,1);
    figure(1)
    scatter(MAinstr_expenditure, MAmath_grade_4)
    xlabel("Massachussetts instructional expenditure")
    ylabel("MA grade 4 scores")
    figure(2)
    scatter(MAtot_revenue, MAmath_grade_4)
    xlabel("Massachussetts revenue")
    ylabel("MA grade 4 scores")
    alldata= csvread('states_all.csv',1,3);
    enroll = alldata(:,1);
    revenue = alldata(:,2);
    instr_expend = alldata(:,7);
    math_grade4 = alldata(:,19);
    figure(3)
    scatter(revenue,math_grade4)
    xlabel("revenue")
    ylabel("grade 4 math score")
    figure(4)
    scatter(MAtot_revenue,MAinstr_expenditure);
    xlabel("Massachussetts revenue")
    ylabel("MA instructional expenditure")
    figure(5)
    scatter(MAenroll,MAinstr_expenditure)
    xlabel("MA enrollment")
    ylabel("MA instructional expenditure")
    figure(6)
    scatter(enroll,instr_expend)
    xlabel("all states enrollment")
    ylabel("instructional expenditure")
    figure(7)
    scatter(instr_expend,math_grade4)
    xlabel("instructional expenditure")
    ylabel("math grade 4 outcomes")
end