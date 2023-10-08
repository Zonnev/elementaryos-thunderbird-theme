#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

set -e

GITHUB_BRANCH_NAME="main"
GITHUB_PROJECT_NAME="Zonnev/elementaryos-thunderbird-theme"
GITHUB_URL="https://github.com"
GITHUB_URL_RAW="https://raw.githubusercontent.com"

function getFlatpakProcessIdCommand {
  local FLATPAK_ID="${1}"
  echo "flatpak ps --columns=pid,application | grep \"${FLATPAK_ID}\" | cut -f1"
}

declare -a APPLICATIONS
declare -A APPLICATIONS_PROCESS_ID
declare -A APPLICATIONS_PROFILES_ROOTS

DEFAULT_APPLICATION="🐦 Thunderbird"

APPLICATION="${DEFAULT_APPLICATION}"
APPLICATIONS+=("${APPLICATION}")
APPLICATIONS_PROCESS_ID["${APPLICATION}"]='pidof "thunderbird" || exit 0'
APPLICATIONS_PROFILES_ROOTS["${APPLICATION}"]="${HOME}/.thunderbird"

FLATPAK_ID="org.mozilla.Thunderbird"
APPLICATION="🐦 Thunderbird (📦 Flatpak)"
APPLICATIONS+=("${APPLICATION}")
APPLICATIONS_PROCESS_ID["${APPLICATION}"]="$(getFlatpakProcessIdCommand "${FLATPAK_ID}")"
APPLICATIONS_PROFILES_ROOTS["${APPLICATION}"]="${HOME}/.var/app/${FLATPAK_ID}/.thunderbird"

declare -a LAYOUTS
declare -A LAYOUTS_PATHS
declare -A LAYOUTS_SETTINGS
declare -A LAYOUTS_TITLEBARS

LAYOUT="Elementary"
LAYOUTS+=("${LAYOUT}")
LAYOUTS_PATHS["${LAYOUT}"]="Elementary"
LAYOUTS_SETTINGS["${LAYOUT}"]="'close:maximize'"
LAYOUTS_TITLEBARS["${LAYOUT}"]="[⨯    —    ⤢]"

LAYOUT="Elementary Reversed"
LAYOUTS+=("${LAYOUT}")
LAYOUTS_PATHS["${LAYOUT}"]="Elementary%20Reversed"
LAYOUTS_SETTINGS["${LAYOUT}"]="'maximize:close'"
LAYOUTS_TITLEBARS["${LAYOUT}"]="[⤢    —    ⨯]"

LAYOUT="Close Only Left"
LAYOUTS+=("${LAYOUT}")
LAYOUTS_PATHS["${LAYOUT}"]="Close%20Only%20Left"
LAYOUTS_SETTINGS["${LAYOUT}"]="'close:'"
LAYOUTS_TITLEBARS["${LAYOUT}"]="[⨯    —     ]"

LAYOUT="Close Only Right"
LAYOUTS+=("${LAYOUT}")
LAYOUTS_PATHS["${LAYOUT}"]="Close%20Only%20Right"
LAYOUTS_SETTINGS["${LAYOUT}"]="':close'"
LAYOUTS_TITLEBARS["${LAYOUT}"]="[     —    ⨯]"

LAYOUT="Minimize Left"
LAYOUTS+=("${LAYOUT}")
LAYOUTS_PATHS["${LAYOUT}"]="Minimize%20Left"
LAYOUTS_SETTINGS["${LAYOUT}"]="'close,minimize:maximize'"
LAYOUTS_TITLEBARS["${LAYOUT}"]="[⨯⤓   —    ⤢]"

LAYOUT="Minimize Right"
LAYOUTS+=("${LAYOUT}")
LAYOUTS_PATHS["${LAYOUT}"]="Minimize%20Right"
LAYOUTS_SETTINGS["${LAYOUT}"]="'close:minimize,maximize'"
LAYOUTS_TITLEBARS["${LAYOUT}"]="[⨯    —   ⤓⤢]"

