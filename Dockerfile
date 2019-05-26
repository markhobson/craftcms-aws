FROM blackpepper/craftcms:2

ADD dist /var/www/html
ADD src/templates /var/www/craft/templates
