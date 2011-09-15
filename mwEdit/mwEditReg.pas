{+-----------------------------------------------------------------------------+
 | Created:     1998-12-16
 | Last change: 1999-11-11
 | Author:      Primoz Gabrijelcic
 | Description: One unit to bind them - common Register for all mwEdit
 |              components
 | Version:     0.20
 | Copyright (c) 1998 Primoz Gabrijelcic
 | No rights reserved.
 |
 | Thanks to: Brad Stowers
 |
 | Version history: see version.rtf
 |
 +----------------------------------------------------------------------------+}

unit mwEditReg;

interface

procedure Register;

implementation

uses
  mwCustomEdit, mwKeyCmds, mwKeyCmdsEditor, mwEditPropertyReg,
  mwPasSyn, DcjCppSyn, DcjPerlSyn, mwGeneralSyn, cbHPSyn,
  DcjJavaSyn, cwCACSyn, wmSQLSyn, hkHTMLSyn, hkAWKSyn, siTclTksyn,
  lbVBSSyn, odPySyn, odPythonBehaviour, mkGalaxySyn,
  mwRTFExport, mwHTMLExport,
  DBmwEdit, dmBatSyn, dmDfmSyn, nhAsmSyn, mwCompletionProposal, mwDmlSyn,
  izIniSyn, dmMLSyn;

procedure Register;
begin
  mwCustomEdit.Register;
  mwEditPropertyReg.Register;
  mwPasSyn.Register;
  DcjCppSyn.Register;
  DcjPerlSyn.Register;
  mwGeneralSyn.Register;
  cbHPSyn.Register;
  DcjJavaSyn.Register;
  cwCACSyn.Register;
  wmSQLSyn.Register;
  siTclTksyn.Register;
  hkHTMLSyn.Register;
  hkAWKSyn.Register;
  lbVBSSyn.Register;
  odPySyn.Register;
  odPythonBehaviour.Register;
  mkGalaxySyn.Register;
  mwRTFExport.Register;
  mwHTMLExport.Register;
  DBmwEdit.Register;
  dmBatSyn.Register;
  dmDfmSyn.Register;
  nhAsmSyn.Register;
  mwCompletionProposal.Register;
  mwDmlSyn.Register;
  izIniSyn.Register;
  dmMLSyn.Register;
end; { Register }

end.

