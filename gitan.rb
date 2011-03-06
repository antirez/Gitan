def ue(s)
    URI::escape s
end

def he(s)
    ERB::Util::html_escape s
end
