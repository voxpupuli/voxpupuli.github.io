all: sponsor-github.png sponsor-hetzner.png sponsor-betadots.png sponsor-babiel.png sponsor-enterprise-modules.png sponsor-docker.png sponsor-puppet.png sponsor-deubert.png sponsor-microsoft.png sponsor-macarne.png sponsor-cern.png sponsor-geant.png sponsor-tiger-computing.png sponsor-arnes.png logo-atix.png logo-blendbyte.png logo-sscg.png logo-nine.png

SPONSOR_LOGO=	300x150
SPONSOR_CANVAS=	320x170

sponsor-%.png:
	convert "$<" -background transparent -resize ${SPONSOR_LOGO} -gravity center -extent ${SPONSOR_CANVAS} "$@"

logo-%.png:
	convert "$<" -background transparent -resize ${SPONSOR_LOGO} -gravity center -extent ${SPONSOR_CANVAS} "$@"
.SUFFIXES: .png .svg

%.png: %.svg
	inkscape -o "$@" "$<"

sponsor-github.png: GitHub_Logo.png

sponsor-hetzner.png: hetzner_cloud_logo.png

sponsor-betadots.png: betadots.png

sponsor-babiel.png: babiel_logo_RGB.png

sponsor-enterprise-modules.png: logo-Enterprise-modules\ SVG.png

sponsor-docker.png: 01-primary-blue-docker-logo.png

sponsor-puppet.png: _puppet_by_perforce-on_light-4k.png

sponsor-deubert.png: deubert_logo.png

sponsor-microsoft.png: RWEDnc.png

sponsor-xyntion.png: xyntion_logo.png

sponsor-macarne.png: Macarne_Logo_wide@3x.png

sponsor-cern.png: CERN_logo.svg

sponsor-geant.png: GEANT_logo_2015.jpg

sponsor-tiger-computing.png: logo-tiger-computing.png

sponsor-arnes.png: Arnes_logo.svg

logo-atix.png: ATIX-Logo_original.png

logo-blendbyte.png: logo_horizontal.svg

logo-sscg.png: sscg_logo.png

logo-nine.png: Nine_Logo+Claim_RGB.png
