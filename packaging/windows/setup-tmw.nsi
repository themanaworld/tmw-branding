; This script allows the following parameters being overwritten from
; command line. When called without any parameters it behaves exactly
; like the old install script.
;
; DLLDIR - directory containing required dlls
; EXEDIR - directory containing mana.exe
; EXESUFFIX - offset to SRCDIR pointing to a directory containing mana.exe
; PRODUCT_VERSION - software version
; UPX - upx binary name
;
; For a cmake build on UNIX the following should give you a working installer:
; makensis -DDLLDIR=/path/to/dlls \
;    -DPRODUCT_VERSION=0.1.`date +%Y%m%d`
;    -DUPX=upx
;    -DEXESUFFIX=/src
;
; Make sure that README has DOS line endings, and copy it to README.txt

CRCCheck on
SetCompress off
SetCompressor /SOLID lzma

!define SRCDIR "..\.."
!ifndef UPX
    !define "UPX upx\upx.exe"
!endif

!ifdef EXESUFFIX
    !define EXEDIR ${SRCDIR}/${EXESUFFIX}
!endif

!ifndef EXEDIR
    !define EXEDIR ${SRCDIR}
!endif

!ifndef DLLDIR
    !define DLLDIR ${SRCDIR}/dll
!endif

; Uncomment this to set up the branding source folder
!define BRANDINGDIR ${SRCDIR}\..\tmw-branding

;--- (and without !defines ) ---
!System "${UPX} --best --crp-ms=999999 --compress-icons=0 --nrv2d ${EXEDIR}\mana.exe"

; HM NIS Edit helper defines
!ifdef BRANDINGDIR
    !define PRODUCT_NAME "The Mana World"
    !define PRODUCT_NAME_SHORT "tmw"

    !define PRODUCT_PUBLISHER "The Mana Development Team"
    !define PRODUCT_WEB_SITE "http://www.themanaworld.org"

    !define BRANDING_ICON_FILE "tmw.ico"
    !define BRANDING_MANA_FILE "tmw.mana"
!else ; No branding
    !define PRODUCT_NAME "Mana"
    !define PRODUCT_NAME_SHORT "mana"

    !define PRODUCT_PUBLISHER "Mana Development Team"
    !define PRODUCT_WEB_SITE "http://manasource.org"
!endif

!ifndef PRODUCT_VERSION
    !define PRODUCT_VERSION "0.5.0"
!endif

!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\mana.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!ifdef BRANDINGDIR
    !define MUI_ABORTWARNING
    !define MUI_ICON "${BRANDINGDIR}\data\icons\${BRANDING_ICON_FILE}"
    !define MUI_UNICON "${BRANDINGDIR}\data\icons\${BRANDING_ICON_FILE}"
!else
    !define MUI_ABORTWARNING
    !define MUI_ICON "${SRCDIR}\data\icons\mana.ico"
    !define MUI_UNICON "${SRCDIR}\data\icons\mana.ico"
!endif


;Language Selection Dialog Settings
;Remember the installer language
!define MUI_LANGDLL_REGISTRY_ROOT "HKCU"
!define MUI_LANGDLL_REGISTRY_KEY "Software\${PRODUCT_NAME}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

!ifdef BRANDINGDIR
    !define MUI_WELCOMEFINISHPAGE_BITMAP "${BRANDINGDIR}\packaging\windows\setup_welcome.bmp"
    !define MUI_UNWELCOMEFINISHPAGE_BITMAP "${BRANDINGDIR}\packaging\windows\setup_welcome.bmp"
!else
    !define MUI_WELCOMEFINISHPAGE_BITMAP "${SRCDIR}\packaging\windows\setup_welcome.bmp"
    !define MUI_UNWELCOMEFINISHPAGE_BITMAP "${SRCDIR}\packaging\windows\setup_welcome.bmp"
!endif

; Welcome page

!define MUI_WELCOMEPAGE_TITLE_3LINES
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "${SRCDIR}\COPYING"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Components page
!insertmacro MUI_PAGE_COMPONENTS
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_FUNCTION RunMana
!define MUI_FINISHPAGE_SHOWREADME 'notepad.exe "$\"$INSTDIR\README.txt$\""'
!define MUI_PAGE_CUSTOMFUNCTION_PRE changeFinishImage
!define MUI_FINISHPAGE_LINK "Visit our website for the latest news, FAQs and support"
!define MUI_FINISHPAGE_LINK_LOCATION "http://themanaworld.org"
!insertmacro MUI_PAGE_FINISH

Function RunMana
    SetOutPath $INSTDIR
    !ifdef BRANDINGDIR
        Exec "$INSTDIR\mana.exe data\branding\${BRANDING_MANA_FILE}"
    !else
        Exec "$INSTDIR\mana.exe"
    !endif
FunctionEnd

Function changeFinishImage
    !insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 1" "Text" "$PLUGINSDIR\setup_finish.bmp"
FunctionEnd

; Uninstaller pages

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!define MUI_FINISHPAGE_TITLE_3LINES
!insertmacro MUI_UNPAGE_FINISH

