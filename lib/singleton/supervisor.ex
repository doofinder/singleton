defmodule Singleton.Supervisor do
  @moduledoc """
  Singleton supervisor.
  """

  use DynamicSupervisor

  require Logger

  @init_options [
    :max_restarts,
    :max_seconds,
    :max_children,
    :extra_arguments,
    :strategy
  ]
  @config_options Application.compile_env(:singleton, :dynamic_supervisor, [])

  def start_link(override_opts \\ []) do
    override_opts = Keyword.merge(@config_options, override_opts)
    {init_opts, genserver_opts} = Keyword.split(override_opts, @init_options)

    DynamicSupervisor.start_link(
      __MODULE__,
      init_opts,
      genserver_opts
    )
  end

  @impl true
  def init(init_opts) do
    DynamicSupervisor.init(init_opts)
  end
end
