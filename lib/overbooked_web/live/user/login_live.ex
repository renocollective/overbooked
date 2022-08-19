defmodule OverbookedWeb.LoginLive do
  use OverbookedWeb, :live_view

  alias OverbookedWeb.Router.Helpers, as: Routes

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Log in</h1>

    <.form let={f} action={Routes.user_session_path(@socket, :create)} for={:user} id="login-form">
      <.form_field
        type="email_input"
        form={f}
        required={true}
        field={:email}
        label="Email address"
        aria_label="Email address"
      />
      <.form_field
        type="password_input"
        form={f}
        required={true}
        field={:password}
        label="Password"
        aria_label="Password"
        value={input_value(f, :password)}
      />
      <.form_field
        type="checkbox"
        form={f}
        field={:remember_me}
        label="Keep me logged in for 60 days"
        aria_label="Keep me logged in for 60 days"
      />

      <div>
        <.button label="Login" type="submit" phx_disable_with="Logging..." />
      </div>
    </.form>

    <p>
      <.link to={Routes.login_path(@socket, :index)}>Log in</.link>
      |
      <.link to={Routes.user_forgot_password_path(@socket, :index)}>Forgot your password?</.link>
    </p>
    """
  end
end
