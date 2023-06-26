# Ref: https://github.com/paper-trail-gem/paper_trail#1e-configuration
PaperTrail.config do
  enabled = true

  has_paper_trail_defaults = {
    on: %i[create update destroy]
  }
end
