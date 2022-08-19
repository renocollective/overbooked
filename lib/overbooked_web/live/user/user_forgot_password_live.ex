defmodule OverbookedWeb.UserForgotPasswordLive do
  use OverbookedWeb, :live_view

  alias OverbookedWeb.Router.Helpers, as: Routes
  alias Overbooked.Accounts

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Forgot your password?</h1>

    <.form :let={f} for={:user} phx_submit={:reset} id="forgot-password-form">
      <div class="">
        <label for="email" class="block text-sm font-medium text-gray-700">
          Email address
        </label>
        <div class="mt-1">
          <.text_input form={f} field={:email} required={true} />
          <.error form={f} field={:email} />
        </div>
      </div>
      <div>
        <.button type="submit" phx_disable_with="Sending...">
          Send instructions to reset password
        </.button>
      </div>
    </.form>

    <p>
      <.link navigate={Routes.login_path(@socket, :index)}>Log in</.link>
    </p>
    """
  end

  def handle_event("reset", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &Routes.user_reset_password_url(socket, :index, &1)
      )
    end

    {:noreply,
     socket
     |> put_flash(
       :info,
       "If your email is in our system, you will receive instructions to reset your password shortly."
     )
     |> redirect(to: Routes.login_path(socket, :index))}
  end
end