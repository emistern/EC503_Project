function test_algorithms_real_data()
    % plot a variety of variables against each other to see which datasets
    % will be useful to run on our algorithms
    % I definitely think the graduate admissions ones look worthwhile, I
    % also think some of the funky data from global datasets could be
    % useful for comparison
    % some of the MAß education spending data is interesting too
    % if we want to do multiple features, the admissions one makes the most
    % sense
    

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
    math_grade8 = alldata(:,20);
    
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
    scatter(instr_expend./enroll,math_grade4)
    title("instructional expenditure per pupil and math grade 4 test scores for all states, 1992-2017")
    xlabel("instructional expenditure per pupil")
    ylabel("math grade 4 outcomes")
    figure(8)
    scatter(instr_expend./enroll,math_grade8)
    title("instructional expenditure per pupil and math grade 8 test scores for all states, 1992-2017")
    xlabel("instructional expenditure per pupil")
    ylabel("math grade 8 outcomes")
    
    %2017 GDP per capita and health indicators for all countries
    world_data=csvread('gdp_health.csv',1,1);
    GDP = world_data(:,1);
    birth = world_data(:,2);
    HIV = world_data(:,3);
    
    figure(9)
    scatter(GDP,birth)
    title("GDP and adolescent birth rate")
    xlabel("GDP")
    ylabel("birth rate")
    figure(10)
    scatter(GDP,HIV)
    xlabel("GDP")
    ylabel("HIV incidence")
    title("GDP and HIV incidence")
    
    % Admissions prediction dataset
    admissions = csvread('Admission_Predict.csv',1,1);
    GRE = admissions(:,1);
    TOEFL = admissions(:,2);
    admit_chance = admissions(:,8);
    rating = admissions(:,3);
    GPA = admissions(:,6);
    figure(11)
    scatter(GRE,admit_chance)
    title("GRE score and chance of admissions")
    xlabel("GRE score")
    ylabel("admission chance")
    figure(12)
    scatter(TOEFL, admit_chance)
    title("TOEFL score and chance of admissions")
    xlabel("TOEFL score")
    ylabel("admission chance")
    figure(13)
    scatter(GPA,admit_chance)
    title("GPA and chance of admissions")
    xlabel("GPA")
    ylabel("admission chance")    
    figure(14)
    title("GPA and university rating")
    xlabel("GPA")
    ylabel("university rating")
    scatter(GPA,rating)
    
end