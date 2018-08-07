defmodule AlumniBook do
  @moduledoc false

  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the Ecto repository
      supervisor(AlumniBook.Repo, []),
      # Start the endpoint when the application starts
      supervisor(AlumniBookWeb.Endpoint, [])
      # Here you could define other workers and supervisors as children
      # worker(AlumniBook.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AlumniBook.Supervisor]
    main_supervisor = Supervisor.start_link(children, opts)

    Ecto.Migrator.up(
      AlumniBook.Repo,
      20_180_608_213_034,
      AlumniBook.Migration.CreateUsers
    )

    main_supervisor
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AlumniBookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
