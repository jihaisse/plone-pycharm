#! /bin/bash

I18NDOMAIN=${i18n_domain}

# creation des langues. Ajoutez les langues voulues dans le tableau
langues="${languages}"
for lang in ${DS}{langues}; do
    mkdir -p locales/${DS}{lang}/LC_MESSAGES
    touch locales/${DS}{lang}/LC_MESSAGES/${DS}{I18NDOMAIN}.po
    touch locales/${DS}{lang}/LC_MESSAGES/plone.po
done

# creation du fichier .pot
touch locales/${DS}{I18NDOMAIN}.pot
touch locales/manual.pot
touch locales/plone.pot

# Synchronise the templates and scripts with the .pot.
# All on one line normally:
i18ndude rebuild-pot --pot locales/${DS}{I18NDOMAIN}.pot \
    --create ${DS}{I18NDOMAIN} \
    --merge locales/manual.pot \
    .

# Synchronise the resulting .pot with all .po files
for po in locales/*/LC_MESSAGES/${DS}{I18NDOMAIN}.po; do
    i18ndude sync --pot locales/${DS}{I18NDOMAIN}.pot ${DS}{po}
done

for po in locales/*/LC_MESSAGES/plone.po; do
    i18ndude sync --pot locales/plone.pot ${DS}{po}
done

# Compile all .po in .mo
for po in ${DS}(find . -path '*/LC_MESSAGES/*.po'); do
   msgfmt -o ${DS}{po/%po/mo} ${DS}{po}
done
