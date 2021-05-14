FROM jekyll/jekyll:latest
COPY . /srv/jekyll

EXPOSE 4000

ENTRYPOINT [ "jekyll", "serve", "--force_polling", "--drafts", "--trace" ]