;Languages
!insertmacro MUI_LANGUAGE "English" # first language is the default language
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "TradChinese"
!insertmacro MUI_LANGUAGE "Japanese"
!insertmacro MUI_LANGUAGE "Korean"
!insertmacro MUI_LANGUAGE "Italian"
!insertmacro MUI_LANGUAGE "Dutch"
!insertmacro MUI_LANGUAGE "Danish"
!insertmacro MUI_LANGUAGE "Swedish"
!insertmacro MUI_LANGUAGE "Norwegian"
!insertmacro MUI_LANGUAGE "Finnish"
!insertmacro MUI_LANGUAGE "Greek"
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_LANGUAGE "Portuguese"
!insertmacro MUI_LANGUAGE "PortugueseBR"
!insertmacro MUI_LANGUAGE "Polish"
!insertmacro MUI_LANGUAGE "Ukrainian"
!insertmacro MUI_LANGUAGE "Czech"
!insertmacro MUI_LANGUAGE "Slovak"
!insertmacro MUI_LANGUAGE "Croatian"
!insertmacro MUI_LANGUAGE "Bulgarian"
!insertmacro MUI_LANGUAGE "Hungarian"
!insertmacro MUI_LANGUAGE "Thai"
!insertmacro MUI_LANGUAGE "Romanian"
!insertmacro MUI_LANGUAGE "Latvian"
!insertmacro MUI_LANGUAGE "Macedonian"
!insertmacro MUI_LANGUAGE "Estonian"
!insertmacro MUI_LANGUAGE "Turkish"
!insertmacro MUI_LANGUAGE "Lithuanian"
!insertmacro MUI_LANGUAGE "Catalan"
!insertmacro MUI_LANGUAGE "Slovenian"
!insertmacro MUI_LANGUAGE "Serbian"
!insertmacro MUI_LANGUAGE "SerbianLatin"
!insertmacro MUI_LANGUAGE "Arabic"
!insertmacro MUI_LANGUAGE "Farsi"
!insertmacro MUI_LANGUAGE "Hebrew"
!insertmacro MUI_LANGUAGE "Indonesian"
!insertmacro MUI_LANGUAGE "Mongolian"
!insertmacro MUI_LANGUAGE "Luxembourgish"
!insertmacro MUI_LANGUAGE "Albanian"
!insertmacro MUI_LANGUAGE "Breton"
!insertmacro MUI_LANGUAGE "Belarusian"
!insertmacro MUI_LANGUAGE "Icelandic"
!insertmacro MUI_LANGUAGE "Malay"
!insertmacro MUI_LANGUAGE "Bosnian"
!insertmacro MUI_LANGUAGE "Kurdish"

!insertmacro MUI_RESERVEFILE_LANGDLL

ReserveFile "setup_finish.bmp"


; MUI end ------


Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME_SHORT}-${PRODUCT_VERSION}-win32.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show


Function .onInit
    !insertmacro MUI_LANGDLL_DISPLAY
    InitPluginsDir
    !ifdef BRANDINGDIR
        File /oname=$PLUGINSDIR\setup_finish.bmp "${BRANDINGDIR}\packaging\windows\setup_finish.bmp"
    !else
        File /oname=$PLUGINSDIR\setup_finish.bmp "${SRCDIR}\packaging\windows\setup_finish.bmp"
    !endif
FunctionEnd


