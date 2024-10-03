# Use Ubuntu 14.04 as the base image
FROM ubuntu:14.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    git \
    python-cups \
    python-dateutil \
    python-decorator \
    python-docutils \
    python-feedparser \
    python-gdata \
    python-geoip \
    python-gevent \
    python-imaging \
    python-jinja2 \
    python-ldap \
    python-libxslt1 \
    python-lxml \
    python-mako \
    python-mock \
    python-openid \
    python-passlib \
    python-psutil \
    python-psycopg2 \
    python-pybabel \
    python-pychart \
    python-pydot \
    python-pyparsing \
    python-pypdf \
    python-reportlab \
    python-requests \
    python-simplejson \
    python-tz \
    python-unicodecsv \
    python-unittest2 \
    python-vatnumber \
    python-vobject \
    python-werkzeug \
    python-xlwt \
    python-yaml \
    wget

# Install wkhtmltopdf
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
RUN dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb || true
RUN apt-get -f install -y
RUN dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb

# Create Odoo user
RUN adduser --system --home=/opt/odoo --group odoo

# Install Odoo
RUN git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0 --single-branch /opt/odoo
RUN chown -R odoo:odoo /opt/odoo

# Copy Odoo configuration file
COPY ./odoo-server.conf /etc/odoo-server.conf
RUN chown odoo:odoo /etc/odoo-server.conf && chmod 640 /etc/odoo-server.conf

# Create log directory
RUN mkdir -p /var/log/odoo
RUN chown odoo:odoo /var/log/odoo

# Expose Odoo port
EXPOSE 8069

# Switch to odoo user
USER odoo

# Set the default command to run Odoo
CMD ["/opt/odoo/openerp-server", "-c", "/etc/odoo-server.conf"]