function test_algorithms_real_data()

    % make a variety of plots based on MA education data
    % are any of these combinations worth regressing?
    MAdata = csvread('MA_edudata.csv',1,3);
    MAtot_revenue = MAdata(:,2);
    MAmath_grade_4 = MAdata(:,19);
    MAinstr_expenditure = MAdata(:,7);
    MAenroll = MAdata(:,1);
    
    figure(1)
    scatter(MAinstr_expenditure, MAmath_grade_4)
    title("State Revenue and instructional expenditure, MA 1992-2017")
    xlabel("Massachussetts instructional expenditure")
    ylabel("MA grade 4 scores")
    figure(2)
    scatter(MAtot_revenue, MAmath_grade_4)
    title("State Revenue and grade 4 test scores, MA 1992-2017")
    xlabel("Massachussetts revenue")
    ylabel("MA grade 4 scores")
    figure(3)
    scatter(MAtot_revenue,MAinstr_expenditure);
    title("State Revenue and instructional expenditure, MA 1992-2017")
    xlabel("Massachussetts revenue")
    ylabel("MA instructional expenditure")
    figure(4)
    scatter(MAenroll,MAinstr_expenditure)
    title("student enrollment and instructional expenditure, MA 1992-2017")
    xlabel("MA enrollment")
    ylabel("MA instructional expenditure")
    
    % make a variety of plots based on education data from all 50 states
    % are any of these combinations worth regressing?
    alldata= csvread('states_all.csv',1,3);
    enroll = alldata(:,1);
    revenue = alldata(:,2);
    instr_expend = alldata(:,7);
    math_grade4 = alldata(:,19);
    
    figure(5)
    scatter(revenue,math_grade4)
    title("state revenue vs grade 4 math score for all states 1992-2017")
    xlabel("revenue")
    ylabel(" grade 4 math score")
    figure(6)
    scatter(enroll,instr_expend)
    title("student enrollment vs instructional expenditure for all states, 1992-2017")
    xlabel("all states enrollment")
    ylabel("instructional expenditure")
    figure(7)
    scatter(instr_expend,math_grade4)
    title("instructional expenditure and math grade 4 test scores for all states, 1992-2017")
    xlabel("instructional expenditure")
    ylabel("math grade 4 outcomes")
    
    %2017 GDP per capita and health indicators for all countries
    world_data=csvread('gdp_health.csv',1,1);
    GDP = world_data(:,1);
    birth = world_data(:,2);
    HIV = world_data(:,3);
    
    figure(8)
    scatter(GDP,birth)
    title("GDP and adolescent birth rate")
    xlabel("GDP")
    ylabel("birth rate")
    figure(9)
    scatter(GDP,HIV)
    xlabel("GDP")
    ylabel("HIV incidence")
    title("GDP and HIV incidence")
    
end