Section "Core files (required)" SecCore
    SectionIn RO
    SetOutPath "$INSTDIR"
    SetOverwrite ifnewer
    CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
    !ifdef BRANDINGDIR
        CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\mana.exe" "data\branding\${BRANDING_MANA_FILE}" "$INSTDIR\data\branding\data\icons\${BRANDING_ICON_FILE}"
        CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\mana.exe" "data\branding\${BRANDING_MANA_FILE}" "$INSTDIR\data\branding\data\icons\${BRANDING_ICON_FILE}"

        ; Add additional branding dir
        CreateDirectory "$INSTDIR\data\branding"
        CreateDirectory "$INSTDIR\data\branding\data"
        CreateDirectory "$INSTDIR\data\branding\data\graphics"
        CreateDirectory "$INSTDIR\data\branding\data\help"
        CreateDirectory "$INSTDIR\data\branding\data\icons"
        CreateDirectory "$INSTDIR\data\branding\data\graphics\images"
        CreateDirectory "$INSTDIR\data\branding\data\graphics\gui"
        CreateDirectory "$INSTDIR\data\branding\data\graphics\gui\wood"
    !else
        CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\mana.exe"
        CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\mana.exe"
    !endif

    CreateDirectory "$INSTDIR\data"
    CreateDirectory "$INSTDIR\data\fonts"
    CreateDirectory "$INSTDIR\data\graphics"
    CreateDirectory "$INSTDIR\data\help"
    CreateDirectory "$INSTDIR\data\icons"
    CreateDirectory "$INSTDIR\data\graphics\gui"
    CreateDirectory "$INSTDIR\data\graphics\images"
    CreateDirectory "$INSTDIR\data\graphics\sprites"
    CreateDirectory "$INSTDIR\docs"


    SetOverwrite ifnewer
    SetOutPath "$INSTDIR"

    File "${EXEDIR}\mana.exe"
    File "${DLLDIR}\*.dll"
    File "${SRCDIR}\AUTHORS"
    File "${SRCDIR}\COPYING"
    File "${SRCDIR}\NEWS"
    File "${SRCDIR}\README.txt"
    SetOutPath "$INSTDIR\data\fonts"
    File "${SRCDIR}\data\fonts\*.ttf"
    SetOutPath "$INSTDIR\data\graphics\gui"
    File "${SRCDIR}\data\graphics\gui\*.png"
    File "${SRCDIR}\data\graphics\gui\*.xml"
    SetOutPath "$INSTDIR\data\graphics\images"
    File /x minimap_*.png ${SRCDIR}\data\graphics\images\*.png
    SetOutPath "$INSTDIR\data\graphics\sprites"
    File "${SRCDIR}\data\graphics\sprites\*.png"
    File "${SRCDIR}\data\graphics\sprites\*.xml"
    SetOutPath "$INSTDIR\data\help"
    File "${SRCDIR}\data\help\*.txt"
    SetOutPath "$INSTDIR\data\icons\"
    File "${SRCDIR}\data\icons\mana.ico"
    SetOutPath "$INSTDIR\docs"
    File "${SRCDIR}\docs\FAQ.txt"

    !ifdef BRANDINGDIR
        SetOutPath "$INSTDIR\data\branding"
        File "${BRANDINGDIR}\${BRANDING_MANA_FILE}"
        SetOutPath "$INSTDIR\data\branding\data\icons"
        File "${BRANDINGDIR}\data\icons\*.*"
        SetOutPath "$INSTDIR\data\branding\data\help"
        File "${BRANDINGDIR}\data\help\*.txt"
        SetOutPath "$INSTDIR\data\branding\data\graphics\images"
        File "${BRANDINGDIR}\data\graphics\images\*.png"
        SetOutPath "$INSTDIR\data\branding\data\graphics\gui\wood"
        File "${BRANDINGDIR}\data\graphics\gui\wood\*.png"
        File "${BRANDINGDIR}\data\graphics\gui\wood\*.xml"
    !endif
SectionEnd


Section /o "Music" SecMusic
    AddSize 17602
    CreateDirectory "$INSTDIR\data\music"
    SetOutPath "$INSTDIR\data\music"
    NSISdl::download "http://downloads.sourceforge.net/themanaworld/tmwmusic-0.2.tar.gz" "$TEMP\tmwmusic-0.2.tar.gz"

    ; !! Requires an additional plugin from http://nsis.sourceforge.net/UnTGZ_plug-in  Place untgz.dll in your nsis/plugin dir
    untgz::extract -j -d "$INSTDIR\data\music" "$TEMP\tmwmusic-0.2.tar.gz"
    Delete "$TEMP\tmwmusic-0.2.tar.gz"
SectionEnd


Section /o "Portable" SecPortable
    SetOutPath "$INSTDIR"
    File "portable.xml"
SectionEnd


Section "Translations" SecTrans
    SetOutPath "$INSTDIR"
    File /nonfatal /r "${SRCDIR}\translations"
SectionEnd


;Package descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecCore} "The core program files."
!insertmacro MUI_DESCRIPTION_TEXT ${SecMusic} "Background music. (If selected the music will be downloaded from the internet.)"
!insertmacro MUI_DESCRIPTION_TEXT ${SecPortable} "Portable client. (If selected client will work as portable client.)"
!insertmacro MUI_DESCRIPTION_TEXT ${SecTrans} "Translations for the user interface into 23 different languages. Uncheck this component to leave it in English."
!insertmacro MUI_FUNCTION_DESCRIPTION_END


Section -AdditionalIcons
    WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Readme.lnk" "notepad.exe" "$INSTDIR\README.txt"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\FAQ.lnk" "$INSTDIR\docs\FAQ.txt"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd


Section -Post
    WriteUninstaller "$INSTDIR\uninst.exe"
    WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\mana.exe"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
    !ifdef BRANDINGDIR
        WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\data\branding\icons\${BRANDING_ICON_FILE}"
    !else
        WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\data\icons\mana.ico"
    !endif
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onInit
    !insertmacro MUI_UNGETLANGUAGE
FunctionEnd


Section Uninstall
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"

    Delete "$INSTDIR\*.*"

    Delete "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk"
    Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
    Delete "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk"
    Delete "$SMPROGRAMS\${PRODUCT_NAME}\Website.lnk"
    Delete "$SMPROGRAMS\${PRODUCT_NAME}\Readme.lnk"
    Delete "$SMPROGRAMS\${PRODUCT_NAME}\FAQ.lnk"

    RMDir "$SMPROGRAMS\${PRODUCT_NAME}"

    RMDir /r "$INSTDIR\data"
    RMDir /r "$INSTDIR\docs"
    RMDir /r "$INSTDIR\translations"
    RMDir /r "$INSTDIR\updates"
    RMDir "$INSTDIR"

    DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
    DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
    SetAutoClose true
SectionEnd