LAYOUT="MacOS"
LAYOUTS+=("${LAYOUT}")
LAYOUTS_PATHS["${LAYOUT}"]="macOS"
LAYOUTS_SETTINGS["${LAYOUT}"]="'close,minimize,maximize'"
LAYOUTS_TITLEBARS["${LAYOUT}"]="[⨯⤓⤢  —     ]"

LAYOUT="Ubuntu"
LAYOUTS+=("${LAYOUT}")
LAYOUTS_PATHS["${LAYOUT}"]="Ubuntu"
LAYOUTS_SETTINGS["${LAYOUT}"]="'close,maximize,minimize'"
LAYOUTS_TITLEBARS["${LAYOUT}"]="[⨯⤢⤓  —     ]"

LAYOUT="Windows"
LAYOUTS+=("${LAYOUT}")
LAYOUTS_PATHS["${LAYOUT}"]="Windows"
LAYOUTS_SETTINGS["${LAYOUT}"]="':minimize,maximize,close'"
LAYOUTS_TITLEBARS["${LAYOUT}"]="[     —  ⤓⤢⨯]"

LAYOUT="Replace Maximize to Minimize"
LAYOUTS+=("${LAYOUT}")
LAYOUTS_PATHS["${LAYOUT}"]="Replace%20Maximize%20to%20Minimize"
LAYOUTS_SETTINGS["${LAYOUT}"]="'close:minimize'"
LAYOUTS_TITLEBARS["${LAYOUT}"]="[⨯    —    ⤓]"

APP_EXECUTABLE="install.sh"
APP_NAME="🐦 Thunderbird Elementary Theme installation"
APP_HELP_MESSAGE="Installation script is recommended to install 🐦 Thunderbird Elementary Theme.

Theme is set of stylesheets ('userChrome.css' file). To apply theme, stylesheets
need to be placed at 'chrome' directory inside user profile. That is what
installation script will do.

Using custom stylesheets also requires preference
'toolkit.legacyUserProfileCustomizations.stylesheets' to be enabled. By default
it is turned off, so installation script will turn it on. Changing  preference
value requires no active application processes, so installation script ma ask user
to close application windows.

