function autopush
    git add -A
    git commit -m "$argv"
    git push
end
