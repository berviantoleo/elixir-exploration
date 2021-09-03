defmodule ElixirExplorationWeb.Middlewares.ExceptionMiddleware do
  @behaviour Absinthe.Middleware
  @default_error {:error, :internal_server_error}
  @default_config []

  @spec wrap(Absinthe.Middleware.spec()) :: Absinthe.Middleware.spec()
  def wrap(middleware_spec) do
    {__MODULE__, [handle: middleware_spec]}
  end

  @impl true
  def call(resolution, handle: middleware_spec) do
    execute(middleware_spec, resolution)
  rescue
    error ->
      # Sentry.capture_exception(error, __STACKTRACE__)
      IO.warn("Something error at grapql", __STACKTRACE__)
      Absinthe.Resolution.put_result(resolution, @default_error)
  end

  # Handle all the ways middleware can be defined

  defp execute({{module, function}, config}, resolution) do
    apply(module, function, [resolution, config])
  end

  defp execute({module, config}, resolution) do
    apply(module, :call, [resolution, config])
  end

  defp execute(module, resolution) when is_atom(module) do
    apply(module, :call, [resolution, @default_config])
  end

  defp execute(fun, resolution) when is_function(fun, 2) do
    fun.(resolution, @default_config)
  end
end