Theme requires different stylesheets depending on window controls layout. Window
controls layout defines which of buttons (⨯⤓⤢) will be placed at window title
bar, and how these buttons will placed (left or right, in which order).
Installation script will detect current window controls layout and select
corresponding stylesheets. Detection requires gsetting
(https://www.linux.org/docs/man1/gsettings.html) to be installed.
Window controls layout may be changed with Pantheon Tweaks application
(${GITHUB_URL}/pantheon-tweaks/pantheon-tweaks).

Supported window controls layouts are:

$(
  for INDEX in "${!LAYOUTS[@]}"; do
    LAYOUT="${LAYOUTS[${INDEX}]}"
    TITLEBAR="${LAYOUTS_TITLEBARS[${LAYOUT}]}"
    printf "%3s. %-30s %s\n" "$((INDEX + 1))" "${LAYOUT}" "${TITLEBAR}"
  done
)

Installation script will select corresponding stylesheet.

Installation script supports:

$(
  for INDEX in "${!APPLICATIONS[@]}"; do
    printf "%3s. %s\n" "$((INDEX + 1))" "${APPLICATIONS[${INDEX}]}"
  done
)

For best experience with theme it is recommended to use ${DEFAULT_APPLICATION}.
Other installations has limited support. We welcome contributions like editing
a 'userChrome.css', for example to make a fully supported 📦 Flatpak version
possible. Thanks in advance.

Theme homepage ${GITHUB_URL}/${GITHUB_PROJECT_NAME}
Theme issues ${GITHUB_URL}/${GITHUB_PROJECT_NAME}/issues

Usage: ${APP_EXECUTABLE} [OPTIONS]

OPTIONS:

-h, --help

  Print this help message and exit.

  Example: ${APP_EXECUTABLE} -h
  Example: ${APP_EXECUTABLE} --help

--application-profile <profile_path>

  Install theme to specified thunderbird profile only. Multiple profiles may
  be specified.

  Example: ${APP_EXECUTABLE} --application-profile /profile
  Example: ${APP_EXECUTABLE} --application-profile /first/profile --application-profile /second/profile

--controls-layout <layout>

  Forces installation of theme for specified window controls layout. Layout may
  be specified by name or number. By default installation script will detect
  window controls layout, this option disables auto-detection.

  Example: ${APP_EXECUTABLE} --controls-layout 'Elementary Reversed'
  Example: ${APP_EXECUTABLE} --controls-layout 2

--github-branch-name <branch>

  Overrides theme branch name at ${GITHUB_URL}. Instalation script will copy theme
  stylesheets using this branch name. By default it is ${GITHUB_BRANCH_NAME}.
  This options is useful for testing purposes.

  Example: ${APP_EXECUTABLE} --github-branch-name '${GITHUB_BRANCH_NAME}'

--github-project-name <project>

  Overrides theme project name at ${GITHUB_URL}. Instalation script will copy theme
  stylesheets using this project name. By default it is ${GITHUB_PROJECT_NAME}.
  This options is useful for testing purposes.

  Example: ${APP_EXECUTABLE} --github-project-name '${GITHUB_PROJECT_NAME}'

--skip-preferences-patch

  Disables patching of 'toolkit.legacyUserProfileCustomizations.stylesheets' preference.
  This preference must be turned on to use theme stylesheets. Script default behaviour is
  turn this preference on if not yet.

  Patching application preferences requires no application process to be running. By
  default script will ask user to shut down all application windows before patching
  preferences, so when this option is used, script won't ask user to close application
  windows.

  Example: ${APP_EXECUTABLE} --skip-preferences-patch

--update

  Enable update mode, in this mode script installs theme stylesheets only at
  application profiles, which contains theme stylesheets already. Profiles without
  stylesheets will be ignored.

  This also enables '--skip-preferences-patch' option.

  Example: ${APP_EXECUTABLE} --update
"

declare -a APPLICATION_PROFILES
APPLICATION_PROFILES=()
CONTROLS_LAYOUT=""
PATCH_PREFERENCES="yes"
UPDATE_ONLY="no"

LOG_PADDING=""

function increaseLogPadding {
  LOG_PADDING="${LOG_PADDING}  "
}

function decreaseLogPadding {
  LOG_PADDING="${LOG_PADDING:0:-2}"
}

function info {
  local MESSAGE="${@}"
  echo "${LOG_PADDING}${MESSAGE}"
}

function error {
  local MESSAGE="${@}"
  echo "${LOG_PADDING}${MESSAGE}" >&2
}

function replaceHomedir {
  local DIR="${@}"
  if [ "${DIR:0:${#HOME}}" == "${HOME}" ]; then
    echo "~${DIR:${#HOME}}"
  else
    echo "${DIR}"
  fi
}

function parseWindowControlsLayout {
  local LAYOUT="${1}"
  for INDEX in "${!LAYOUTS[@]}"; do
    if [ $((${INDEX} + 1)) == "${LAYOUT}" ]; then
      echo "${LAYOUTS[${INDEX}]}"
      break
    fi
    if [ "${LAYOUTS[${INDEX}]}" == "${LAYOUT}" ]; then
      echo "${LAYOUT}"
      break
    fi
  done
}

function parseOptions {
  while [ $# -ne 0 ]; do
    case "${1}" in
    "-h" | "--help")
      info "${APP_HELP_MESSAGE}"
      exit 0
      ;;

    "--application-profile")
      APPLICATION_PROFILES+=("${2}")
      shift 2
      ;;

    "--controls-layout")
      case "${2}" in
      # empty string
      "" | "--"*)
        error "💥 Controls layout is not specified."
        error "❓ Try '${APP_EXECUTABLE} --help' to see available controls layouts."
        exit 1
        ;;

      # not a number
      *[!0-9]*)
        CONTROLS_LAYOUT="$(parseWindowControlsLayout "${2}")"
        if [ -z "${CONTROLS_LAYOUT}" ]; then
          error "💥 Unknown controls layout '${2}' is specified."
          error "❓ Try '${APP_EXECUTABLE} --help' to see available controls layouts."
          exit 1
        fi
        shift 2
        ;;

      # number
      *)
        CONTROLS_LAYOUT="$(parseWindowControlsLayout "${2}")"
        if [ -z "${CONTROLS_LAYOUT}" ]; then
          error "💥 Unknown controls layout number '${2}' is specified."
          error "❓ Try '${APP_EXECUTABLE} --help' to see available controls layouts."
          exit 1
        fi
        shift 2
        ;;
      esac
      ;;

    "--github-branch-name")
      GITHUB_BRANCH_NAME="${2}"
      shift 2
      ;;

    "--github-project-name")
      GITHUB_PROJECT_NAME="${2}"
      shift 2
      ;;

    "--skip-preferences-patch")
      PATCH_PREFERENCES="no"
      shift
      ;;

    "--update")
      PATCH_PREFERENCES="no"
      UPDATE_ONLY="yes"
      shift
      ;;

    *)
      error "💥 Unknown option: ${1}"
      error "❓ Try '${APP_EXECUTABLE} --help' to see available options."
      exit 1
      ;;
    esac
  done
}

