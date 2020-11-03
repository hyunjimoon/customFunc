clone_cmdstan <- function(
  clone_dir,
  cmdstan_url = "http://github.com/stan-dev/cmdstan",
  stan_url = "http://github.com/stan-dev/stan",
  math_url = "http://github.com/hyunjimoon/math",
  stanc3_url = "http://github.com/hyunjimoon/stanc3",
  cmdstan_branch = "develop",
  stan_branch = "develop",
  math_branch = "feature/interp1",
  stanc3_branch = "feature/interp1",
  cores = 4) {
  if (!dir.exists(clone_dir)) {
    dir.create(clone_dir)  
  }
  git2r::clone(url = cmdstan_url, branch = cmdstan_branch, local_path = file.path(clone_dir))
  git2r::clone(url = stan_url, branch = stan_branch, local_path = file.path(clone_dir, "stan"))
  git2r::clone(url = math_url, branch = math_branch, local_path = file.path(clone_dir, "stan", "lib", "stan_math"))
  git2r::clone(url = stanc3_url, branch = stanc3_branch, local_path = file.path(clone_dir))
  cmdstanr::rebuild_cmdstan(dir = clone_dir, cores = cores)
}

clone_cmdstan(getwd())

library("cmdstanr"); library("tidyverse")
set_cmdstan_path("/Users/hyunjimoon/customFunc/customFunc_cmdstan")
N = 5
data <- list(N = N, M = 4, x = seq(0.0, 5.0, length = N), y = sin(x), x_test = c(1.0, 1.7, 2.1, 4.0))
mod <- cmdstan_model("interp1.stan", quiet = FALSE)
fit <- mod$sample(data, iter_warmup = 0, iter_sampling = 10, fixed_param = TRUE)
fit$y_test
