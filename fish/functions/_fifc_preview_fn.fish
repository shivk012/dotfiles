function _fifc_preview_fn -d "Preview the function definition"
    if type -q bat
        type $fifc_candidate | bat --color=always --language fish $fifc_bat_opts
    else
        type $fifc_candidate | fish -c set_color yellow
        functions -D {}
        set_color normal
        echo
        functions {} --preview-window=right:65%:wrap
    end
end