function detectApplicationsProfiles {
  function filterApplicationProfiles {
    if [ "${UPDATE_ONLY}" == "yes" ]; then
      while IFS='$\n' read -r APPLICATION_PROFILE; do
        if [ -d "${APPLICATION_PROFILE}/chrome" ] && [ -f "${APPLICATION_PROFILE}/chrome/userChrome.css" ]; then
          echo "${APPLICATION_PROFILE}"
        fi
      done
    else
      cat
    fi
  }

  function findApplicationProfiles {
    local FIREFOX_DIR="${1}"
    if [ -d "${FIREFOX_DIR}" ]; then
      PROFILES_FILE="${FIREFOX_DIR}/profiles.ini"
      if [ -f "${PROFILES_FILE}" ]; then
        grep -E "^Path=" "${PROFILES_FILE}" |
          cut -d "=" -f2- |
          xargs -I '{}' echo "${FIREFOX_DIR}/{}"
      else
        find "${FIREFOX_DIR}" -mindepth 1 -maxdepth 1 -type d
      fi
    fi
  }

  if [ ${#APPLICATION_PROFILES[@]} -eq 0 ]; then
    OLD_IFS="${IFS}"
    IFS=$'\n'

    info "🔍 Searching for application profiles:"
    increaseLogPadding
    for APPLICATION in "${APPLICATIONS[@]}"; do
      declare -a FOUND_PROFILES
      FOUND_PROFILES=()
      for APPLICATION_PROFILES_ROOT in ${APPLICATIONS_PROFILES_ROOTS["${APPLICATION}"]}; do
        FOUND_PROFILES+=($(findApplicationProfiles "${APPLICATION_PROFILES_ROOT}" | filterApplicationProfiles))
      done
      if [ "${#FOUND_PROFILES[@]}" -gt 0 ]; then
        if [ "${#FOUND_PROFILES[@]}" -eq 1 ]; then
          info "✅ Found ${APPLICATION} profile:"
        else
          info "✅ Found ${APPLICATION} profiles:"
        fi
        increaseLogPadding
        for FOUND_PROFILE in "${FOUND_PROFILES[@]}"; do
          info "📁 $(replaceHomedir ${FOUND_PROFILE})"
        done
        decreaseLogPadding
        APPLICATION_PROFILES+=("${FOUND_PROFILES[@]}")
      fi
    done
    decreaseLogPadding
    IFS="${OLD_IFS}"
  fi

  if [ "${#APPLICATION_PROFILES[@]}" -eq 0 ]; then
    error "💥 Unable to detect applications profiles."
    error "💥 Please, specify profiles with '--application-profile' option."
    error "❓ Try '${APP_EXECUTABLE} --help' to see manual."
    exit 1
  fi
}

function installThemeAtApplicationProfile {
  function detectApplication {
    local APPLICATION_PROFILE="${1}"
    for APPLICATION in "${APPLICATIONS[@]}"; do
      for APPLICATION_PROFILES_ROOT in ${APPLICATIONS_PROFILES_ROOTS["${APPLICATION}"]}; do
        APPLICATION_PROFILES_ROOT="${APPLICATION_PROFILES_ROOT}/"
        if [ "${APPLICATION_PROFILE:0:${#APPLICATION_PROFILES_ROOT}}" == "${APPLICATION_PROFILES_ROOT}" ]; then
          echo "${APPLICATION}"
          return 0
        fi
      done
    done
    echo "${DEFAULT_APPLICATION}"
  }

  function getThunderbirdPreference {
    local APPLICATION_PROFILE="${1}"
    local PREFERENCES_FILE="${APPLICATION_PROFILE}/prefs.js"

    if [ -f "${PREFERENCES_FILE}" ]; then
      local PREFERENCE="${2}"
      local MATCH=$(
        grep "user_pref(\"${PREFERENCE}\"," "${PREFERENCES_FILE}" || echo ""
      )
      if [ ! -z "${MATCH}" ]; then
        local CURRENT_VALUE="${MATCH:$((14 + ${#PREFERENCE})):-2}"
        echo "${CURRENT_VALUE}"
      else
        echo ""
      fi
    fi
  }

  function setThunderbirdPreference {
    local APPLICATION_PROFILE="${1}"
    local PREFERENCES_FILE="${APPLICATION_PROFILE}/prefs.js"
    local APPLICATION=$(detectApplication "${APPLICATION_PROFILE}")
    local PREFERENCE="${2}"
    local CURRENT_VALUE=$(getThunderbirdPreference "${PREFERENCE}")
    local TARGET_VALUE="${3}"

    if [ "${TARGET_VALUE}" == "${CURRENT_VALUE}" ]; then
      return 0
    fi

    info "📝 Changing preference '${PREFERENCE}' to '${TARGET_VALUE}'"

    if [ ! -z "$(bash -c "${APPLICATIONS_PROCESS_ID[${APPLICATION}]}")" ]; then
      info "❓ Please, close ${APPLICATION} windows to proceed ...."
      while [ ! -z "$(bash -c "${APPLICATIONS_PROCESS_ID[${APPLICATION}]}")" ]; do
        sleep 1
      done
    fi

    increaseLogPadding

    local LINE_NUMBER=""

    if [ -f "${PREFERENCES_FILE}" ]; then
      LINE_NUMBER=$(grep -n "user_pref(\"${PREFERENCE}\"," "${PREFERENCES_FILE}" | cut -d':' -f1)
    fi

    if [ -z "${LINE_NUMBER}" ]; then
      echo "user_pref(\"${PREFERENCE}\", ${TARGET_VALUE});" >>"${PREFERENCES_FILE}"
    else
      sed -i "${LINE_NUMBER}s/.*/user_pref(\"${PREFERENCE}\", "${TARGET_VALUE}");/" "${PREFERENCES_FILE}"
    fi

    decreaseLogPadding
  }

  function delectControlsLayout {
    if [ -z "${CONTROLS_LAYOUT}" ]; then
      if ! (which gsettings >/dev/null); then
        error "💥 Unable to detect window controls layout. Util gsettings is not installed."
        error "💥 Please, install gsettings or specify layout with '--controls-layout' option."
        error "❓ Try '${APP_EXECUTABLE} --help' to see manual."
        exit 1
      fi

      local GALA_BUTTON_LAYOUT="$(gsettings get org.pantheon.desktop.gala.appearance button-layout)"
      local WM_BUTTON_LAYOUT="$(gsettings get org.gnome.desktop.wm.preferences button-layout)"
      local BUTTON_LAYOUT=""

      if [ ! -z "${GALA_BUTTON_LAYOUT}" ]; then
        BUTTON_LAYOUT="${GALA_BUTTON_LAYOUT}"
      elif [ ! -z "${WM_BUTTON_LAYOUT}" ]; then
        BUTTON_LAYOUT="${GALA_BUTTON_LAYOUT}"
      fi

      if [ ! -z "${BUTTON_LAYOUT}" ]; then
        for LAYOUT in "${!LAYOUTS_SETTINGS[@]}"; do
          if [ "${BUTTON_LAYOUT}" == "${LAYOUTS_SETTINGS[${LAYOUT}]}" ]; then
            CONTROLS_LAYOUT="${LAYOUT}"
            break
          fi
        done
      fi

      if [ -z "${CONTROLS_LAYOUT}" ]; then
        error "💥 Unable to detect window controls layout."
        error "💥 Please, specify layout with '--controls-layout' option."
        error "❓ Try '${APP_EXECUTABLE} --help' to see manual."
        exit 1
      fi
    fi
  }

  function getApplicationUsesLegacyStylesheets {
    local APPLICATION_PROFILE="${1}"
    local CURRENT_VALUE=$(
      getThunderbirdPreference "${APPLICATION_PROFILE}" \
        "toolkit.legacyUserProfileCustomizations.stylesheets"
    )
    case "${CURRENT_VALUE}" in
    "true")
      echo "yes"
      ;;
    "false")
      echo "no"
      ;;
    *)
      echo "no"
      ;;
    esac
  }

  function setApplicationUsesLegacyStylesheets {
    local APPLICATION_PROFILE="${1}"
    local CURRENT_VALUE=$(getApplicationUsesLegacyStylesheets "${APPLICATION_PROFILE}")
    local TARGET_VALUE="yes"

    if [ "${TARGET_VALUE}" == "${CURRENT_VALUE}" ]; then
      return 0
    fi

    setThunderbirdPreference "${APPLICATION_PROFILE}" \
      "toolkit.legacyUserProfileCustomizations.stylesheets" "true"
  }

  function getApplicationVersion {
    local APPLICATION_PROFILE="${1}"
    local CURRENT_VALUE=$(
      getThunderbirdPreference "${APPLICATION_PROFILE}" "extensions.lastAppVersion"
    )

    if [ -z "${CURRENT_VALUE}" ]; then
      echo ""
    else
      echo $(echo "${CURRENT_VALUE}" | cut -d '"' -f 2)
    fi
  }

  function installStyleSheets {
    local APPLICATION="${1}"
    local APPLICATION_PROFILE="${2}"
    local LAYOUT_PATH="${3}"

    local BASE_CSS="base.css"
    local USER_CHROME_CSS="userChrome.css"

    local CHROME_DIR="${APPLICATION_PROFILE}/chrome"
    local BASE_FILE="${CHROME_DIR}/${BASE_CSS}"
    local USER_CHROME_FILE="${CHROME_DIR}/${USER_CHROME_CSS}"

    local FILES_URL="${GITHUB_URL_RAW}/${GITHUB_PROJECT_NAME}/${GITHUB_BRANCH_NAME}"
    local BASE_URL="${FILES_URL}/${BASE_CSS}"
    local USER_CHROME_URL="${FILES_URL}/${LAYOUT_PATH}/${USER_CHROME_CSS}"

    if [ ! -d ${CHROME_DIR} ]; then
      info "✅ Creating 📁 $(replaceHomedir "${CHROME_DIR}")"
      mkdir -p "${CHROME_DIR}"
    fi

    info "⬇️  Downloading ${BASE_CSS} (${BASE_URL})"
    wget --output-document="${BASE_FILE}" --quiet "${BASE_URL}"

    info "⬇️  Downloading ${USER_CHROME_CSS} (${USER_CHROME_URL})"
    wget --output-document="${USER_CHROME_FILE}" --quiet "${USER_CHROME_URL}"
  }

  local APPLICATION_PROFILE="${1}"
  local APPLICATION=$(detectApplication "${APPLICATION_PROFILE}")

  info "🔧 Installing theme at ${APPLICATION} profile 📁 $(replaceHomedir ${APPLICATION_PROFILE})"
  increaseLogPadding

  if [ "${PATCH_PREFERENCES}" == "yes" ]; then
    setApplicationUsesLegacyStylesheets "${APPLICATION_PROFILE}" "yes"
  fi

  delectControlsLayout
  installStyleSheets "${APPLICATION}" "${APPLICATION_PROFILE}" "${LAYOUTS_PATHS[${CONTROLS_LAYOUT}]}"

  decreaseLogPadding
}

info "${APP_NAME}"
info ""
parseOptions "${@}"
detectApplicationsProfiles
info ""
for APPLICATION_PROFILE in "${APPLICATION_PROFILES[@]}"; do
  installThemeAtApplicationProfile "${APPLICATION_PROFILE}"
  info ""
done
info "🎉 Done! Please restart the app for the changes to take effect."
