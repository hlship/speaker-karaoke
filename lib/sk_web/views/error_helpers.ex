defmodule SkWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  use Phoenix.HTML
  use Phoenix.Component

  @doc """
  Generates a warning panel when the changeset has an action (e.g., fields have errors).
  """
  def form_warning(assigns) do
    ~H"""
      <%= if @enabled do %>
        <div class="bg-red-700 font-bold text-white rounded mb-4 px-2">
          <p>Please correct the errors below.</p>
        </div>
      <% end %>
      """
  end

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:p, translate_error(error),
        class: "mt-4 text-white font-bold rounded bg-red-700 px-2 initial-caps",
        phx_feedback_for: input_name(form, field))
    end)
  end


  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(SkWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(SkWeb.Gettext, "errors", msg, opts)
    end
  end
end
