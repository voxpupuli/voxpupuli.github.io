all: sponsor-github.png sponsor-hetzner.png sponsor-hoenscheiditconsulting.png sponsor-betadots.png sponsor-babiel.png sponsor-enterprise-modules.png

SPONSOR_LOGO=	300x150
SPONSOR_CANVAS=	320x170

sponsor-%.png:
	convert "$<" -background transparent -resize ${SPONSOR_LOGO} -gravity center -extent ${SPONSOR_CANVAS} "$@"

.SUFFIXES: .png .svg

%.png: %.svg
	inkscape -o "$@" "$<"

sponsor-github.png: GitHub_Logo.png

sponsor-hetzner.png: hetzner_cloud_logo.png

sponsor-hoenscheiditconsulting.png: hoenscheiditconsulting.png

sponsor-betadots.png: betadots.png

sponsor-babiel.png: babiel_logo_RGB.png

sponsor-enterprise-modules.png: logo-Enterprise-modules\ SVG.png
