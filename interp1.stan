data{
 int N;
 int M;
 real x[N];
 real y[N];
 real x_test[M];
}

generated quantities{
  real y_test[M] = interp1(x, y, x_test);
}