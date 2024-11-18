clear all
clc

option = input("Enter the model name(Normal ,Student,Chi2,Fisher: ",'s');
switch option
    case 'Normal'
        fprintf("Normal distibution model\n");
        mu = input("mu = ");
        sigma = input("sigma = ");
        result = normcdf(0,mu,sigma);
        fprintf("a)\nP(x<=0)=%f\n",normcdf(0,mu,sigma));
        fprintf("P(x>=0)=%f\n",1-normcdf(0,mu,sigma));
        result1 = normcdf(1) - normcdf(-1)
        fprintf("b)\nP(-1<=x<=1)=%f\n",result1);
        result2 = 1-result1;
        fprintf("P(x<=-1 or x>=1 )=%f\n",result2);
        alfa = input("alfa = ");
        fprintf("c)\nP(x<alfa)=alfa=%f\n",norminv(alfa,mu,sigma))
        beta = input("beta = ");
        fprintf("d)\nP(x>?)=beta=%f\n",norminv(1-beta,mu,sigma));
    case 'Student'
        fprintf("Student distibution model\n")
        n = input("n = ");
        fprintf("a)\nP(x<=0)=%f\n",tcdf(0,n));
        fprintf("P(x>=0)=%f\n",1-tcdf(0,n));
        result1 = tcdf(1) - tcdf(-1)
        fprintf("b)\nP(-1<=x<=1)=%f\n",result1);
        result2 = 1-result1;
        fprintf("P(x<=-1 or x>=1 )=%f\n",result2);
        alfa = input("alfa = ");
        fprintf("c)\nP(x<alfa)=alfa=%f\n",tinv(alfa,n))
        beta = input("beta = ");
        fprintf("d)\nP(x>?)=beta=%f\n",norminv(1-beta,n));
    case 'Chi2'
        fprintf("Chi2 distibution model\n");
        n = input("n = ");
        fprintf("a)\nP(x<=0)=%f\n",chi2cdf(0,n));
        fprintf("P(x>=0)=%f\n",1-chi2cdf(0,n));
        result1 = chi2cdf(1) - chi2cdf(-1)
        fprintf("b)\nP(-1<=x<=1)=%f\n",result1);
        result2 = 1-result1;
        fprintf("P(x<=-1 or x>=1 )=%f\n",result2);
        alfa = input("alfa = ");
        fprintf("c)\nP(x<alfa)=alfa=%f\n",chi2inv(alfa,n))
        beta = input("beta = ");
        fprintf("d)\nP(x>?)=beta=%f\n",norminv(1-beta,n));
    case 'Fisher'
        fprintf("Fisher distibution model\n")
        n = input("n = ");
        m = input("m = ")
        fprintf("a)\nP(x<=0)=%f\n",fcdf(0,n,m));
        fprintf("P(x>=0)=%f\n",1-fcdf(0,n));
        result1 = fcdf(1) - fcdf(-1)
        fprintf("b)\nP(-1<=x<=1)=%f\n",result1);
        result2 = 1-result1;
        fprintf("P(x<=-1 or x>=1 )=%f\n",result2);
        alfa = input("alfa = ");
        fprintf("c)\nP(x<alfa)=alfa=%f\n",norminv(alfa,n,m))
        beta = input("beta = ");
        fprintf("d)\nP(x>?)=beta=%f\n",norminv(1-beta,n,m));
    otherwise
        fprintf("Wrong option!\n");
end








