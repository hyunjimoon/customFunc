clone_cmdstan <- function(
  clone_dir,
  cmdstan_url = "http://github.com/stan-dev/cmdstan",
  stan_url = "http://github.com/stan-dev/stan",
  math_url = "http://github.com/hyunjimoon/math",
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
  cmdstanr::rebuild_cmdstan(dir = clone_dir, cores = cores)
}

clone_cmdstan("customFunc_cmdstan")


library("cmdstanr")
set_cmdstan_path("customFunc_cmdstan")
mod <- cmdstan_model("interp1.stan", compile = FALSE)
modc <- mod$compile(stanc_options = list("allow-undefined" = TRUE))
fit <- mod$sample(iter_warmup = 0, iter_sampling = 10)