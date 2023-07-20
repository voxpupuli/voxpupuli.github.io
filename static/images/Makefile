all: sponsor-github.png sponsor-hetzner.png sponsor-hoenscheiditconsulting.png sponsor-betadots.png sponsor-babiel.png sponsor-enterprise-modules.png

SPONSOR_LOGO=	300x150
SPONSOR_CANVAS=	320x170

sponsor-github.png: GitHub_Logo.png
	convert GitHub_Logo.png -background transparent -resize ${SPONSOR_LOGO} -gravity center -extent ${SPONSOR_CANVAS}  sponsor-github.png

sponsor-hetzner.png: hetzner.png
	convert hetzner.png -background transparent -resize ${SPONSOR_LOGO} -gravity center -extent ${SPONSOR_CANVAS}  sponsor-hetzner.png

sponsor-hoenscheiditconsulting.png: hoenscheiditconsulting.png
	convert hoenscheiditconsulting.png -background transparent -resize ${SPONSOR_LOGO} -gravity center -extent ${SPONSOR_CANVAS}  sponsor-hoenscheiditconsulting.png

sponsor-betadots.png: betadots.png
	convert betadots.png -background transparent -resize ${SPONSOR_LOGO} -gravity center -extent ${SPONSOR_CANVAS}  sponsor-betadots.png

sponsor-babiel.png: babiel_logo_RGB.png
	convert babiel_logo_RGB.png -background transparent -resize ${SPONSOR_LOGO} -gravity center -extent ${SPONSOR_CANVAS}  sponsor-babiel.png

sponsor-enterprise-modules.png: logo-Enterprise-modules\ SVG.png
	convert "logo-Enterprise-modules SVG.png" -background transparent -resize ${SPONSOR_LOGO} -gravity center -extent ${SPONSOR_CANVAS}  sponsor-enterprise-modules.png

hetzner_cloud_logo.png: hetzner_cloud_logo.svg
	inkscape -o hetzner_cloud_logo.png hetzner_cloud_logo.svg

babiel_logo_RGB.png: babiel_logo_RGB.svg
	inkscape -o babiel_logo_RGB.png babiel_logo_RGB.svg

logo-Enterprise-modules\ SVG.png: logo-Enterprise-modules\ SVG.svg
	inkscape -o "logo-Enterprise-modules SVG.png" "logo-Enterprise-modules SVG.svg"
