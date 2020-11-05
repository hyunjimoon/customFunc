functions {
  real[] interp1(real[] x, real[] y, real[] x_test);
}

transformed data {
  real x[2] = { -5.0, 10.0 };
  real y[2] = { -3.0, 0.0 };
}

parameters {
  real<lower = -0.5, upper = 10.0> x_int[1];
}

transformed parameters {
  real y_int = interp1(x, y, x_int)[1];
}

model {
  x_int ~ normal(0, 5);
}