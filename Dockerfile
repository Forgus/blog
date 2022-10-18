FROM nginx:stable-alpine

COPY public /root/blog/public
COPY resources /root/blog/resources
COPY nginx/conf.d /etc/nginx/conf.d

EXPOSE 81

CMD ["nginx", "-g", "daemon off;"]
