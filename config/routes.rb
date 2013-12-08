Breakingnews::Application.routes.draw do
  root to: "stories#static"
  resources "stories", only: [:index]
end