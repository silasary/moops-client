{-------------------------------------------------------------------------------
  _   _      ___ ___ _
 | `_' |_  _/ __/ __| |     MySSL interface to OpenSSL for Delphi
 | | | \ \/ \__ \__ \ |_    Copyright (C) 1998,99 by Jan Tomasek
 |_| |_|\  /|___/___/___|   All rights reserved.
        /_/

 This library is free software; you can redistribute it and/or
 modify it under the terms of the GNU Library General Public
 License as published by the Free Software Foundation; either
 version 2 of the License, or (at your option) any later version.

 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Library General Public License for more details.

 You should have received a copy of the GNU Library General Public
 License along with this library; if not, write to the Free
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

 WARNING: This file is automaticaly generated from OpenSSL files, do not modify
          it by hand!

-------------------------------------------------------------------------------
 Winshoes Comments by Kudzu
  This file is licensed seperately from Winshoes itself, and is licensed under
  GNU as outlined by the original author. The GNU license may be found at:
  http://www.opensource.org/licenses/gpl-license.html

2000.02.03 Mark Lussier
  - Fixed C++ Builder 3 Compile Problem
  
2000.01.16
  - Made changes for compat with CB
  - NODEFINE added for PKCS7_SIGNER_INFO
  - Changed the following so as not to conflict with same name identifiers
    already used in CB:
      EXIT_FAILURE --> MSS_EXIT_FAILURE
      EXIT_SUCCESS --> MSS_EXIT_SUCCESS
      RAND_MAX --> MSS_RAND_MAX
      _WIN32 --> _MSS_WIN32
      _X86_ --> _MSS_X86_

2000.01.08 Mark Lussier
  - Changed PULong

2000.01.08 Kudzu
  - Changed PInteger

1999.12.15 - Gregor Ibic
  - Changes have been added by Gregor Ibic.

-------------------------------------------------------------------------------}
unit
  MySSLWinshoe;

interface

(* -----------------------------------------------------------------------------
   List of used files for this translation:
     E:\cygnus\cygwin-b20\H-i586-cygwin32\bin\..\lib\gcc-lib\i586-cygwin32\egcs-2.91.57\..\..\..\..\i586-cygwin32\include\_ansi.h
     E:\cygnus\cygwin-b20\H-i586-cygwin32\bin\..\lib\gcc-lib\i586-cygwin32\egcs-2.91.57\..\..\..\..\i586-cygwin32\include\sys/reent.h
     E:\cygnus\cygwin-b20\H-i586-cygwin32\bin\..\lib\gcc-lib\i586-cygwin32\egcs-2.91.57\include\stdarg.h
     E:\cygnus\cygwin-b20\H-i586-cygwin32\bin\..\lib\gcc-lib\i586-cygwin32\egcs-2.91.57\..\..\..\..\i586-cygwin32\include\time.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/safestack.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/ssl23.h
     E:\cygnus\cygwin-b20\H-i586-cygwin32\bin\..\lib\gcc-lib\i586-cygwin32\egcs-2.91.57\..\..\..\..\i586-cygwin32\include\machine/time.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/dsa.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/e_os2.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/bio.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/des.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/pem.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/rsa.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/rc2.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/pkcs7.h
     E:\cygnus\cygwin-b20\H-i586-cygwin32\bin\..\lib\gcc-lib\i586-cygwin32\egcs-2.91.57\include\stddef.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/rc4.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/opensslconf.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/rc5.h
     ffile.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/dh.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/lhash.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/bn.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/ssl.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/asn1.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/idea.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/pem2.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/x509.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/stack.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/buffer.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/opensslv.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/sha.h
     E:\cygnus\cygwin-b20\H-i586-cygwin32\bin\..\lib\gcc-lib\i586-cygwin32\egcs-2.91.57\..\..\..\..\i586-cygwin32\include\machine/types.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/blowfish.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/ripemd.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/crypto.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/md2.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/tls1.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/ssl2.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/ssl3.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/md5.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/mdc2.h
     E:\cygnus\cygwin-b20\H-i586-cygwin32\bin\..\lib\gcc-lib\i586-cygwin32\egcs-2.91.57\..\..\..\..\i586-cygwin32\include\stdlib.h
     E:\cygnus\cygwin-b20\H-i586-cygwin32\bin\..\lib\gcc-lib\i586-cygwin32\egcs-2.91.57\..\..\..\..\i586-cygwin32\include\stdio.h
     E:\cygnus\cygwin-b20\H-i586-cygwin32\bin\..\lib\gcc-lib\i586-cygwin32\egcs-2.91.57\..\..\..\..\i586-cygwin32\include\sys/config.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/x509_vfy.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/objects.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/evp.h
     \\i\honza\iproj\ssl\openssl-0.9.4\inc32\openssl/cast.h
----------------------------------------------------------------------------- *)


Const
  ASN1_F_A2D_ASN1_OBJECT = 100;
  ASN1_F_A2I_ASN1_ENUMERATED = 236;
  ASN1_F_A2I_ASN1_INTEGER = 101;
  ASN1_F_A2I_ASN1_STRING = 102;
  ASN1_F_ASN1_COLLATE_PRIMITIVE = 103;
  ASN1_F_ASN1_D2I_BIO = 104;
  ASN1_F_ASN1_D2I_FP = 105;
  ASN1_F_ASN1_DUP = 106;
  ASN1_F_ASN1_ENUMERATED_SET = 232;
  ASN1_F_ASN1_ENUMERATED_TO_BN = 233;
  ASN1_F_ASN1_GENERALIZEDTIME_NEW = 222;
  ASN1_F_ASN1_GET_OBJECT = 107;
  ASN1_F_ASN1_HEADER_NEW = 108;
  ASN1_F_ASN1_I2D_BIO = 109;
  ASN1_F_ASN1_I2D_FP = 110;
  ASN1_F_ASN1_INTEGER_SET = 111;
  ASN1_F_ASN1_INTEGER_TO_BN = 112;
  ASN1_F_ASN1_OBJECT_NEW = 113;
  ASN1_F_ASN1_PACK_STRING = 245;
  ASN1_F_ASN1_PBE_SET = 253;
  ASN1_F_ASN1_SEQ_PACK = 246;
  ASN1_F_ASN1_SEQ_UNPACK = 247;
  ASN1_F_ASN1_SIGN = 114;
  ASN1_F_ASN1_STRING_NEW = 115;
  ASN1_F_ASN1_STRING_TYPE_NEW = 116;
  ASN1_F_ASN1_TYPE_GET_INT_OCTETSTRING = 117;
  ASN1_F_ASN1_TYPE_GET_OCTETSTRING = 118;
  ASN1_F_ASN1_TYPE_NEW = 119;
  ASN1_F_ASN1_UNPACK_STRING = 248;
  ASN1_F_ASN1_UTCTIME_NEW = 120;
  ASN1_F_ASN1_VERIFY = 121;
  ASN1_F_AUTHORITY_KEYID_NEW = 237;
  ASN1_F_BASIC_CONSTRAINTS_NEW = 226;
  ASN1_F_BN_TO_ASN1_ENUMERATED = 234;
  ASN1_F_BN_TO_ASN1_INTEGER = 122;
  ASN1_F_D2I_ASN1_BIT_STRING = 123;
  ASN1_F_D2I_ASN1_BMPSTRING = 124;
  ASN1_F_D2I_ASN1_BOOLEAN = 125;
  ASN1_F_D2I_ASN1_BYTES = 126;
  ASN1_F_D2I_ASN1_ENUMERATED = 235;
  ASN1_F_D2I_ASN1_GENERALIZEDTIME = 223;
  ASN1_F_D2I_ASN1_HEADER = 127;
  ASN1_F_D2I_ASN1_INTEGER = 128;
  ASN1_F_D2I_ASN1_OBJECT = 129;
  ASN1_F_D2I_ASN1_OCTET_STRING = 130;
  ASN1_F_D2I_ASN1_PRINT_TYPE = 131;
  ASN1_F_D2I_ASN1_SET = 132;
  ASN1_F_D2I_ASN1_TIME = 224;
  ASN1_F_D2I_ASN1_TYPE = 133;
  ASN1_F_D2I_ASN1_TYPE_BYTES = 134;
  ASN1_F_D2I_ASN1_UINTEGER = 280;
  ASN1_F_D2I_ASN1_UTCTIME = 135;
  ASN1_F_D2I_ASN1_UTF8STRING = 266;
  ASN1_F_D2I_ASN1_VISIBLESTRING = 267;
  ASN1_F_D2I_AUTHORITY_KEYID = 238;
  ASN1_F_D2I_BASIC_CONSTRAINTS = 227;
  ASN1_F_D2I_DHPARAMS = 136;
  ASN1_F_D2I_DIST_POINT = 276;
  ASN1_F_D2I_DIST_POINT_NAME = 277;
  ASN1_F_D2I_DSAPARAMS = 137;
  ASN1_F_D2I_DSAPRIVATEKEY = 138;
  ASN1_F_D2I_DSAPUBLICKEY = 139;
  ASN1_F_D2I_GENERAL_NAME = 230;
  ASN1_F_D2I_NETSCAPE_CERT_SEQUENCE = 228;
  ASN1_F_D2I_NETSCAPE_PKEY = 140;
  ASN1_F_D2I_NETSCAPE_RSA = 141;
  ASN1_F_D2I_NETSCAPE_RSA_2 = 142;
  ASN1_F_D2I_NETSCAPE_SPKAC = 143;
  ASN1_F_D2I_NETSCAPE_SPKI = 144;
  ASN1_F_D2I_NOTICEREF = 268;
  ASN1_F_D2I_PBE2PARAM = 262;
  ASN1_F_D2I_PBEPARAM = 249;
  ASN1_F_D2I_PBKDF2PARAM = 263;
  ASN1_F_D2I_PKCS12 = 254;
  ASN1_F_D2I_PKCS12_BAGS = 255;
  ASN1_F_D2I_PKCS12_MAC_DATA = 256;
  ASN1_F_D2I_PKCS12_SAFEBAG = 257;
  ASN1_F_D2I_PKCS7 = 145;
  ASN1_F_D2I_PKCS7_DIGEST = 146;
  ASN1_F_D2I_PKCS7_ENCRYPT = 147;
  ASN1_F_D2I_PKCS7_ENC_CONTENT = 148;
  ASN1_F_D2I_PKCS7_ENVELOPE = 149;
  ASN1_F_D2I_PKCS7_ISSUER_AND_SERIAL = 150;
  ASN1_F_D2I_PKCS7_RECIP_INFO = 151;
  ASN1_F_D2I_PKCS7_SIGNED = 152;
  ASN1_F_D2I_PKCS7_SIGNER_INFO = 153;
  ASN1_F_D2I_PKCS7_SIGN_ENVELOPE = 154;
  ASN1_F_D2I_PKCS8_PRIV_KEY_INFO = 250;
  ASN1_F_D2I_PKEY_USAGE_PERIOD = 239;
  ASN1_F_D2I_POLICYINFO = 269;
  ASN1_F_D2I_POLICYQUALINFO = 270;
  ASN1_F_D2I_PRIVATEKEY = 155;
  ASN1_F_D2I_PUBLICKEY = 156;
  ASN1_F_D2I_RSAPRIVATEKEY = 157;
  ASN1_F_D2I_RSAPUBLICKEY = 158;
  ASN1_F_D2I_SXNET = 241;
  ASN1_F_D2I_SXNETID = 243;
  ASN1_F_D2I_USERNOTICE = 271;
  ASN1_F_D2I_X509 = 159;
  ASN1_F_D2I_X509_ALGOR = 160;
  ASN1_F_D2I_X509_ATTRIBUTE = 161;
  ASN1_F_D2I_X509_CINF = 162;
  ASN1_F_D2I_X509_CRL = 163;
  ASN1_F_D2I_X509_CRL_INFO = 164;
  ASN1_F_D2I_X509_EXTENSION = 165;
  ASN1_F_D2I_X509_KEY = 166;
  ASN1_F_D2I_X509_NAME = 167;
  ASN1_F_D2I_X509_NAME_ENTRY = 168;
  ASN1_F_D2I_X509_PKEY = 169;
  ASN1_F_D2I_X509_PUBKEY = 170;
  ASN1_F_D2I_X509_REQ = 171;
  ASN1_F_D2I_X509_REQ_INFO = 172;
  ASN1_F_D2I_X509_REVOKED = 173;
  ASN1_F_D2I_X509_SIG = 174;
  ASN1_F_D2I_X509_VAL = 175;
  ASN1_F_DIST_POINT_NAME_NEW = 278;
  ASN1_F_DIST_POINT_NEW = 279;
  ASN1_F_GENERAL_NAME_NEW = 231;
  ASN1_F_I2D_ASN1_HEADER = 176;
  ASN1_F_I2D_ASN1_TIME = 225;
  ASN1_F_I2D_DHPARAMS = 177;
  ASN1_F_I2D_DSAPARAMS = 178;
  ASN1_F_I2D_DSAPRIVATEKEY = 179;
  ASN1_F_I2D_DSAPUBLICKEY = 180;
  ASN1_F_I2D_NETSCAPE_RSA = 181;
  ASN1_F_I2D_PKCS7 = 182;
  ASN1_F_I2D_PRIVATEKEY = 183;
  ASN1_F_I2D_PUBLICKEY = 184;
  ASN1_F_I2D_RSAPRIVATEKEY = 185;
  ASN1_F_I2D_RSAPUBLICKEY = 186;
  ASN1_F_I2D_X509_ATTRIBUTE = 187;
  ASN1_F_I2T_ASN1_OBJECT = 188;
  ASN1_F_NETSCAPE_CERT_SEQUENCE_NEW = 229;
  ASN1_F_NETSCAPE_PKEY_NEW = 189;
  ASN1_F_NETSCAPE_SPKAC_NEW = 190;
  ASN1_F_NETSCAPE_SPKI_NEW = 191;
  ASN1_F_NOTICEREF_NEW = 272;
  ASN1_F_PBE2PARAM_NEW = 264;
  ASN1_F_PBEPARAM_NEW = 251;
  ASN1_F_PBKDF2PARAM_NEW = 265;
  ASN1_F_PKCS12_BAGS_NEW = 258;
  ASN1_F_PKCS12_MAC_DATA_NEW = 259;
  ASN1_F_PKCS12_NEW = 260;
  ASN1_F_PKCS12_SAFEBAG_NEW = 261;
  ASN1_F_PKCS5_PBE2_SET = 281;
  ASN1_F_PKCS7_DIGEST_NEW = 192;
  ASN1_F_PKCS7_ENCRYPT_NEW = 193;
  ASN1_F_PKCS7_ENC_CONTENT_NEW = 194;
  ASN1_F_PKCS7_ENVELOPE_NEW = 195;
  ASN1_F_PKCS7_ISSUER_AND_SERIAL_NEW = 196;
  ASN1_F_PKCS7_NEW = 197;
  ASN1_F_PKCS7_RECIP_INFO_NEW = 198;
  ASN1_F_PKCS7_SIGNED_NEW = 199;
  ASN1_F_PKCS7_SIGNER_INFO_NEW = 200;
  ASN1_F_PKCS7_SIGN_ENVELOPE_NEW = 201;
  ASN1_F_PKCS8_PRIV_KEY_INFO_NEW = 252;
  ASN1_F_PKEY_USAGE_PERIOD_NEW = 240;
  ASN1_F_POLICYINFO_NEW = 273;
  ASN1_F_POLICYQUALINFO_NEW = 274;
  ASN1_F_SXNETID_NEW = 244;
  ASN1_F_SXNET_NEW = 242;
  ASN1_F_USERNOTICE_NEW = 275;
  ASN1_F_X509_ALGOR_NEW = 202;
  ASN1_F_X509_ATTRIBUTE_NEW = 203;
  ASN1_F_X509_CINF_NEW = 204;
  ASN1_F_X509_CRL_INFO_NEW = 205;
  ASN1_F_X509_CRL_NEW = 206;
  ASN1_F_X509_DHPARAMS_NEW = 207;
  ASN1_F_X509_EXTENSION_NEW = 208;
  ASN1_F_X509_INFO_NEW = 209;
  ASN1_F_X509_KEY_NEW = 210;
  ASN1_F_X509_NAME_ENTRY_NEW = 211;
  ASN1_F_X509_NAME_NEW = 212;
  ASN1_F_X509_NEW = 213;
  ASN1_F_X509_PKEY_NEW = 214;
  ASN1_F_X509_PUBKEY_NEW = 215;
  ASN1_F_X509_REQ_INFO_NEW = 216;
  ASN1_F_X509_REQ_NEW = 217;
  ASN1_F_X509_REVOKED_NEW = 218;
  ASN1_F_X509_SIG_NEW = 219;
  ASN1_F_X509_VAL_FREE = 220;
  ASN1_F_X509_VAL_NEW = 221;
  ASN1_OBJECT_FLAG_CRITICAL = $02;
  ASN1_OBJECT_FLAG_DYNAMIC = $01;
  ASN1_OBJECT_FLAG_DYNAMIC_DATA = $08;
  ASN1_OBJECT_FLAG_DYNAMIC_STRINGS = $04;
  ASN1_R_BAD_CLASS = 100;
  ASN1_R_BAD_OBJECT_HEADER = 101;
  ASN1_R_BAD_PASSWORD_READ = 102;
  ASN1_R_BAD_PKCS7_CONTENT = 103;
  ASN1_R_BAD_PKCS7_TYPE = 104;
  ASN1_R_BAD_TAG = 105;
  ASN1_R_BAD_TYPE = 106;
  ASN1_R_BN_LIB = 107;
  ASN1_R_BOOLEAN_IS_WRONG_LENGTH = 108;
  ASN1_R_BUFFER_TOO_SMALL = 109;
  ASN1_R_DATA_IS_WRONG = 110;
  ASN1_R_DECODE_ERROR = 155;
  ASN1_R_DECODING_ERROR = 111;
  ASN1_R_ENCODE_ERROR = 156;
  ASN1_R_ERROR_PARSING_SET_ELEMENT = 112;
  ASN1_R_ERROR_SETTING_CIPHER_PARAMS = 157;
  ASN1_R_EXPECTING_AN_ENUMERATED = 154;
  ASN1_R_EXPECTING_AN_INTEGER = 113;
  ASN1_R_EXPECTING_AN_OBJECT = 114;
  ASN1_R_EXPECTING_AN_OCTET_STRING = 115;
  ASN1_R_EXPECTING_A_BIT_STRING = 116;
  ASN1_R_EXPECTING_A_BOOLEAN = 117;
  ASN1_R_EXPECTING_A_GENERALIZEDTIME = 151;
  ASN1_R_EXPECTING_A_TIME = 152;
  ASN1_R_EXPECTING_A_UTCTIME = 118;
  ASN1_R_FIRST_NUM_TOO_LARGE = 119;
  ASN1_R_GENERALIZEDTIME_TOO_LONG = 153;
  ASN1_R_HEADER_TOO_LONG = 120;
  ASN1_R_INVALID_DIGIT = 121;
  ASN1_R_INVALID_SEPARATOR = 122;
  ASN1_R_INVALID_TIME_FORMAT = 123;
  ASN1_R_IV_TOO_LARGE = 124;
  ASN1_R_LENGTH_ERROR = 125;
  ASN1_R_MISSING_SECOND_NUMBER = 126;
  ASN1_R_NON_HEX_CHARACTERS = 127;
  ASN1_R_NOT_ENOUGH_DATA = 128;
  ASN1_R_ODD_NUMBER_OF_CHARS = 129;
  ASN1_R_PARSING = 130;
  ASN1_R_PRIVATE_KEY_HEADER_MISSING = 131;
  ASN1_R_SECOND_NUMBER_TOO_LARGE = 132;
  ASN1_R_SHORT_LINE = 133;
  ASN1_R_STRING_TOO_SHORT = 134;
  ASN1_R_TAG_VALUE_TOO_HIGH = 135;
  ASN1_R_THE_ASN1_OBJECT_IDENTIFIER_IS_NOT_KNOWN_FOR_THIS_MD = 136;
  ASN1_R_TOO_LONG = 137;
  ASN1_R_UNABLE_TO_DECODE_RSA_KEY = 138;
  ASN1_R_UNABLE_TO_DECODE_RSA_PRIVATE_KEY = 139;
  ASN1_R_UNKNOWN_ATTRIBUTE_TYPE = 140;
  ASN1_R_UNKNOWN_MESSAGE_DIGEST_ALGORITHM = 141;
  ASN1_R_UNKNOWN_OBJECT_TYPE = 142;
  ASN1_R_UNKNOWN_PUBLIC_KEY_TYPE = 143;
  ASN1_R_UNSUPPORTED_CIPHER = 144;
  ASN1_R_UNSUPPORTED_ENCRYPTION_ALGORITHM = 145;
  ASN1_R_UNSUPPORTED_PUBLIC_KEY_TYPE = 146;
  ASN1_R_UTCTIME_TOO_LONG = 147;
  ASN1_R_WRONG_PRINTABLE_TYPE = 148;
  ASN1_R_WRONG_TAG = 149;
  ASN1_R_WRONG_TYPE = 150;
  ASN1_STRING_FLAG_BITS_LEFT = $08;
  BF_BLOCK = 8;
  BF_DECRYPT = 0;
  BF_ENCRYPT = 1;
  BF_ROUNDS = 16;
  BIO_BIND_NORMAL = 0;
  BIO_BIND_REUSEADDR = 2;
  BIO_BIND_REUSEADDR_IF_UNUSED = 1;
  BIO_CB_CTRL = $06;
  BIO_CB_FREE = $01;
  BIO_CB_GETS = $05;
  BIO_CB_PUTS = $04;
  BIO_CB_READ = $02;
  BIO_CB_RETURN = $80;
  BIO_CB_WRITE = $03;
  BIO_CLOSE = $01;
  BIO_CONN_S_BEFORE = 1;
  BIO_CONN_S_BLOCKED_CONNECT = 7;
  BIO_CONN_S_CONNECT = 5;
  BIO_CONN_S_CREATE_SOCKET = 4;
  BIO_CONN_S_GET_IP = 2;
  BIO_CONN_S_GET_PORT = 3;
  BIO_CONN_S_NBIO = 8;
  BIO_CONN_S_OK = 6;
  BIO_CTRL_DUP = 12;
  BIO_CTRL_EOF = 2;
  BIO_CTRL_FLUSH = 11;
  BIO_CTRL_GET = 5;
  BIO_CTRL_GET_CALLBACK = 15;
  BIO_CTRL_GET_CLOSE = 8;
  BIO_CTRL_INFO = 3;
  BIO_CTRL_PENDING = 10;
  BIO_CTRL_POP = 7;
  BIO_CTRL_PUSH = 6;
  BIO_CTRL_RESET = 1;
  BIO_CTRL_SET = 4;
  BIO_CTRL_SET_CALLBACK = 14;
  BIO_CTRL_SET_CLOSE = 9;
  BIO_CTRL_SET_FILENAME = 30;
  BIO_CTRL_WPENDING = 13;
  BIO_C_DESTROY_BIO_PAIR = 139;
  BIO_C_DO_STATE_MACHINE = 101;
  BIO_C_FILE_SEEK = 128;
  BIO_C_FILE_TELL = 133;
  BIO_C_GET_ACCEPT = 124;
  BIO_C_GET_BIND_MODE = 132;
  BIO_C_GET_BUFF_NUM_LINES = 116;
  BIO_C_GET_BUF_MEM_PTR = 115;
  BIO_C_GET_CIPHER_CTX = 129;
  BIO_C_GET_CIPHER_STATUS = 113;
  BIO_C_GET_CONNECT = 123;
  BIO_C_GET_FD = 105;
  BIO_C_GET_FILE_PTR = 107;
  BIO_C_GET_MD = 112;
  BIO_C_GET_MD_CTX = 120;
  BIO_C_GET_PROXY_PARAM = 121;
  BIO_C_GET_READ_REQUEST = 141;
  BIO_C_GET_SOCKS = 134;
  BIO_C_GET_SSL = 110;
  BIO_C_GET_SSL_NUM_RENEGOTIATES = 126;
  BIO_C_GET_WRITE_BUF_SIZE = 137;
  BIO_C_GET_WRITE_GUARANTEE = 140;
  BIO_C_MAKE_BIO_PAIR = 138;
  BIO_C_SET_ACCEPT = 118;
  BIO_C_SET_BIND_MODE = 131;
  BIO_C_SET_BUFF_READ_DATA = 122;
  BIO_C_SET_BUFF_SIZE = 117;
  BIO_C_SET_BUF_MEM = 114;
  BIO_C_SET_BUF_MEM_EOF_RETURN = 130;
  BIO_C_SET_CONNECT = 100;
  BIO_C_SET_FD = 104;
  BIO_C_SET_FILENAME = 108;
  BIO_C_SET_FILE_PTR = 106;
  BIO_C_SET_MD = 111;
  BIO_C_SET_NBIO = 102;
  BIO_C_SET_PROXY_PARAM = 103;
  BIO_C_SET_SOCKS = 135;
  BIO_C_SET_SSL = 109;
  BIO_C_SET_SSL_RENEGOTIATE_BYTES = 125;
  BIO_C_SET_SSL_RENEGOTIATE_TIMEOUT = 127;
  BIO_C_SET_WRITE_BUF_SIZE = 136;
  BIO_C_SHUTDOWN_WR = 142;
  BIO_C_SSL_MODE = 119;
  BIO_FLAGS_BASE64_NO_NL = $100;
  BIO_FLAGS_IO_SPECIAL = $04;
  BIO_FLAGS_READ = $01;
  BIO_FLAGS_WRITE = $02;
  BIO_FLAGS_RWS = BIO_FLAGS_READ or BIO_FLAGS_WRITE or BIO_FLAGS_IO_SPECIAL;
  BIO_FLAGS_SHOULD_RETRY = $08;
  BIO_FP_APPEND = $08;
  BIO_FP_READ = $02;
  BIO_FP_TEXT = $10;
  BIO_FP_WRITE = $04;
  BIO_F_ACPT_STATE = 100;
  BIO_F_BIO_ACCEPT = 101;
  BIO_F_BIO_BER_GET_HEADER = 102;
  BIO_F_BIO_CTRL = 103;
  BIO_F_BIO_GETHOSTBYNAME = 120;
  BIO_F_BIO_GETS = 104;
  BIO_F_BIO_GET_ACCEPT_SOCKET = 105;
  BIO_F_BIO_GET_HOST_IP = 106;
  BIO_F_BIO_GET_PORT = 107;
  BIO_F_BIO_MAKE_PAIR = 121;
  BIO_F_BIO_NEW = 108;
  BIO_F_BIO_NEW_FILE = 109;
  BIO_F_BIO_PUTS = 110;
  BIO_F_BIO_READ = 111;
  BIO_F_BIO_SOCK_INIT = 112;
  BIO_F_BIO_WRITE = 113;
  BIO_F_BUFFER_CTRL = 114;
  BIO_F_CONN_STATE = 115;
  BIO_F_FILE_CTRL = 116;
  BIO_F_MEM_WRITE = 117;
  BIO_F_SSL_NEW = 118;
  BIO_F_WSASTARTUP = 119;
  BIO_GHBN_CTRL_CACHE_SIZE = 3;
  BIO_GHBN_CTRL_FLUSH = 5;
  BIO_GHBN_CTRL_GET_ENTRY = 4;
  BIO_GHBN_CTRL_HITS = 1;
  BIO_GHBN_CTRL_MISSES = 2;
  BIO_NOCLOSE = $00;
  BIO_RR_CONNECT = $02;
  BIO_RR_SSL_X509_LOOKUP = $01;
  BIO_R_ACCEPT_ERROR = 100;
  BIO_R_BAD_FOPEN_MODE = 101;
  BIO_R_BAD_HOSTNAME_LOOKUP = 102;
  BIO_R_BROKEN_PIPE = 124;
  BIO_R_CONNECT_ERROR = 103;
  BIO_R_ERROR_SETTING_NBIO = 104;
  BIO_R_ERROR_SETTING_NBIO_ON_ACCEPTED_SOCKET = 105;
  BIO_R_ERROR_SETTING_NBIO_ON_ACCEPT_SOCKET = 106;
  BIO_R_GETHOSTBYNAME_ADDR_IS_NOT_AF_INET = 107;
  BIO_R_INVALID_ARGUMENT = 125;
  BIO_R_INVALID_IP_ADDRESS = 108;
  BIO_R_IN_USE = 123;
  BIO_R_KEEPALIVE = 109;
  BIO_R_NBIO_CONNECT_ERROR = 110;
  BIO_R_NO_ACCEPT_PORT_SPECIFIED = 111;
  BIO_R_NO_HOSTNAME_SPECIFIED = 112;
  BIO_R_NO_PORT_DEFINED = 113;
  BIO_R_NO_PORT_SPECIFIED = 114;
  BIO_R_NULL_PARAMETER = 115;
  BIO_R_TAG_MISMATCH = 116;
  BIO_R_UNABLE_TO_BIND_SOCKET = 117;
  BIO_R_UNABLE_TO_CREATE_SOCKET = 118;
  BIO_R_UNABLE_TO_LISTEN_SOCKET = 119;
  BIO_R_UNINITIALIZED = 120;
  BIO_R_UNSUPPORTED_METHOD = 121;
  BIO_R_WSASTARTUP = 122;
  BIO_TYPE_ACCEPT = 13 or $0400 or $0100;
  BIO_TYPE_BASE64 = 11 or $0200;
  BIO_TYPE_BER = 18 or $0200;
  BIO_TYPE_BIO = 19 or $0400;
  BIO_TYPE_BUFFER = 9 or $0200;
  BIO_TYPE_CIPHER = 10 or $0200;
  BIO_TYPE_CONNECT = 12 or $0400 or $0100;
  BIO_TYPE_DESCRIPTOR = $0100;
  BIO_TYPE_FD = 4 or $0400 or $0100;
  BIO_TYPE_FILE = 2 or $0400;
  BIO_TYPE_FILTER = $0200;
  BIO_TYPE_MD = 8 or $0200;
  BIO_TYPE_MEM = 1 or $0400;
  BIO_TYPE_NBIO_TEST = 16 or $0200;
  BIO_TYPE_NONE = 0;
  BIO_TYPE_NULL = 6 or $0400;
  BIO_TYPE_NULL_FILTER = 17 or $0200;
  BIO_TYPE_PROXY_CLIENT = 14 or $0200;
  BIO_TYPE_PROXY_SERVER = 15 or $0200;
  BIO_TYPE_SOCKET = 5 or $0400 or $0100;
  BIO_TYPE_SOURCE_SINK = $0400;
  BIO_TYPE_SSL = 7 or $0200;
  BN_BITS = 64;
  BN_BITS2 = 32;
  BN_BITS4 = 16;
  BN_BYTES = 4;
  BN_CTX_NUM = 12;
  BN_DEC_FMT1 = '%lu';
  BN_DEC_FMT2 = '%09lu';
  BN_DEC_NUM = 9;
  BN_DEFAULT_BITS = 1280;
  BN_FLG_FREE = $8000;
  BN_FLG_MALLOCED = $01;
  BN_FLG_STATIC_DATA = $02;
  BN_F_BN_BLINDING_CONVERT = 100;
  BN_F_BN_BLINDING_INVERT = 101;
  BN_F_BN_BLINDING_NEW = 102;
  BN_F_BN_BLINDING_UPDATE = 103;
  BN_F_BN_BN2DEC = 104;
  BN_F_BN_BN2HEX = 105;
  BN_F_BN_CTX_NEW = 106;
  BN_F_BN_DIV = 107;
  BN_F_BN_EXPAND2 = 108;
  BN_F_BN_MOD_EXP_MONT = 109;
  BN_F_BN_MOD_INVERSE = 110;
  BN_F_BN_MOD_MUL_RECIPROCAL = 111;
  BN_F_BN_MPI2BN = 112;
  BN_F_BN_NEW = 113;
  BN_F_BN_RAND = 114;
  BN_F_BN_USUB = 115;
  BN_MASK2 = $ffffffff;
  BN_MASK2h = $ffff0000;
  BN_MASK2h1 = $ffff8000;
  BN_MASK2l = $ffff;
  BN_R_ARG2_LT_ARG3 = 100;
  BN_R_BAD_RECIPROCAL = 101;
  BN_R_CALLED_WITH_EVEN_MODULUS = 102;
  BN_R_DIV_BY_ZERO = 103;
  BN_R_ENCODING_ERROR = 104;
  BN_R_EXPAND_ON_STATIC_BIGNUM_DATA = 105;
  BN_R_INVALID_LENGTH = 106;
  BN_R_NOT_INITIALIZED = 107;
  BN_R_NO_INVERSE = 108;
  BN_TBIT = $80000000;
  BUFSIZ = 1024;
  BUF_F_BUF_MEM_GROW = 100;
  BUF_F_BUF_MEM_NEW = 101;
  BUF_F_BUF_STRDUP = 102;
  B_ASN1_BIT_STRING = $0400;
  B_ASN1_BMPSTRING = $0800;
  B_ASN1_GENERALSTRING = $0080;
  B_ASN1_GRAPHICSTRING = $0020;
  B_ASN1_IA5STRING = $0010;
  B_ASN1_ISO64STRING = $0040;
  B_ASN1_NUMERICSTRING = $0001;
  B_ASN1_OCTET_STRING = $0200;
  B_ASN1_PRINTABLESTRING = $0002;
  B_ASN1_T61STRING = $0004;
  B_ASN1_TELETEXSTRING = $0008;
  B_ASN1_UNIVERSALSTRING = $0100;
  B_ASN1_UNKNOWN = $1000;
  B_ASN1_UTF8STRING = $2000;
  B_ASN1_VIDEOTEXSTRING = $0008;
  B_ASN1_VISIBLESTRING = $0040;
  CAST_BLOCK = 8;
  CAST_DECRYPT = 0;
  CAST_ENCRYPT = 1;
  CAST_KEY_LENGTH = 16;
  _CLOCKS_PER_SEC_ = 1000;
  CLOCKS_PER_SEC = _CLOCKS_PER_SEC_;
  CLK_TCK = CLOCKS_PER_SEC;
  CRYPTO_EX_INDEX_BIO = 0;
  CRYPTO_EX_INDEX_SSL = 1;
  CRYPTO_EX_INDEX_SSL_CTX = 2;
  CRYPTO_EX_INDEX_SSL_SESSION = 3;
  CRYPTO_EX_INDEX_X509_STORE = 4;
  CRYPTO_EX_INDEX_X509_STORE_CTX = 5;
  CRYPTO_F_CRYPTO_GET_EX_NEW_INDEX = 100;
  CRYPTO_F_CRYPTO_GET_NEW_LOCKID = 101;
  CRYPTO_F_CRYPTO_SET_EX_DATA = 102;
  CRYPTO_LOCK = 1;
  CRYPTO_LOCK_BIO = 19;
  CRYPTO_LOCK_DSA = 8;
  CRYPTO_LOCK_ERR = 1;
  CRYPTO_LOCK_ERR_HASH = 2;
  CRYPTO_LOCK_EVP_PKEY = 10;
  CRYPTO_LOCK_GETHOSTBYNAME = 20;
  CRYPTO_LOCK_GETSERVBYNAME = 21;
  CRYPTO_LOCK_MALLOC = 18;
  CRYPTO_LOCK_RAND = 17;
  CRYPTO_LOCK_READDIR = 22;
  CRYPTO_LOCK_RSA = 9;
  CRYPTO_LOCK_RSA_BLINDING = 23;
  CRYPTO_LOCK_SSL = 16;
  CRYPTO_LOCK_SSL_CERT = 13;
  CRYPTO_LOCK_SSL_CTX = 12;
  CRYPTO_LOCK_SSL_SESSION = 14;
  CRYPTO_LOCK_SSL_SESS_CERT = 15;
  CRYPTO_LOCK_X509 = 3;
  CRYPTO_LOCK_X509_CRL = 6;
  CRYPTO_LOCK_X509_INFO = 4;
  CRYPTO_LOCK_X509_PKEY = 5;
  CRYPTO_LOCK_X509_REQ = 7;
  CRYPTO_LOCK_X509_STORE = 11;
  CRYPTO_MEM_CHECK_DISABLE = $3;
  CRYPTO_MEM_CHECK_ENABLE = $2;
  CRYPTO_MEM_CHECK_OFF = $0;
  CRYPTO_MEM_CHECK_ON = $1;
  CRYPTO_NUM_LOCKS = 24;
  CRYPTO_READ = 4;
  CRYPTO_UNLOCK = 2;
  CRYPTO_WRITE = 8;
  DES_CBC_MODE = 0;
  DES_DECRYPT = 0;
  DES_ENCRYPT = 1;
  DES_PCBC_MODE = 1;
  DH_CHECK_P_NOT_PRIME = $01;
  DH_CHECK_P_NOT_STRONG_PRIME = $02;
  DH_FLAG_CACHE_MONT_P = $01;
  DH_F_DHPARAMS_PRINT = 100;
  DH_F_DHPARAMS_PRINT_FP = 101;
  DH_F_DH_COMPUTE_KEY = 102;
  DH_F_DH_GENERATE_KEY = 103;
  DH_F_DH_GENERATE_PARAMETERS = 104;
  DH_F_DH_NEW = 105;
  DH_GENERATOR_2 = 2;
  DH_GENERATOR_5 = 5;
  DH_NOT_SUITABLE_GENERATOR = $08;
  DH_R_NO_PRIVATE_VALUE = 100;
  DH_UNABLE_TO_CHECK_GENERATOR = $04;
  DSA_FLAG_CACHE_MONT_P = $01;
  DSA_F_D2I_DSA_SIG = 110;
  DSA_F_DSAPARAMS_PRINT = 100;
  DSA_F_DSAPARAMS_PRINT_FP = 101;
  DSA_F_DSA_DO_SIGN = 112;
  DSA_F_DSA_DO_VERIFY = 113;
  DSA_F_DSA_IS_PRIME = 102;
  DSA_F_DSA_NEW = 103;
  DSA_F_DSA_PRINT = 104;
  DSA_F_DSA_PRINT_FP = 105;
  DSA_F_DSA_SIGN = 106;
  DSA_F_DSA_SIGN_SETUP = 107;
  DSA_F_DSA_SIG_NEW = 109;
  DSA_F_DSA_VERIFY = 108;
  DSA_F_I2D_DSA_SIG = 111;
  DSA_R_DATA_TOO_LARGE_FOR_KEY_SIZE = 100;
  EVP_BLOWFISH_KEY_SIZE = 16;
  EVP_CAST5_KEY_SIZE = 16;
  EVP_F_D2I_PKEY = 100;
  EVP_F_EVP_DECRYPTFINAL = 101;
  EVP_F_EVP_MD_CTX_COPY = 110;
  EVP_F_EVP_OPENINIT = 102;
  EVP_F_EVP_PBE_ALG_ADD = 115;
  EVP_F_EVP_PBE_CIPHERINIT = 116;
  EVP_F_EVP_PKCS82PKEY = 111;
  EVP_F_EVP_PKCS8_SET_BROKEN = 112;
  EVP_F_EVP_PKEY2PKCS8 = 113;
  EVP_F_EVP_PKEY_COPY_PARAMETERS = 103;
  EVP_F_EVP_PKEY_DECRYPT = 104;
  EVP_F_EVP_PKEY_ENCRYPT = 105;
  EVP_F_EVP_PKEY_NEW = 106;
  EVP_F_EVP_SIGNFINAL = 107;
  EVP_F_EVP_VERIFYFINAL = 108;
  EVP_F_PKCS5_PBE_KEYIVGEN = 117;
  EVP_F_PKCS5_V2_PBE_KEYIVGEN = 118;
  EVP_F_RC2_MAGIC_TO_METH = 109;
  EVP_MAX_IV_LENGTH = 8;
  EVP_MAX_KEY_LENGTH = 24;
  EVP_MAX_MD_SIZE = 16+20;
  NID_dhKeyAgreement = 28;
  EVP_PKEY_DH = NID_dhKeyAgreement;
  NID_dsa = 116;
  EVP_PKEY_DSA = NID_dsa;
  NID_dsa_2 = 67;
  EVP_PKEY_DSA1 = NID_dsa_2;
  NID_dsaWithSHA = 66;
  EVP_PKEY_DSA2 = NID_dsaWithSHA;
  NID_dsaWithSHA1 = 113;
  EVP_PKEY_DSA3 = NID_dsaWithSHA1;
  NID_dsaWithSHA1_2 = 70;
  EVP_PKEY_DSA4 = NID_dsaWithSHA1_2;
  EVP_PKEY_MO_DECRYPT = $0008;
  EVP_PKEY_MO_ENCRYPT = $0004;
  EVP_PKEY_MO_SIGN = $0001;
  EVP_PKEY_MO_VERIFY = $0002;
  NID_undef = 0;
  EVP_PKEY_NONE = NID_undef;
  NID_rsaEncryption = 6;
  EVP_PKEY_RSA = NID_rsaEncryption;
  NID_rsa = 19;
  EVP_PKEY_RSA2 = NID_rsa;
  EVP_PKS_DSA = $0200;
  EVP_PKS_RSA = $0100;
  EVP_PKT_ENC = $0020;
  EVP_PKT_EXCH = $0040;
  EVP_PKT_EXP = $1000;
  EVP_PKT_SIGN = $0010;
  EVP_PK_DH = $0004;
  EVP_PK_DSA = $0002;
  EVP_PK_RSA = $0001;
  EVP_RC2_KEY_SIZE = 16;
  EVP_RC4_KEY_SIZE = 16;
  EVP_RC5_32_12_16_KEY_SIZE = 16;
  EVP_R_BAD_DECRYPT = 100;
  EVP_R_BN_DECODE_ERROR = 112;
  EVP_R_BN_PUBKEY_ERROR = 113;
  EVP_R_CIPHER_PARAMETER_ERROR = 122;
  EVP_R_DECODE_ERROR = 114;
  EVP_R_DIFFERENT_KEY_TYPES = 101;
  EVP_R_ENCODE_ERROR = 115;
  EVP_R_EVP_PBE_CIPHERINIT_ERROR = 119;
  EVP_R_INPUT_NOT_INITIALIZED = 111;
  EVP_R_IV_TOO_LARGE = 102;
  EVP_R_KEYGEN_FAILURE = 120;
  EVP_R_MISSING_PARMATERS = 103;
  EVP_R_NO_DSA_PARAMETERS = 116;
  EVP_R_NO_SIGN_FUNCTION_CONFIGURED = 104;
  EVP_R_NO_VERIFY_FUNCTION_CONFIGURED = 105;
  EVP_R_PKCS8_UNKNOWN_BROKEN_TYPE = 117;
  EVP_R_PUBLIC_KEY_NOT_RSA = 106;
  EVP_R_UNKNOWN_PBE_ALGORITHM = 121;
  EVP_R_UNSUPPORTED_CIPHER = 107;
  EVP_R_UNSUPPORTED_KEYLENGTH = 123;
  EVP_R_UNSUPPORTED_KEY_DERIVATION_FUNCTION = 124;
  EVP_R_UNSUPPORTED_KEY_SIZE = 108;
  EVP_R_UNSUPPORTED_PRF = 125;
  EVP_R_UNSUPPORTED_PRIVATE_KEY_ALGORITHM = 118;
  EVP_R_UNSUPPORTED_SALT_TYPE = 126;
  EVP_R_WRONG_FINAL_BLOCK_LENGTH = 109;
  EVP_R_WRONG_PUBLIC_KEY_TYPE = 110;
  MSS_EXIT_FAILURE = 1;
  MSS_EXIT_SUCCESS = 0;
  FILENAME_MAX = 1024;
  FOPEN_MAX = 20;
  IDEA_BLOCK = 8;
  IDEA_DECRYPT = 0;
  IDEA_ENCRYPT = 1;
  IDEA_KEY_LENGTH = 16;
  IS_SEQUENCE = 0;
  IS_SET = 1;
  KRBDES_DECRYPT = DES_DECRYPT;
  KRBDES_ENCRYPT = DES_ENCRYPT;
  LH_LOAD_MULT = 256;
  LN_SMIMECapabilities = 'S/MIME Capabilities';
  LN_X500 = 'X500';
  LN_X509 = 'X509';
  LN_algorithm = 'algorithm';
  LN_authority_key_identifier = 'X509v3 Authority Key Identifier';
  LN_basic_constraints = 'X509v3 Basic Constraints';
  LN_bf_cbc = 'bf-cbc';
  LN_bf_cfb64 = 'bf-cfb';
  LN_bf_ecb = 'bf-ecb';
  LN_bf_ofb64 = 'bf-ofb';
  LN_cast5_cbc = 'cast5-cbc';
  LN_cast5_cfb64 = 'cast5-cfb';
  LN_cast5_ecb = 'cast5-ecb';
  LN_cast5_ofb64 = 'cast5-ofb';
  LN_certBag = 'certBag';
  LN_certificate_policies = 'X509v3 Certificate Policies';
  LN_client_auth = 'TLS Web Client Authentication';
  LN_code_sign = 'Code Signing';
  LN_commonName = 'commonName';
  LN_countryName = 'countryName';
  LN_crlBag = 'crlBag';
  LN_crl_distribution_points = 'X509v3 CRL Distribution Points';
  LN_crl_number = 'X509v3 CRL Number';
  LN_crl_reason = 'CRL Reason Code';
  LN_delta_crl = 'X509v3 Delta CRL Indicator';
  LN_des_cbc = 'des-cbc';
  LN_des_cfb64 = 'des-cfb';
  LN_des_ecb = 'des-ecb';
  LN_des_ede = 'des-ede';
  LN_des_ede3 = 'des-ede3';
  LN_des_ede3_cbc = 'des-ede3-cbc';
  LN_des_ede3_cfb64 = 'des-ede3-cfb';
  LN_des_ede3_ofb64 = 'des-ede3-ofb';
  LN_des_ede_cbc = 'des-ede-cbc';
  LN_des_ede_cfb64 = 'des-ede-cfb';
  LN_des_ede_ofb64 = 'des-ede-ofb';
  LN_des_ofb64 = 'des-ofb';
  LN_description = 'description';
  LN_desx_cbc = 'desx-cbc';
  LN_dhKeyAgreement = 'dhKeyAgreement';
  LN_dsa = 'dsaEncryption';
  LN_dsaWithSHA = 'dsaWithSHA';
  LN_dsaWithSHA1 = 'dsaWithSHA1';
  LN_dsaWithSHA1_2 = 'dsaWithSHA1-old';
  LN_dsa_2 = 'dsaEncryption-old';
  LN_email_protect = 'E-mail Protection';
  LN_ext_key_usage = 'X509v3 Extended Key Usage';
  LN_friendlyName = 'friendlyName';
  LN_givenName = 'givenName';
  LN_hmacWithSHA1 = 'hmacWithSHA1';
  LN_id_pbkdf2 = 'PBKDF2';
  LN_id_qt_cps = 'Policy Qualifier CPS';
  LN_id_qt_unotice = 'Policy Qualifier User Notice';
  LN_idea_cbc = 'idea-cbc';
  LN_idea_cfb64 = 'idea-cfb';
  LN_idea_ecb = 'idea-ecb';
  LN_idea_ofb64 = 'idea-ofb';
  LN_initials = 'initials';
  LN_invalidity_date = 'Invalidity Date';
  LN_issuer_alt_name = 'X509v3 Issuer Alternative Name';
  LN_keyBag = 'keyBag';
  LN_key_usage = 'X509v3 Key Usage';
  LN_localKeyID = 'localKeyID';
  LN_localityName = 'localityName';
  LN_md2 = 'md2';
  LN_md2WithRSAEncryption = 'md2WithRSAEncryption';
  LN_md5 = 'md5';
  LN_md5WithRSA = 'md5WithRSA';
  LN_md5WithRSAEncryption = 'md5WithRSAEncryption';
  LN_md5_sha1 = 'md5-sha1';
  LN_mdc2 = 'mdc2';
  LN_mdc2WithRSA = 'mdc2withRSA';
  LN_ms_code_com = 'Microsoft Commercial Code Signing';
  LN_ms_code_ind = 'Microsoft Individual Code Signing';
  LN_ms_ctl_sign = 'Microsoft Trust List Signing';
  LN_ms_efs = 'Microsoft Encrypted File System';
  LN_ms_sgc = 'Microsoft Server Gated Crypto';
  LN_netscape = 'Netscape Communications Corp.';
  LN_netscape_base_url = 'Netscape Base Url';
  LN_netscape_ca_policy_url = 'Netscape CA Policy Url';
  LN_netscape_ca_revocation_url = 'Netscape CA Revocation Url';
  LN_netscape_cert_extension = 'Netscape Certificate Extension';
  LN_netscape_cert_sequence = 'Netscape Certificate Sequence';
  LN_netscape_cert_type = 'Netscape Cert Type';
  LN_netscape_comment = 'Netscape Comment';
  LN_netscape_data_type = 'Netscape Data Type';
  LN_netscape_renewal_url = 'Netscape Renewal Url';
  LN_netscape_revocation_url = 'Netscape Revocation Url';
  LN_netscape_ssl_server_name = 'Netscape SSL Server Name';
  LN_ns_sgc = 'Netscape Server Gated Crypto';
  LN_organizationName = 'organizationName';
  LN_organizationalUnitName = 'organizationalUnitName';
  LN_pbeWithMD2AndDES_CBC = 'pbeWithMD2AndDES-CBC';
  LN_pbeWithMD2AndRC2_CBC = 'pbeWithMD2AndRC2-CBC';
  LN_pbeWithMD5AndCast5_CBC = 'pbeWithMD5AndCast5CBC';
  LN_pbeWithMD5AndDES_CBC = 'pbeWithMD5AndDES-CBC';
  LN_pbeWithMD5AndRC2_CBC = 'pbeWithMD5AndRC2-CBC';
  LN_pbeWithSHA1AndDES_CBC = 'pbeWithSHA1AndDES-CBC';
  LN_pbeWithSHA1AndRC2_CBC = 'pbeWithSHA1AndRC2-CBC';
  LN_pbe_WithSHA1And128BitRC2_CBC = 'pbeWithSHA1And128BitRC2-CBC';
  LN_pbe_WithSHA1And128BitRC4 = 'pbeWithSHA1And128BitRC4';
  LN_pbe_WithSHA1And2_Key_TripleDES_CBC = 'pbeWithSHA1And2-KeyTripleDES-CBC';
  LN_pbe_WithSHA1And3_Key_TripleDES_CBC = 'pbeWithSHA1And3-KeyTripleDES-CBC';
  LN_pbe_WithSHA1And40BitRC2_CBC = 'pbeWithSHA1And40BitRC2-CBC';
  LN_pbe_WithSHA1And40BitRC4 = 'pbeWithSHA1And40BitRC4';
  LN_pbes2 = 'PBES2';
  LN_pbmac1 = 'PBMAC1';
  LN_pkcs = 'pkcs';
  LN_pkcs3 = 'pkcs3';
  LN_pkcs7 = 'pkcs7';
  LN_pkcs7_data = 'pkcs7-data';
  LN_pkcs7_digest = 'pkcs7-digestData';
  LN_pkcs7_encrypted = 'pkcs7-encryptedData';
  LN_pkcs7_enveloped = 'pkcs7-envelopedData';
  LN_pkcs7_signed = 'pkcs7-signedData';
  LN_pkcs7_signedAndEnveloped = 'pkcs7-signedAndEnvelopedData';
  LN_pkcs8ShroudedKeyBag = 'pkcs8ShroudedKeyBag';
  LN_pkcs9 = 'pkcs9';
  LN_pkcs9_challengePassword = 'challengePassword';
  LN_pkcs9_contentType = 'contentType';
  LN_pkcs9_countersignature = 'countersignature';
  LN_pkcs9_emailAddress = 'emailAddress';
  LN_pkcs9_extCertAttributes = 'extendedCertificateAttributes';
  LN_pkcs9_messageDigest = 'messageDigest';
  LN_pkcs9_signingTime = 'signingTime';
  LN_pkcs9_unstructuredAddress = 'unstructuredAddress';
  LN_pkcs9_unstructuredName = 'unstructuredName';
  LN_private_key_usage_period = 'X509v3 Private Key Usage Period';
  LN_rc2_40_cbc = 'rc2-40-cbc';
  LN_rc2_64_cbc = 'rc2-64-cbc';
  LN_rc2_cbc = 'rc2-cbc';
  LN_rc2_cfb64 = 'rc2-cfb';
  LN_rc2_ecb = 'rc2-ecb';
  LN_rc2_ofb64 = 'rc2-ofb';
  LN_rc4 = 'rc4';
  LN_rc4_40 = 'rc4-40';
  LN_rc5_cbc = 'rc5-cbc';
  LN_rc5_cfb64 = 'rc5-cfb';
  LN_rc5_ecb = 'rc5-ecb';
  LN_rc5_ofb64 = 'rc5-ofb';
  LN_ripemd160 = 'ripemd160';
  LN_ripemd160WithRSA = 'ripemd160WithRSA';
  LN_rle_compression = 'run length compression';
  LN_rsa = 'rsa';
  LN_rsaEncryption = 'rsaEncryption';
  LN_rsadsi = 'rsadsi';
  LN_safeContentsBag = 'safeContentsBag';
  LN_sdsiCertificate = 'sdsiCertificate';
  LN_secretBag = 'secretBag';
  LN_serialNumber = 'serialNumber';
  LN_server_auth = 'TLS Web Server Authentication';
  LN_sha = 'sha';
  LN_sha1 = 'sha1';
  LN_sha1WithRSA = 'sha1WithRSA';
  LN_sha1WithRSAEncryption = 'sha1WithRSAEncryption';
  LN_shaWithRSAEncryption = 'shaWithRSAEncryption';
  LN_stateOrProvinceName = 'stateOrProvinceName';
  LN_subject_alt_name = 'X509v3 Subject Alternative Name';
  LN_subject_key_identifier = 'X509v3 Subject Key Identifier';
  LN_surname = 'surname';
  LN_sxnet = 'Strong Extranet ID';
  LN_time_stamp = 'Time Stamping';
  LN_title = 'title';
  LN_undef = 'undefined';
  LN_uniqueIdentifier = 'uniqueIdentifier';
  LN_x509Certificate = 'x509Certificate';
  LN_x509Crl = 'x509Crl';
  LN_zlib_compression = 'zlib compression';
  L_ctermid = 16;
  L_cuserid = 9;
  L_tmpnam = 1024;
  MD2_BLOCK = 16;
  MD2_DIGEST_LENGTH = 16;
  MD5_CBLOCK = 64;
  MD5_DIGEST_LENGTH = 16;
  MDC2_BLOCK = 8;
  MDC2_DIGEST_LENGTH = 16;
  NID_SMIMECapabilities = 167;
  NID_X500 = 11;
  NID_X509 = 12;
  NID_algorithm = 38;
  NID_authority_key_identifier = 90;
  NID_basic_constraints = 87;
  NID_bf_cbc = 91;
  NID_bf_cfb64 = 93;
  NID_bf_ecb = 92;
  NID_bf_ofb64 = 94;
  NID_cast5_cbc = 108;
  NID_cast5_cfb64 = 110;
  NID_cast5_ecb = 109;
  NID_cast5_ofb64 = 111;
  NID_certBag = 152;
  NID_certificate_policies = 89;
  NID_client_auth = 130;
  NID_code_sign = 131;
  NID_commonName = 13;
  NID_countryName = 14;
  NID_crlBag = 153;
  NID_crl_distribution_points = 103;
  NID_crl_number = 88;
  NID_crl_reason = 141;
  NID_delta_crl = 140;
  NID_des_cbc = 31;
  NID_des_cfb64 = 30;
  NID_des_ecb = 29;
  NID_des_ede = 32;
  NID_des_ede3 = 33;
  NID_des_ede3_cbc = 44;
  NID_des_ede3_cfb64 = 61;
  NID_des_ede3_ofb64 = 63;
  NID_des_ede_cbc = 43;
  NID_des_ede_cfb64 = 60;
  NID_des_ede_ofb64 = 62;
  NID_des_ofb64 = 45;
  NID_description = 107;
  NID_desx_cbc = 80;
  NID_email_protect = 132;
  NID_ext_key_usage = 126;
  NID_friendlyName = 156;
  NID_givenName = 99;
  NID_hmacWithSHA1 = 163;
  NID_id_kp = 128;
  NID_id_pbkdf2 = 69;
  NID_id_pkix = 127;
  NID_id_qt_cps = 164;
  NID_id_qt_unotice = 165;
  NID_idea_cbc = 34;
  NID_idea_cfb64 = 35;
  NID_idea_ecb = 36;
  NID_idea_ofb64 = 46;
  NID_initials = 101;
  NID_invalidity_date = 142;
  NID_issuer_alt_name = 86;
  NID_keyBag = 150;
  NID_key_usage = 83;
  NID_ld_ce = 81;
  NID_localKeyID = 157;
  NID_localityName = 15;
  NID_md2 = 3;
  NID_md2WithRSAEncryption = 7;
  NID_md5 = 4;
  NID_md5WithRSA = 104;
  NID_md5WithRSAEncryption = 8;
  NID_md5_sha1 = 114;
  NID_mdc2 = 95;
  NID_mdc2WithRSA = 96;
  NID_ms_code_com = 135;
  NID_ms_code_ind = 134;
  NID_ms_ctl_sign = 136;
  NID_ms_efs = 138;
  NID_ms_sgc = 137;
  NID_netscape = 57;
  NID_netscape_base_url = 72;
  NID_netscape_ca_policy_url = 76;
  NID_netscape_ca_revocation_url = 74;
  NID_netscape_cert_extension = 58;
  NID_netscape_cert_sequence = 79;
  NID_netscape_cert_type = 71;
  NID_netscape_comment = 78;
  NID_netscape_data_type = 59;
  NID_netscape_renewal_url = 75;
  NID_netscape_revocation_url = 73;
  NID_netscape_ssl_server_name = 77;
  NID_ns_sgc = 139;
  NID_organizationName = 17;
  NID_organizationalUnitName = 18;
  NID_pbeWithMD2AndDES_CBC = 9;
  NID_pbeWithMD2AndRC2_CBC = 168;
  NID_pbeWithMD5AndCast5_CBC = 112;
  NID_pbeWithMD5AndDES_CBC = 10;
  NID_pbeWithMD5AndRC2_CBC = 169;
  NID_pbeWithSHA1AndDES_CBC = 170;
  NID_pbeWithSHA1AndRC2_CBC = 68;
  NID_pbe_WithSHA1And128BitRC2_CBC = 148;
  NID_pbe_WithSHA1And128BitRC4 = 144;
  NID_pbe_WithSHA1And2_Key_TripleDES_CBC = 147;
  NID_pbe_WithSHA1And3_Key_TripleDES_CBC = 146;
  NID_pbe_WithSHA1And40BitRC2_CBC = 149;
  NID_pbe_WithSHA1And40BitRC4 = 145;
  NID_pbes2 = 161;
  NID_pbmac1 = 162;
  NID_pkcs = 2;
  NID_pkcs3 = 27;
  NID_pkcs7 = 20;
  NID_pkcs7_data = 21;
  NID_pkcs7_digest = 25;
  NID_pkcs7_encrypted = 26;
  NID_pkcs7_enveloped = 23;
  NID_pkcs7_signed = 22;
  NID_pkcs7_signedAndEnveloped = 24;
  NID_pkcs8ShroudedKeyBag = 151;
  NID_pkcs9 = 47;
  NID_pkcs9_challengePassword = 54;
  NID_pkcs9_contentType = 50;
  NID_pkcs9_countersignature = 53;
  NID_pkcs9_emailAddress = 48;
  NID_pkcs9_extCertAttributes = 56;
  NID_pkcs9_messageDigest = 51;
  NID_pkcs9_signingTime = 52;
  NID_pkcs9_unstructuredAddress = 55;
  NID_pkcs9_unstructuredName = 49;
  NID_private_key_usage_period = 84;
  NID_rc2_40_cbc = 98;
  NID_rc2_64_cbc = 166;
  NID_rc2_cbc = 37;
  NID_rc2_cfb64 = 39;
  NID_rc2_ecb = 38;
  NID_rc2_ofb64 = 40;
  NID_rc4 = 5;
  NID_rc4_40 = 97;
  NID_rc5_cbc = 120;
  NID_rc5_cfb64 = 122;
  NID_rc5_ecb = 121;
  NID_rc5_ofb64 = 123;
  NID_ripemd160 = 117;
  NID_ripemd160WithRSA = 119;
  NID_rle_compression = 124;
  NID_rsadsi = 1;
  NID_safeContentsBag = 155;
  NID_sdsiCertificate = 159;
  NID_secretBag = 154;
  NID_serialNumber = 105;
  NID_server_auth = 129;
  NID_sha = 41;
  NID_sha1 = 64;
  NID_sha1WithRSA = 115;
  NID_sha1WithRSAEncryption = 65;
  NID_shaWithRSAEncryption = 42;
  NID_stateOrProvinceName = 16;
  NID_subject_alt_name = 85;
  NID_subject_key_identifier = 82;
  NID_surname = 100;
  NID_sxnet = 143;
  NID_time_stamp = 133;
  NID_title = 106;
  NID_uniqueIdentifier = 102;
  NID_x509Certificate = 158;
  NID_x509Crl = 160;
  NID_zlib_compression = 125;
  OBJ_F_OBJ_CREATE = 100;
  OBJ_F_OBJ_DUP = 101;
  OBJ_F_OBJ_NID2LN = 102;
  OBJ_F_OBJ_NID2OBJ = 103;
  OBJ_F_OBJ_NID2SN = 104;
  OBJ_NAME_ALIAS = $8000;
  OBJ_NAME_TYPE_CIPHER_METH = $02;
  OBJ_NAME_TYPE_COMP_METH = $04;
  OBJ_NAME_TYPE_MD_METH = $01;
  OBJ_NAME_TYPE_NUM = $05;
  OBJ_NAME_TYPE_PKEY_METH = $03;
  OBJ_NAME_TYPE_UNDEF = $00;
  OBJ_R_MALLOC_FAILURE = 100;
  OBJ_R_UNKNOWN_NID = 101;
  OPENSSL_VERSION_NUMBER = $00904100;
  OPENSSL_VERSION_TEXT = 'OpenSSL 0.9.4 09 Aug 1999';
  PEM_BUFSIZE = 1024;
  PEM_DEK_DES_CBC = 40;
  PEM_DEK_DES_ECB = 60;
  PEM_DEK_DES_EDE = 50;
  PEM_DEK_IDEA_CBC = 45;
  PEM_DEK_RSA = 70;
  PEM_DEK_RSA_MD2 = 80;
  PEM_DEK_RSA_MD5 = 90;
  PEM_ERROR = 30;
  PEM_F_DEF_CALLBACK = 100;
  PEM_F_LOAD_IV = 101;
  PEM_F_PEM_ASN1_READ = 102;
  PEM_F_PEM_ASN1_READ_BIO = 103;
  PEM_F_PEM_ASN1_WRITE = 104;
  PEM_F_PEM_ASN1_WRITE_BIO = 105;
  PEM_F_PEM_DO_HEADER = 106;
  PEM_F_PEM_F_PEM_WRITE_PKCS8PRIVATEKEY = 118;
  PEM_F_PEM_GET_EVP_CIPHER_INFO = 107;
  PEM_F_PEM_READ = 108;
  PEM_F_PEM_READ_BIO = 109;
  PEM_F_PEM_SEALFINAL = 110;
  PEM_F_PEM_SEALINIT = 111;
  PEM_F_PEM_SIGNFINAL = 112;
  PEM_F_PEM_WRITE = 113;
  PEM_F_PEM_WRITE_BIO = 114;
  PEM_F_PEM_WRITE_BIO_PKCS8PRIVATEKEY = 119;
  PEM_F_PEM_X509_INFO_READ = 115;
  PEM_F_PEM_X509_INFO_READ_BIO = 116;
  PEM_F_PEM_X509_INFO_WRITE_BIO = 117;
  PEM_MD_MD2 = NID_md2;
  PEM_MD_MD2_RSA = NID_md2WithRSAEncryption;
  PEM_MD_MD5 = NID_md5;
  PEM_MD_MD5_RSA = NID_md5WithRSAEncryption;
  PEM_MD_SHA = NID_sha;
  PEM_MD_SHA_RSA = NID_sha1WithRSAEncryption;
  PEM_OBJ_CRL = 3;
  PEM_OBJ_DHPARAMS = 17;
  PEM_OBJ_DSAPARAMS = 18;
  PEM_OBJ_PRIV_DH = 13;
  PEM_OBJ_PRIV_DSA = 12;
  PEM_OBJ_PRIV_KEY = 10;
  PEM_OBJ_PRIV_RSA = 11;
  PEM_OBJ_PRIV_RSA_PUBLIC = 19;
  PEM_OBJ_PUB_DH = 16;
  PEM_OBJ_PUB_DSA = 15;
  PEM_OBJ_PUB_RSA = 14;
  PEM_OBJ_SSL_SESSION = 4;
  PEM_OBJ_UNDEF = 0;
  PEM_OBJ_X509 = 1;
  PEM_OBJ_X509_REQ = 2;
  PEM_R_BAD_BASE64_DECODE = 100;
  PEM_R_BAD_DECRYPT = 101;
  PEM_R_BAD_END_LINE = 102;
  PEM_R_BAD_IV_CHARS = 103;
  PEM_R_BAD_PASSWORD_READ = 104;
  PEM_R_ERROR_CONVERTING_PRIVATE_KEY = 115;
  PEM_R_NOT_DEK_INFO = 105;
  PEM_R_NOT_ENCRYPTED = 106;
  PEM_R_NOT_PROC_TYPE = 107;
  PEM_R_NO_START_LINE = 108;
  PEM_R_PROBLEMS_GETTING_PASSWORD = 109;
  PEM_R_PUBLIC_KEY_NO_RSA = 110;
  PEM_R_READ_KEY = 111;
  PEM_R_SHORT_HEADER = 112;
  PEM_R_UNSUPPORTED_CIPHER = 113;
  PEM_R_UNSUPPORTED_ENCRYPTION = 114;
  PEM_STRING_DHPARAMS = 'DH PARAMETERS';
  PEM_STRING_DSA = 'DSA PRIVATE KEY';
  PEM_STRING_DSAPARAMS = 'DSA PARAMETERS';
  PEM_STRING_EVP_PKEY = 'ANY PRIVATE KEY';
  PEM_STRING_PKCS7 = 'PKCS7';
  PEM_STRING_PKCS8 = 'ENCRYPTED PRIVATE KEY';
  PEM_STRING_PKCS8INF = 'PRIVATE KEY';
  PEM_STRING_RSA = 'RSA PRIVATE KEY';
  PEM_STRING_RSA_PUBLIC = 'RSA PUBLIC KEY';
  PEM_STRING_SSL_SESSION = 'SSL SESSION PARAMETERS';
  PEM_STRING_X509 = 'CERTIFICATE';
  PEM_STRING_X509_CRL = 'X509 CRL';
  PEM_STRING_X509_OLD = 'X509 CERTIFICATE';
  PEM_STRING_X509_REQ = 'CERTIFICATE REQUEST';
  PEM_STRING_X509_REQ_OLD = 'NEW CERTIFICATE REQUEST';
  PEM_TYPE_CLEAR = 40;
  PEM_TYPE_ENCRYPTED = 10;
  PEM_TYPE_MIC_CLEAR = 30;
  PEM_TYPE_MIC_ONLY = 20;
  PKCS5_DEFAULT_ITER = 2048;
  PKCS5_SALT_LEN = 8;
  PKCS7_F_PKCS7_ADD_CERTIFICATE = 100;
  PKCS7_F_PKCS7_ADD_CRL = 101;
  PKCS7_F_PKCS7_ADD_RECIPIENT_INFO = 102;
  PKCS7_F_PKCS7_ADD_SIGNER = 103;
  PKCS7_F_PKCS7_CTRL = 104;
  PKCS7_F_PKCS7_DATADECODE = 112;
  PKCS7_F_PKCS7_DATAINIT = 105;
  PKCS7_F_PKCS7_DATASIGN = 106;
  PKCS7_F_PKCS7_DATAVERIFY = 107;
  PKCS7_F_PKCS7_SET_CIPHER = 108;
  PKCS7_F_PKCS7_SET_CONTENT = 109;
  PKCS7_F_PKCS7_SET_TYPE = 110;
  PKCS7_F_PKCS7_SIGNATUREVERIFY = 113;
  PKCS7_OP_GET_DETACHED_SIGNATURE = 2;
  PKCS7_OP_SET_DETACHED_SIGNATURE = 1;
  PKCS7_R_CIPHER_NOT_INITIALIZED = 116;
  PKCS7_R_DECRYPTED_KEY_IS_WRONG_LENGTH = 100;
  PKCS7_R_DIGEST_FAILURE = 101;
  PKCS7_R_INTERNAL_ERROR = 102;
  PKCS7_R_MISSING_CERIPEND_INFO = 103;
  PKCS7_R_NO_RECIPIENT_MATCHES_CERTIFICATE = 115;
  PKCS7_R_OPERATION_NOT_SUPPORTED_ON_THIS_TYPE = 104;
  PKCS7_R_SIGNATURE_FAILURE = 105;
  PKCS7_R_UNABLE_TO_FIND_CERTIFICATE = 106;
  PKCS7_R_UNABLE_TO_FIND_MEM_BIO = 107;
  PKCS7_R_UNABLE_TO_FIND_MESSAGE_DIGEST = 108;
  PKCS7_R_UNKNOWN_DIGEST_TYPE = 109;
  PKCS7_R_UNKNOWN_OPERATION = 110;
  PKCS7_R_UNSUPPORTED_CIPHER_TYPE = 111;
  PKCS7_R_UNSUPPORTED_CONTENT_TYPE = 112;
  PKCS7_R_WRONG_CONTENT_TYPE = 113;
  PKCS7_R_WRONG_PKCS7_TYPE = 114;
  PKCS7_S_BODY = 1;
  PKCS7_S_HEADER = 0;
  PKCS7_S_TAIL = 2;
  PKCS8_NO_OCTET = 1;
  PKCS8_OK = 0;
  P_tmpdir = '/tmp';
  MSS_RAND_MAX = $7fffffff;
  RC2_BLOCK = 8;
  RC2_DECRYPT = 0;
  RC2_ENCRYPT = 1;
  RC2_KEY_LENGTH = 16;
  RC5_12_ROUNDS = 12;
  RC5_16_ROUNDS = 16;
  RC5_32_BLOCK = 8;
  RC5_32_KEY_LENGTH = 16;
  RC5_8_ROUNDS = 8;
  RC5_DECRYPT = 0;
  RC5_ENCRYPT = 1;
  RIPEMD160_BLOCK = 16;
  RIPEMD160_CBLOCK = 64;
  RIPEMD160_DIGEST_LENGTH = 20;
  RIPEMD160_LAST_BLOCK = 56;
  RIPEMD160_LBLOCK = 16;
  RIPEMD160_LENGTH_BLOCK = 8;
  RSA_3 = $3;
  RSA_F4 = $10001;
  RSA_FLAG_BLINDING = $08;
  RSA_FLAG_CACHE_PRIVATE = $04;
  RSA_FLAG_CACHE_PUBLIC = $02;
  RSA_FLAG_EXT_PKEY = $20;
  RSA_FLAG_THREAD_SAFE = $10;
  RSA_F_MEMORY_LOCK = 100;
  RSA_F_RSA_CHECK_KEY = 123;
  RSA_F_RSA_EAY_PRIVATE_DECRYPT = 101;
  RSA_F_RSA_EAY_PRIVATE_ENCRYPT = 102;
  RSA_F_RSA_EAY_PUBLIC_DECRYPT = 103;
  RSA_F_RSA_EAY_PUBLIC_ENCRYPT = 104;
  RSA_F_RSA_GENERATE_KEY = 105;
  RSA_F_RSA_NEW_METHOD = 106;
  RSA_F_RSA_PADDING_ADD_NONE = 107;
  RSA_F_RSA_PADDING_ADD_PKCS1_OAEP = 121;
  RSA_F_RSA_PADDING_ADD_PKCS1_TYPE_1 = 108;
  RSA_F_RSA_PADDING_ADD_PKCS1_TYPE_2 = 109;
  RSA_F_RSA_PADDING_ADD_SSLV23 = 110;
  RSA_F_RSA_PADDING_CHECK_NONE = 111;
  RSA_F_RSA_PADDING_CHECK_PKCS1_OAEP = 122;
  RSA_F_RSA_PADDING_CHECK_PKCS1_TYPE_1 = 112;
  RSA_F_RSA_PADDING_CHECK_PKCS1_TYPE_2 = 113;
  RSA_F_RSA_PADDING_CHECK_SSLV23 = 114;
  RSA_F_RSA_PRINT = 115;
  RSA_F_RSA_PRINT_FP = 116;
  RSA_F_RSA_SIGN = 117;
  RSA_F_RSA_SIGN_ASN1_OCTET_STRING = 118;
  RSA_F_RSA_VERIFY = 119;
  RSA_F_RSA_VERIFY_ASN1_OCTET_STRING = 120;
  RSA_METHOD_FLAG_NO_CHECK = $01;
  RSA_NO_PADDING = 3;
  RSA_PKCS1_OAEP_PADDING = 4;
  RSA_PKCS1_PADDING = 1;
  RSA_R_ALGORITHM_MISMATCH = 100;
  RSA_R_BAD_E_VALUE = 101;
  RSA_R_BAD_FIXED_HEADER_DECRYPT = 102;
  RSA_R_BAD_PAD_BYTE_COUNT = 103;
  RSA_R_BAD_SIGNATURE = 104;
  RSA_R_BLOCK_TYPE_IS_NOT_01 = 106;
  RSA_R_BLOCK_TYPE_IS_NOT_02 = 107;
  RSA_R_DATA_GREATER_THAN_MOD_LEN = 108;
  RSA_R_DATA_TOO_LARGE = 109;
  RSA_R_DATA_TOO_LARGE_FOR_KEY_SIZE = 110;
  RSA_R_DATA_TOO_SMALL = 111;
  RSA_R_DATA_TOO_SMALL_FOR_KEY_SIZE = 122;
  RSA_R_DIGEST_TOO_BIG_FOR_RSA_KEY = 112;
  RSA_R_DMP1_NOT_CONGRUENT_TO_D = 124;
  RSA_R_DMQ1_NOT_CONGRUENT_TO_D = 125;
  RSA_R_D_E_NOT_CONGRUENT_TO_1 = 123;
  RSA_R_IQMP_NOT_INVERSE_OF_Q = 126;
  RSA_R_KEY_SIZE_TOO_SMALL = 120;
  RSA_R_NULL_BEFORE_BLOCK_MISSING = 113;
  RSA_R_N_DOES_NOT_EQUAL_P_Q = 127;
  RSA_R_OAEP_DECODING_ERROR = 121;
  RSA_R_PADDING_CHECK_FAILED = 114;
  RSA_R_P_NOT_PRIME = 128;
  RSA_R_Q_NOT_PRIME = 129;
  RSA_R_SSLV3_ROLLBACK_ATTACK = 115;
  RSA_R_THE_ASN1_OBJECT_IDENTIFIER_IS_NOT_KNOWN_FOR_THIS_MD = 116;
  RSA_R_UNKNOWN_ALGORITHM_TYPE = 117;
  RSA_R_UNKNOWN_PADDING_TYPE = 118;
  RSA_R_WRONG_SIGNATURE_LENGTH = 119;
  RSA_SSLV23_PADDING = 2;
  SEEK_CUR = 1;
  SEEK_END = 2;
  SEEK_SET = 0;
  SHA_DIGEST_LENGTH = 20;
  SHA_LBLOCK = 16;
  SN_Algorithm = 'Algorithm';
  SN_SMIMECapabilities = 'SMIME-CAPS';
  SN_authority_key_identifier = 'authorityKeyIdentifier';
  SN_basic_constraints = 'basicConstraints';
  SN_bf_cbc = 'BF-CBC';
  SN_bf_cfb64 = 'BF-CFB';
  SN_bf_ecb = 'BF-ECB';
  SN_bf_ofb64 = 'BF-OFB';
  SN_cast5_cbc = 'CAST5-CBC';
  SN_cast5_cfb64 = 'CAST5-CFB';
  SN_cast5_ecb = 'CAST5-ECB';
  SN_cast5_ofb64 = 'CAST5-OFB';
  SN_certificate_policies = 'certificatePolicies';
  SN_client_auth = 'clientAuth';
  SN_code_sign = 'codeSigning';
  SN_commonName = 'CN';
  SN_countryName = 'C';
  SN_crl_distribution_points = 'crlDistributionPoints';
  SN_crl_number = 'crlNumber';
  SN_crl_reason = 'CRLReason';
  SN_delta_crl = 'deltaCRL';
  SN_des_cbc = 'DES-CBC';
  SN_des_cfb64 = 'DES-CFB';
  SN_des_ecb = 'DES-ECB';
  SN_des_ede = 'DES-EDE';
  SN_des_ede3 = 'DES-EDE3';
  SN_des_ede3_cbc = 'DES-EDE3-CBC';
  SN_des_ede3_cfb64 = 'DES-EDE3-CFB';
  SN_des_ede3_ofb64 = 'DES-EDE3-OFB';
  SN_des_ede_cbc = 'DES-EDE-CBC';
  SN_des_ede_cfb64 = 'DES-EDE-CFB';
  SN_des_ede_ofb64 = 'DES-EDE-OFB';
  SN_des_ofb64 = 'DES-OFB';
  SN_description = 'D';
  SN_desx_cbc = 'DESX-CBC';
  SN_dsa = 'DSA';
  SN_dsaWithSHA = 'DSA-SHA';
  SN_dsaWithSHA1 = 'DSA-SHA1';
  SN_dsaWithSHA1_2 = 'DSA-SHA1-old';
  SN_dsa_2 = 'DSA-old';
  SN_email_protect = 'emailProtection';
  SN_ext_key_usage = 'extendedKeyUsage';
  SN_givenName = 'G';
  SN_id_kp = 'id-kp';
  SN_id_pkix = 'PKIX';
  SN_id_qt_cps = 'id-qt-cps';
  SN_id_qt_unotice = 'id-qt-unotice';
  SN_idea_cbc = 'IDEA-CBC';
  SN_idea_cfb64 = 'IDEA-CFB';
  SN_idea_ecb = 'IDEA-ECB';
  SN_idea_ofb64 = 'IDEA-OFB';
  SN_initials = 'I';
  SN_invalidity_date = 'invalidityDate';
  SN_issuer_alt_name = 'issuerAltName';
  SN_key_usage = 'keyUsage';
  SN_ld_ce = 'ld-ce';
  SN_localityName = 'L';
  SN_md2 = 'MD2';
  SN_md2WithRSAEncryption = 'RSA-MD2';
  SN_md5 = 'MD5';
  SN_md5WithRSA = 'RSA-NP-MD5';
  SN_md5WithRSAEncryption = 'RSA-MD5';
  SN_md5_sha1 = 'MD5-SHA1';
  SN_mdc2 = 'MDC2';
  SN_mdc2WithRSA = 'RSA-MDC2';
  SN_ms_code_com = 'msCodeCom';
  SN_ms_code_ind = 'msCodeInd';
  SN_ms_ctl_sign = 'msCTLSign';
  SN_ms_efs = 'msEFS';
  SN_ms_sgc = 'msSGC';
  SN_netscape = 'Netscape';
  SN_netscape_base_url = 'nsBaseUrl';
  SN_netscape_ca_policy_url = 'nsCaPolicyUrl';
  SN_netscape_ca_revocation_url = 'nsCaRevocationUrl';
  SN_netscape_cert_extension = 'nsCertExt';
  SN_netscape_cert_sequence = 'nsCertSequence';
  SN_netscape_cert_type = 'nsCertType';
  SN_netscape_comment = 'nsComment';
  SN_netscape_data_type = 'nsDataType';
  SN_netscape_renewal_url = 'nsRenewalUrl';
  SN_netscape_revocation_url = 'nsRevocationUrl';
  SN_netscape_ssl_server_name = 'nsSslServerName';
  SN_ns_sgc = 'nsSGC';
  SN_organizationName = 'O';
  SN_organizationalUnitName = 'OU';
  SN_pkcs9_emailAddress = 'Email';
  SN_private_key_usage_period = 'privateKeyUsagePeriod';
  SN_rc2_40_cbc = 'RC2-40-CBC';
  SN_rc2_64_cbc = 'RC2-64-CBC';
  SN_rc2_cbc = 'RC2-CBC';
  SN_rc2_cfb64 = 'RC2-CFB';
  SN_rc2_ecb = 'RC2-ECB';
  SN_rc2_ofb64 = 'RC2-OFB';
  SN_rc4 = 'RC4';
  SN_rc4_40 = 'RC4-40';
  SN_rc5_cbc = 'RC5-CBC';
  SN_rc5_cfb64 = 'RC5-CFB';
  SN_rc5_ecb = 'RC5-ECB';
  SN_rc5_ofb64 = 'RC5-OFB';
  SN_ripemd160 = 'RIPEMD160';
  SN_ripemd160WithRSA = 'RSA-RIPEMD160';
  SN_rle_compression = 'RLE';
  SN_rsa = 'RSA';
  SN_serialNumber = 'SN';
  SN_server_auth = 'serverAuth';
  SN_sha = 'SHA';
  SN_sha1 = 'SHA1';
  SN_sha1WithRSA = 'RSA-SHA1-2';
  SN_sha1WithRSAEncryption = 'RSA-SHA1';
  SN_shaWithRSAEncryption = 'RSA-SHA';
  SN_stateOrProvinceName = 'ST';
  SN_subject_alt_name = 'subjectAltName';
  SN_subject_key_identifier = 'subjectKeyIdentifier';
  SN_surname = 'S';
  SN_sxnet = 'SXNetID';
  SN_time_stamp = 'timeStamping';
  SN_title = 'T';
  SN_undef = 'UNDEF';
  SN_uniqueIdentifier = 'UID';
  SN_zlib_compression = 'ZLIB';
  SSL_ST_CONNECT = $1000;
  SSL23_ST_CR_SRVR_HELLO_A = $220 or SSL_ST_CONNECT;
  SSL23_ST_CR_SRVR_HELLO_B = $221 or SSL_ST_CONNECT;
  SSL23_ST_CW_CLNT_HELLO_A = $210 or SSL_ST_CONNECT;
  SSL23_ST_CW_CLNT_HELLO_B = $211 or SSL_ST_CONNECT;
  SSL_ST_ACCEPT = $2000;
  SSL23_ST_SR_CLNT_HELLO_A = $210 or SSL_ST_ACCEPT;
  SSL23_ST_SR_CLNT_HELLO_B = $211 or SSL_ST_ACCEPT;
  SSL2_AT_MD5_WITH_RSA_ENCRYPTION = $01;
  SSL2_CF_5_BYTE_ENC = $01;
  SSL2_CF_8_BYTE_ENC = $02;
  SSL2_CHALLENGE_LENGTH = 16;
  SSL2_CK_DES_192_EDE3_CBC_WITH_MD5 = $020700c0;
  SSL2_CK_DES_192_EDE3_CBC_WITH_SHA = $020701c0;
  SSL2_CK_DES_64_CBC_WITH_MD5 = $02060040;
  SSL2_CK_DES_64_CBC_WITH_SHA = $02060140;
  SSL2_CK_DES_64_CFB64_WITH_MD5_1 = $02ff0800;
  SSL2_CK_IDEA_128_CBC_WITH_MD5 = $02050080;
  SSL2_CK_NULL = $02ff0810;
  SSL2_CK_NULL_WITH_MD5 = $02000000;
  SSL2_CK_RC2_128_CBC_EXPORT40_WITH_MD5 = $02040080;
  SSL2_CK_RC2_128_CBC_WITH_MD5 = $02030080;
  SSL2_CK_RC4_128_EXPORT40_WITH_MD5 = $02020080;
  SSL2_CK_RC4_128_WITH_MD5 = $02010080;
  SSL2_CK_RC4_64_WITH_MD5 = $02080080;
  SSL2_CONNECTION_ID_LENGTH = 16;
  SSL2_CT_X509_CERTIFICATE = $01;
  SSL2_MAX_CERT_CHALLENGE_LENGTH = 32;
  SSL2_MAX_CHALLENGE_LENGTH = 32;
  SSL2_MAX_CONNECTION_ID_LENGTH = 16;
  SSL2_MAX_KEY_MATERIAL_LENGTH = 24;
  SSL2_MAX_MASTER_KEY_LENGTH_IN_BITS = 256;
  SSL2_MAX_RECORD_LENGTH_3_BYTE_HEADER = 16383;
  SSL2_MAX_SSL_SESSION_ID_LENGTH = 32;
  SSL2_MIN_CERT_CHALLENGE_LENGTH = 16;
  SSL2_MIN_CHALLENGE_LENGTH = 16;
  SSL2_MT_CLIENT_CERTIFICATE = 8;
  SSL2_MT_CLIENT_FINISHED = 3;
  SSL2_MT_CLIENT_HELLO = 1;
  SSL2_MT_CLIENT_MASTER_KEY = 2;
  SSL2_MT_ERROR = 0;
  SSL2_MT_REQUEST_CERTIFICATE = 7;
  SSL2_MT_SERVER_FINISHED = 6;
  SSL2_MT_SERVER_HELLO = 4;
  SSL2_MT_SERVER_VERIFY = 5;
  SSL2_PE_BAD_CERTIFICATE = $0004;
  SSL2_PE_NO_CERTIFICATE = $0002;
  SSL2_PE_NO_CIPHER = $0001;
  SSL2_PE_UNDEFINED_ERROR = $0000;
  SSL2_PE_UNSUPPORTED_CERTIFICATE_TYPE = $0006;
  SSL2_SSL_SESSION_ID_LENGTH = 16;
  SSL2_ST_CLIENT_START_ENCRYPTION = $80 or SSL_ST_CONNECT;
  SSL2_ST_GET_CLIENT_FINISHED_A = $50 or SSL_ST_ACCEPT;
  SSL2_ST_GET_CLIENT_FINISHED_B = $51 or SSL_ST_ACCEPT;
  SSL2_ST_GET_CLIENT_HELLO_A = $10 or SSL_ST_ACCEPT;
  SSL2_ST_GET_CLIENT_HELLO_B = $11 or SSL_ST_ACCEPT;
  SSL2_ST_GET_CLIENT_HELLO_C = $12 or SSL_ST_ACCEPT;
  SSL2_ST_GET_CLIENT_MASTER_KEY_A = $30 or SSL_ST_ACCEPT;
  SSL2_ST_GET_CLIENT_MASTER_KEY_B = $31 or SSL_ST_ACCEPT;
  SSL2_ST_GET_SERVER_FINISHED_A = $70 or SSL_ST_CONNECT;
  SSL2_ST_GET_SERVER_FINISHED_B = $71 or SSL_ST_CONNECT;
  SSL2_ST_GET_SERVER_HELLO_A = $20 or SSL_ST_CONNECT;
  SSL2_ST_GET_SERVER_HELLO_B = $21 or SSL_ST_CONNECT;
  SSL2_ST_GET_SERVER_VERIFY_A = $60 or SSL_ST_CONNECT;
  SSL2_ST_GET_SERVER_VERIFY_B = $61 or SSL_ST_CONNECT;
  SSL2_ST_SEND_CLIENT_CERTIFICATE_A = $50 or SSL_ST_CONNECT;
  SSL2_ST_SEND_CLIENT_CERTIFICATE_B = $51 or SSL_ST_CONNECT;
  SSL2_ST_SEND_CLIENT_CERTIFICATE_C = $52 or SSL_ST_CONNECT;
  SSL2_ST_SEND_CLIENT_CERTIFICATE_D = $53 or SSL_ST_CONNECT;
  SSL2_ST_SEND_CLIENT_FINISHED_A = $40 or SSL_ST_CONNECT;
  SSL2_ST_SEND_CLIENT_FINISHED_B = $41 or SSL_ST_CONNECT;
  SSL2_ST_SEND_CLIENT_HELLO_A = $10 or SSL_ST_CONNECT;
  SSL2_ST_SEND_CLIENT_HELLO_B = $11 or SSL_ST_CONNECT;
  SSL2_ST_SEND_CLIENT_MASTER_KEY_A = $30 or SSL_ST_CONNECT;
  SSL2_ST_SEND_CLIENT_MASTER_KEY_B = $31 or SSL_ST_CONNECT;
  SSL2_ST_SEND_REQUEST_CERTIFICATE_A = $70 or SSL_ST_ACCEPT;
  SSL2_ST_SEND_REQUEST_CERTIFICATE_B = $71 or SSL_ST_ACCEPT;
  SSL2_ST_SEND_REQUEST_CERTIFICATE_C = $72 or SSL_ST_ACCEPT;
  SSL2_ST_SEND_REQUEST_CERTIFICATE_D = $73 or SSL_ST_ACCEPT;
  SSL2_ST_SEND_SERVER_FINISHED_A = $60 or SSL_ST_ACCEPT;
  SSL2_ST_SEND_SERVER_FINISHED_B = $61 or SSL_ST_ACCEPT;
  SSL2_ST_SEND_SERVER_HELLO_A = $20 or SSL_ST_ACCEPT;
  SSL2_ST_SEND_SERVER_HELLO_B = $21 or SSL_ST_ACCEPT;
  SSL2_ST_SEND_SERVER_VERIFY_A = $40 or SSL_ST_ACCEPT;
  SSL2_ST_SEND_SERVER_VERIFY_B = $41 or SSL_ST_ACCEPT;
  SSL2_ST_SEND_SERVER_VERIFY_C = $42 or SSL_ST_ACCEPT;
  SSL2_ST_SERVER_START_ENCRYPTION = $80 or SSL_ST_ACCEPT;
  SSL2_ST_X509_GET_CLIENT_CERTIFICATE = $90 or SSL_ST_CONNECT;
  SSL2_ST_X509_GET_SERVER_CERTIFICATE = $90 or SSL_ST_ACCEPT;
  SSL2_TXT_DES_192_EDE3_CBC_WITH_MD5 = 'DES-CBC3-MD5';
  SSL2_TXT_DES_192_EDE3_CBC_WITH_SHA = 'DES-CBC3-SHA';
  SSL2_TXT_DES_64_CBC_WITH_MD5 = 'DES-CBC-MD5';
  SSL2_TXT_DES_64_CBC_WITH_SHA = 'DES-CBC-SHA';
  SSL2_TXT_DES_64_CFB64_WITH_MD5_1 = 'DES-CFB-M1';
  SSL2_TXT_IDEA_128_CBC_WITH_MD5 = 'IDEA-CBC-MD5';
  SSL2_TXT_NULL = 'NULL';
  SSL2_TXT_NULL_WITH_MD5 = 'NULL-MD5';
  SSL2_TXT_RC2_128_CBC_EXPORT40_WITH_MD5 = 'EXP-RC2-CBC-MD5';
  SSL2_TXT_RC2_128_CBC_WITH_MD5 = 'RC2-CBC-MD5';
  SSL2_TXT_RC4_128_EXPORT40_WITH_MD5 = 'EXP-RC4-MD5';
  SSL2_TXT_RC4_128_WITH_MD5 = 'RC4-MD5';
  SSL2_TXT_RC4_64_WITH_MD5 = 'RC4-64-MD5';
  SSL2_VERSION = $0002;
  SSL2_VERSION_MAJOR = $00;
  SSL2_VERSION_MINOR = $02;
  SSL3_AD_BAD_CERTIFICATE = 42;
  SSL3_AD_BAD_RECORD_MAC = 20;
  SSL3_AD_CERTIFICATE_EXPIRED = 45;
  SSL3_AD_CERTIFICATE_REVOKED = 44;
  SSL3_AD_CERTIFICATE_UNKNOWN = 46;
  SSL3_AD_CLOSE_NOTIFY = 0;
  SSL3_AD_DECOMPRESSION_FAILURE = 30;
  SSL3_AD_HANDSHAKE_FAILURE = 40;
  SSL3_AD_ILLEGAL_PARAMETER = 47;
  SSL3_AD_NO_CERTIFICATE = 41;
  SSL3_AD_UNEXPECTED_MESSAGE = 10;
  SSL3_AD_UNSUPPORTED_CERTIFICATE = 43;
  SSL3_AL_FATAL = 2;
  SSL3_AL_WARNING = 1;
  SSL3_CC_CLIENT = $10;
  SSL3_CC_READ = $01;
  SSL3_CC_SERVER = $20;
  SSL3_CC_WRITE = $02;
  SSL3_CHANGE_CIPHER_CLIENT_READ = SSL3_CC_CLIENT or SSL3_CC_READ;
  SSL3_CHANGE_CIPHER_CLIENT_WRITE = SSL3_CC_CLIENT or SSL3_CC_WRITE;
  SSL3_CHANGE_CIPHER_SERVER_READ = SSL3_CC_SERVER or SSL3_CC_READ;
  SSL3_CHANGE_CIPHER_SERVER_WRITE = SSL3_CC_SERVER or SSL3_CC_WRITE;
  SSL3_CK_ADH_DES_192_CBC_SHA = $0300001B;
  SSL3_CK_ADH_DES_40_CBC_SHA = $03000019;
  SSL3_CK_ADH_DES_64_CBC_SHA = $0300001A;
  SSL3_CK_ADH_RC4_128_MD5 = $03000018;
  SSL3_CK_ADH_RC4_40_MD5 = $03000017;
  SSL3_CK_DH_DSS_DES_192_CBC3_SHA = $0300000D;
  SSL3_CK_DH_DSS_DES_40_CBC_SHA = $0300000B;
  SSL3_CK_DH_DSS_DES_64_CBC_SHA = $0300000C;
  SSL3_CK_DH_RSA_DES_192_CBC3_SHA = $03000010;
  SSL3_CK_DH_RSA_DES_40_CBC_SHA = $0300000E;
  SSL3_CK_DH_RSA_DES_64_CBC_SHA = $0300000F;
  SSL3_CK_EDH_DSS_DES_192_CBC3_SHA = $03000013;
  SSL3_CK_EDH_DSS_DES_40_CBC_SHA = $03000011;
  SSL3_CK_EDH_DSS_DES_64_CBC_SHA = $03000012;
  SSL3_CK_EDH_RSA_DES_192_CBC3_SHA = $03000016;
  SSL3_CK_EDH_RSA_DES_40_CBC_SHA = $03000014;
  SSL3_CK_EDH_RSA_DES_64_CBC_SHA = $03000015;
  SSL3_CK_FZA_DMS_FZA_SHA = $0300001D;
  SSL3_CK_FZA_DMS_NULL_SHA = $0300001C;
  SSL3_CK_FZA_DMS_RC4_SHA = $0300001E;
  SSL3_CK_RSA_DES_192_CBC3_SHA = $0300000A;
  SSL3_CK_RSA_DES_40_CBC_SHA = $03000008;
  SSL3_CK_RSA_DES_64_CBC_SHA = $03000009;
  SSL3_CK_RSA_IDEA_128_SHA = $03000007;
  SSL3_CK_RSA_NULL_MD5 = $03000001;
  SSL3_CK_RSA_NULL_SHA = $03000002;
  SSL3_CK_RSA_RC2_40_MD5 = $03000006;
  SSL3_CK_RSA_RC4_128_MD5 = $03000004;
  SSL3_CK_RSA_RC4_128_SHA = $03000005;
  SSL3_CK_RSA_RC4_40_MD5 = $03000003;
  SSL3_CT_DSS_EPHEMERAL_DH = 6;
  SSL3_CT_DSS_FIXED_DH = 4;
  SSL3_CT_DSS_SIGN = 2;
  SSL3_CT_FORTEZZA_DMS = 20;
  SSL3_CT_NUMBER = 7;
  SSL3_CT_RSA_EPHEMERAL_DH = 5;
  SSL3_CT_RSA_FIXED_DH = 3;
  SSL3_CT_RSA_SIGN = 1;
  SSL3_FLAGS_DELAY_CLIENT_FINISHED = $0002;
  SSL3_FLAGS_NO_RENEGOTIATE_CIPHERS = $0001;
  SSL3_FLAGS_POP_BUFFER = $0004;
  SSL3_MASTER_SECRET_SIZE = 48;
  SSL3_MAX_SSL_SESSION_ID_LENGTH = 32;
  SSL3_MT_CCS = 1;
  SSL3_MT_CERTIFICATE = 11;
  SSL3_MT_CERTIFICATE_REQUEST = 13;
  SSL3_MT_CERTIFICATE_VERIFY = 15;
  SSL3_MT_CLIENT_HELLO = 1;
  SSL3_MT_CLIENT_KEY_EXCHANGE = 16;
  SSL3_MT_CLIENT_REQUEST = 0;
  SSL3_MT_FINISHED = 20;
  SSL3_MT_SERVER_DONE = 14;
  SSL3_MT_SERVER_HELLO = 2;
  SSL3_MT_SERVER_KEY_EXCHANGE = 12;
  SSL3_RANDOM_SIZE = 32;
  SSL3_RS_BLANK = 1;
  SSL3_RS_ENCODED = 2;
  SSL3_RS_PART_READ = 4;
  SSL3_RS_PART_WRITE = 5;
  SSL3_RS_PLAIN = 3;
  SSL3_RS_READ_MORE = 3;
  SSL3_RT_ALERT = 21;
  SSL3_RT_APPLICATION_DATA = 23;
  SSL3_RT_CHANGE_CIPHER_SPEC = 20;
  SSL3_RT_HANDSHAKE = 22;
  SSL3_RT_HEADER_LENGTH = 5;
  SSL3_RT_MAX_PLAIN_LENGTH = 16384;
  SSL3_RT_MAX_COMPRESSED_LENGTH = 1024+SSL3_RT_MAX_PLAIN_LENGTH;
  SSL3_RT_MAX_DATA_SIZE = 1024*1024;
  SSL3_RT_MAX_ENCRYPTED_LENGTH = 1024+SSL3_RT_MAX_COMPRESSED_LENGTH;
  SSL3_RT_MAX_EXTRA = 16384;
  SSL3_RT_MAX_PACKET_SIZE = SSL3_RT_MAX_ENCRYPTED_LENGTH+SSL3_RT_HEADER_LENGTH;
  SSL3_SESSION_ID_SIZE = 32;
  SSL3_SSL_SESSION_ID_LENGTH = 32;
  SSL3_ST_CR_CERT_A = $130 or SSL_ST_CONNECT;
  SSL3_ST_CR_CERT_B = $131 or SSL_ST_CONNECT;
  SSL3_ST_CR_CERT_REQ_A = $150 or SSL_ST_CONNECT;
  SSL3_ST_CR_CERT_REQ_B = $151 or SSL_ST_CONNECT;
  SSL3_ST_CR_CHANGE_A = $1C0 or SSL_ST_CONNECT;
  SSL3_ST_CR_CHANGE_B = $1C1 or SSL_ST_CONNECT;
  SSL3_ST_CR_FINISHED_A = $1D0 or SSL_ST_CONNECT;
  SSL3_ST_CR_FINISHED_B = $1D1 or SSL_ST_CONNECT;
  SSL3_ST_CR_KEY_EXCH_A = $140 or SSL_ST_CONNECT;
  SSL3_ST_CR_KEY_EXCH_B = $141 or SSL_ST_CONNECT;
  SSL3_ST_CR_SRVR_DONE_A = $160 or SSL_ST_CONNECT;
  SSL3_ST_CR_SRVR_DONE_B = $161 or SSL_ST_CONNECT;
  SSL3_ST_CR_SRVR_HELLO_A = $120 or SSL_ST_CONNECT;
  SSL3_ST_CR_SRVR_HELLO_B = $121 or SSL_ST_CONNECT;
  SSL3_ST_CW_CERT_A = $170 or SSL_ST_CONNECT;
  SSL3_ST_CW_CERT_B = $171 or SSL_ST_CONNECT;
  SSL3_ST_CW_CERT_C = $172 or SSL_ST_CONNECT;
  SSL3_ST_CW_CERT_D = $173 or SSL_ST_CONNECT;
  SSL3_ST_CW_CERT_VRFY_A = $190 or SSL_ST_CONNECT;
  SSL3_ST_CW_CERT_VRFY_B = $191 or SSL_ST_CONNECT;
  SSL3_ST_CW_CHANGE_A = $1A0 or SSL_ST_CONNECT;
  SSL3_ST_CW_CHANGE_B = $1A1 or SSL_ST_CONNECT;
  SSL3_ST_CW_CLNT_HELLO_A = $110 or SSL_ST_CONNECT;
  SSL3_ST_CW_CLNT_HELLO_B = $111 or SSL_ST_CONNECT;
  SSL3_ST_CW_FINISHED_A = $1B0 or SSL_ST_CONNECT;
  SSL3_ST_CW_FINISHED_B = $1B1 or SSL_ST_CONNECT;
  SSL3_ST_CW_FLUSH = $100 or SSL_ST_CONNECT;
  SSL3_ST_CW_KEY_EXCH_A = $180 or SSL_ST_CONNECT;
  SSL3_ST_CW_KEY_EXCH_B = $181 or SSL_ST_CONNECT;
  SSL3_ST_SR_CERT_A = $180 or SSL_ST_ACCEPT;
  SSL3_ST_SR_CERT_B = $181 or SSL_ST_ACCEPT;
  SSL3_ST_SR_CERT_VRFY_A = $1A0 or SSL_ST_ACCEPT;
  SSL3_ST_SR_CERT_VRFY_B = $1A1 or SSL_ST_ACCEPT;
  SSL3_ST_SR_CHANGE_A = $1B0 or SSL_ST_ACCEPT;
  SSL3_ST_SR_CHANGE_B = $1B1 or SSL_ST_ACCEPT;
  SSL3_ST_SR_CLNT_HELLO_A = $110 or SSL_ST_ACCEPT;
  SSL3_ST_SR_CLNT_HELLO_B = $111 or SSL_ST_ACCEPT;
  SSL3_ST_SR_CLNT_HELLO_C = $112 or SSL_ST_ACCEPT;
  SSL3_ST_SR_FINISHED_A = $1C0 or SSL_ST_ACCEPT;
  SSL3_ST_SR_FINISHED_B = $1C1 or SSL_ST_ACCEPT;
  SSL3_ST_SR_KEY_EXCH_A = $190 or SSL_ST_ACCEPT;
  SSL3_ST_SR_KEY_EXCH_B = $191 or SSL_ST_ACCEPT;
  SSL3_ST_SW_CERT_A = $140 or SSL_ST_ACCEPT;
  SSL3_ST_SW_CERT_B = $141 or SSL_ST_ACCEPT;
  SSL3_ST_SW_CERT_REQ_A = $160 or SSL_ST_ACCEPT;
  SSL3_ST_SW_CERT_REQ_B = $161 or SSL_ST_ACCEPT;
  SSL3_ST_SW_CHANGE_A = $1D0 or SSL_ST_ACCEPT;
  SSL3_ST_SW_CHANGE_B = $1D1 or SSL_ST_ACCEPT;
  SSL3_ST_SW_FINISHED_A = $1E0 or SSL_ST_ACCEPT;
  SSL3_ST_SW_FINISHED_B = $1E1 or SSL_ST_ACCEPT;
  SSL3_ST_SW_FLUSH = $100 or SSL_ST_ACCEPT;
  SSL3_ST_SW_HELLO_REQ_A = $120 or SSL_ST_ACCEPT;
  SSL3_ST_SW_HELLO_REQ_B = $121 or SSL_ST_ACCEPT;
  SSL3_ST_SW_HELLO_REQ_C = $122 or SSL_ST_ACCEPT;
  SSL3_ST_SW_KEY_EXCH_A = $150 or SSL_ST_ACCEPT;
  SSL3_ST_SW_KEY_EXCH_B = $151 or SSL_ST_ACCEPT;
  SSL3_ST_SW_SRVR_DONE_A = $170 or SSL_ST_ACCEPT;
  SSL3_ST_SW_SRVR_DONE_B = $171 or SSL_ST_ACCEPT;
  SSL3_ST_SW_SRVR_HELLO_A = $130 or SSL_ST_ACCEPT;
  SSL3_ST_SW_SRVR_HELLO_B = $131 or SSL_ST_ACCEPT;
  SSL3_TXT_ADH_DES_192_CBC_SHA = 'ADH-DES-CBC3-SHA';
  SSL3_TXT_ADH_DES_40_CBC_SHA = 'EXP-ADH-DES-CBC-SHA';
  SSL3_TXT_ADH_DES_64_CBC_SHA = 'ADH-DES-CBC-SHA';
  SSL3_TXT_ADH_RC4_128_MD5 = 'ADH-RC4-MD5';
  SSL3_TXT_ADH_RC4_40_MD5 = 'EXP-ADH-RC4-MD5';
  SSL3_TXT_DH_DSS_DES_192_CBC3_SHA = 'DH-DSS-DES-CBC3-SHA';
  SSL3_TXT_DH_DSS_DES_40_CBC_SHA = 'EXP-DH-DSS-DES-CBC-SHA';
  SSL3_TXT_DH_DSS_DES_64_CBC_SHA = 'DH-DSS-DES-CBC-SHA';
  SSL3_TXT_DH_RSA_DES_192_CBC3_SHA = 'DH-RSA-DES-CBC3-SHA';
  SSL3_TXT_DH_RSA_DES_40_CBC_SHA = 'EXP-DH-RSA-DES-CBC-SHA';
  SSL3_TXT_DH_RSA_DES_64_CBC_SHA = 'DH-RSA-DES-CBC-SHA';
  SSL3_TXT_EDH_DSS_DES_192_CBC3_SHA = 'EDH-DSS-DES-CBC3-SHA';
  SSL3_TXT_EDH_DSS_DES_40_CBC_SHA = 'EXP-EDH-DSS-DES-CBC-SHA';
  SSL3_TXT_EDH_DSS_DES_64_CBC_SHA = 'EDH-DSS-DES-CBC-SHA';
  SSL3_TXT_EDH_RSA_DES_192_CBC3_SHA = 'EDH-RSA-DES-CBC3-SHA';
  SSL3_TXT_EDH_RSA_DES_40_CBC_SHA = 'EXP-EDH-RSA-DES-CBC-SHA';
  SSL3_TXT_EDH_RSA_DES_64_CBC_SHA = 'EDH-RSA-DES-CBC-SHA';
  SSL3_TXT_FZA_DMS_FZA_SHA = 'FZA-FZA-CBC-SHA';
  SSL3_TXT_FZA_DMS_NULL_SHA = 'FZA-NULL-SHA';
  SSL3_TXT_FZA_DMS_RC4_SHA = 'FZA-RC4-SHA';
  SSL3_TXT_RSA_DES_192_CBC3_SHA = 'DES-CBC3-SHA';
  SSL3_TXT_RSA_DES_40_CBC_SHA = 'EXP-DES-CBC-SHA';
  SSL3_TXT_RSA_DES_64_CBC_SHA = 'DES-CBC-SHA';
  SSL3_TXT_RSA_IDEA_128_SHA = 'IDEA-CBC-SHA';
  SSL3_TXT_RSA_NULL_MD5 = 'NULL-MD5';
  SSL3_TXT_RSA_NULL_SHA = 'NULL-SHA';
  SSL3_TXT_RSA_RC2_40_MD5 = 'EXP-RC2-CBC-MD5';
  SSL3_TXT_RSA_RC4_128_MD5 = 'RC4-MD5';
  SSL3_TXT_RSA_RC4_128_SHA = 'RC4-SHA';
  SSL3_TXT_RSA_RC4_40_MD5 = 'EXP-RC4-MD5';
  SSL3_VERSION = $0300;
  SSL3_VERSION_MAJOR = $03;
  SSL3_VERSION_MINOR = $00;
  SSLEAY_BUILT_ON = 3;
  SSLEAY_CFLAGS = 2;
  SSLEAY_PLATFORM = 4;
  SSLEAY_VERSION = 0;
  SSLEAY_VERSION_NUMBER = OPENSSL_VERSION_NUMBER;
  TLS1_AD_ACCESS_DENIED = 49;
  SSL_AD_ACCESS_DENIED = TLS1_AD_ACCESS_DENIED;
  SSL_AD_BAD_CERTIFICATE = SSL3_AD_BAD_CERTIFICATE;
  SSL_AD_BAD_RECORD_MAC = SSL3_AD_BAD_RECORD_MAC;
  SSL_AD_CERTIFICATE_EXPIRED = SSL3_AD_CERTIFICATE_EXPIRED;
  SSL_AD_CERTIFICATE_REVOKED = SSL3_AD_CERTIFICATE_REVOKED;
  SSL_AD_CERTIFICATE_UNKNOWN = SSL3_AD_CERTIFICATE_UNKNOWN;
  SSL_AD_CLOSE_NOTIFY = SSL3_AD_CLOSE_NOTIFY;
  TLS1_AD_DECODE_ERROR = 50;
  SSL_AD_DECODE_ERROR = TLS1_AD_DECODE_ERROR;
  SSL_AD_DECOMPRESSION_FAILURE = SSL3_AD_DECOMPRESSION_FAILURE;
  TLS1_AD_DECRYPTION_FAILED = 21;
  SSL_AD_DECRYPTION_FAILED = TLS1_AD_DECRYPTION_FAILED;
  TLS1_AD_DECRYPT_ERROR = 51;
  SSL_AD_DECRYPT_ERROR = TLS1_AD_DECRYPT_ERROR;
  TLS1_AD_EXPORT_RESTRICION = 60;
  SSL_AD_EXPORT_RESTRICION = TLS1_AD_EXPORT_RESTRICION;
  SSL_AD_HANDSHAKE_FAILURE = SSL3_AD_HANDSHAKE_FAILURE;
  SSL_AD_ILLEGAL_PARAMETER = SSL3_AD_ILLEGAL_PARAMETER;
  TLS1_AD_INSUFFICIENT_SECURITY = 71;
  SSL_AD_INSUFFICIENT_SECURITY = TLS1_AD_INSUFFICIENT_SECURITY;
  TLS1_AD_INTERNAL_ERROR = 80;
  SSL_AD_INTERNAL_ERROR = TLS1_AD_INTERNAL_ERROR;
  SSL_AD_NO_CERTIFICATE = SSL3_AD_NO_CERTIFICATE;
  TLS1_AD_NO_RENEGOTIATION = 100;
  SSL_AD_NO_RENEGOTIATION = TLS1_AD_NO_RENEGOTIATION;
  TLS1_AD_PROTOCOL_VERSION = 70;
  SSL_AD_PROTOCOL_VERSION = TLS1_AD_PROTOCOL_VERSION;
  SSL_AD_REASON_OFFSET = 1000;
  TLS1_AD_RECORD_OVERFLOW = 22;
  SSL_AD_RECORD_OVERFLOW = TLS1_AD_RECORD_OVERFLOW;
  SSL_AD_UNEXPECTED_MESSAGE = SSL3_AD_UNEXPECTED_MESSAGE;
  TLS1_AD_UNKNOWN_CA = 48;
  SSL_AD_UNKNOWN_CA = TLS1_AD_UNKNOWN_CA;
  SSL_AD_UNSUPPORTED_CERTIFICATE = SSL3_AD_UNSUPPORTED_CERTIFICATE;
  TLS1_AD_USER_CANCLED = 90;
  SSL_AD_USER_CANCLED = TLS1_AD_USER_CANCLED;
  SSL_CB_EXIT = $02;
  SSL_CB_ACCEPT_EXIT = SSL_ST_ACCEPT or SSL_CB_EXIT;
  SSL_CB_LOOP = $01;
  SSL_CB_ACCEPT_LOOP = SSL_ST_ACCEPT or SSL_CB_LOOP;
  SSL_CB_ALERT = $4000;
  SSL_CB_CONNECT_EXIT = SSL_ST_CONNECT or SSL_CB_EXIT;
  SSL_CB_CONNECT_LOOP = SSL_ST_CONNECT or SSL_CB_LOOP;
  SSL_CB_HANDSHAKE_DONE = $20;
  SSL_CB_HANDSHAKE_START = $10;
  SSL_CB_READ = $04;
  SSL_CB_READ_ALERT = SSL_CB_ALERT or SSL_CB_READ;
  SSL_CB_WRITE = $08;
  SSL_CB_WRITE_ALERT = SSL_CB_ALERT or SSL_CB_WRITE;
  SSL_CTRL_CLEAR_NUM_RENEGOTIATIONS = 9;
  SSL_CTRL_EXTRA_CHAIN_CERT = 12;
  SSL_CTRL_GET_CLIENT_CERT_REQUEST = 7;
  SSL_CTRL_GET_FLAGS = 11;
  SSL_CTRL_GET_NUM_RENEGOTIATIONS = 8;
  SSL_CTRL_GET_READ_AHEAD = 40;
  SSL_CTRL_GET_SESSION_REUSED = 6;
  SSL_CTRL_GET_SESS_CACHE_MODE = 45;
  SSL_CTRL_GET_SESS_CACHE_SIZE = 43;
  SSL_CTRL_GET_TOTAL_RENEGOTIATIONS = 10;
  SSL_CTRL_MODE = 33;
  SSL_CTRL_NEED_TMP_RSA = 1;
  SSL_CTRL_OPTIONS = 32;
  SSL_CTRL_SESS_ACCEPT = 24;
  SSL_CTRL_SESS_ACCEPT_GOOD = 25;
  SSL_CTRL_SESS_ACCEPT_RENEGOTIATE = 26;
  SSL_CTRL_SESS_CACHE_FULL = 31;
  SSL_CTRL_SESS_CB_HIT = 28;
  SSL_CTRL_SESS_CONNECT = 21;
  SSL_CTRL_SESS_CONNECT_GOOD = 22;
  SSL_CTRL_SESS_CONNECT_RENEGOTIATE = 23;
  SSL_CTRL_SESS_HIT = 27;
  SSL_CTRL_SESS_MISSES = 29;
  SSL_CTRL_SESS_NUMBER = 20;
  SSL_CTRL_SESS_TIMEOUTS = 30;
  SSL_CTRL_SET_READ_AHEAD = 41;
  SSL_CTRL_SET_SESS_CACHE_MODE = 44;
  SSL_CTRL_SET_SESS_CACHE_SIZE = 42;
  SSL_CTRL_SET_TMP_DH = 3;
  SSL_CTRL_SET_TMP_DH_CB = 5;
  SSL_CTRL_SET_TMP_RSA = 2;
  SSL_CTRL_SET_TMP_RSA_CB = 4;
  SSL_DEFAULT_CIPHER_LIST = 'ALL:!ADH:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP';
  SSL_ERROR_NONE = 0;
  SSL_ERROR_SSL = 1;
  SSL_ERROR_SYSCALL = 5;
  SSL_ERROR_WANT_CONNECT = 7;
  SSL_ERROR_WANT_READ = 2;
  SSL_ERROR_WANT_WRITE = 3;
  SSL_ERROR_WANT_X509_LOOKUP = 4;
  SSL_ERROR_ZERO_RETURN = 6;
  X509_FILETYPE_ASN1 = 2;
  SSL_FILETYPE_ASN1 = X509_FILETYPE_ASN1;
  X509_FILETYPE_PEM = 1;
  SSL_FILETYPE_PEM = X509_FILETYPE_PEM;
  SSL_F_CLIENT_CERTIFICATE = 100;
  SSL_F_CLIENT_HELLO = 101;
  SSL_F_CLIENT_MASTER_KEY = 102;
  SSL_F_D2I_SSL_SESSION = 103;
  SSL_F_DO_SSL3_WRITE = 104;
  SSL_F_GET_CLIENT_FINISHED = 105;
  SSL_F_GET_CLIENT_HELLO = 106;
  SSL_F_GET_CLIENT_MASTER_KEY = 107;
  SSL_F_GET_SERVER_FINISHED = 108;
  SSL_F_GET_SERVER_HELLO = 109;
  SSL_F_GET_SERVER_VERIFY = 110;
  SSL_F_I2D_SSL_SESSION = 111;
  SSL_F_READ_N = 112;
  SSL_F_REQUEST_CERTIFICATE = 113;
  SSL_F_SERVER_HELLO = 114;
  SSL_F_SSL23_ACCEPT = 115;
  SSL_F_SSL23_CLIENT_HELLO = 116;
  SSL_F_SSL23_CONNECT = 117;
  SSL_F_SSL23_GET_CLIENT_HELLO = 118;
  SSL_F_SSL23_GET_SERVER_HELLO = 119;
  SSL_F_SSL23_READ = 120;
  SSL_F_SSL23_WRITE = 121;
  SSL_F_SSL2_ACCEPT = 122;
  SSL_F_SSL2_CONNECT = 123;
  SSL_F_SSL2_ENC_INIT = 124;
  SSL_F_SSL2_READ = 125;
  SSL_F_SSL2_SET_CERTIFICATE = 126;
  SSL_F_SSL2_WRITE = 127;
  SSL_F_SSL3_ACCEPT = 128;
  SSL_F_SSL3_CHANGE_CIPHER_STATE = 129;
  SSL_F_SSL3_CHECK_CERT_AND_ALGORITHM = 130;
  SSL_F_SSL3_CLIENT_HELLO = 131;
  SSL_F_SSL3_CONNECT = 132;
  SSL_F_SSL3_CTRL = 213;
  SSL_F_SSL3_CTX_CTRL = 133;
  SSL_F_SSL3_ENC = 134;
  SSL_F_SSL3_GET_CERTIFICATE_REQUEST = 135;
  SSL_F_SSL3_GET_CERT_VERIFY = 136;
  SSL_F_SSL3_GET_CLIENT_CERTIFICATE = 137;
  SSL_F_SSL3_GET_CLIENT_HELLO = 138;
  SSL_F_SSL3_GET_CLIENT_KEY_EXCHANGE = 139;
  SSL_F_SSL3_GET_FINISHED = 140;
  SSL_F_SSL3_GET_KEY_EXCHANGE = 141;
  SSL_F_SSL3_GET_MESSAGE = 142;
  SSL_F_SSL3_GET_RECORD = 143;
  SSL_F_SSL3_GET_SERVER_CERTIFICATE = 144;
  SSL_F_SSL3_GET_SERVER_DONE = 145;
  SSL_F_SSL3_GET_SERVER_HELLO = 146;
  SSL_F_SSL3_OUTPUT_CERT_CHAIN = 147;
  SSL_F_SSL3_READ_BYTES = 148;
  SSL_F_SSL3_READ_N = 149;
  SSL_F_SSL3_SEND_CERTIFICATE_REQUEST = 150;
  SSL_F_SSL3_SEND_CLIENT_CERTIFICATE = 151;
  SSL_F_SSL3_SEND_CLIENT_KEY_EXCHANGE = 152;
  SSL_F_SSL3_SEND_CLIENT_VERIFY = 153;
  SSL_F_SSL3_SEND_SERVER_CERTIFICATE = 154;
  SSL_F_SSL3_SEND_SERVER_KEY_EXCHANGE = 155;
  SSL_F_SSL3_SETUP_BUFFERS = 156;
  SSL_F_SSL3_SETUP_KEY_BLOCK = 157;
  SSL_F_SSL3_WRITE_BYTES = 158;
  SSL_F_SSL3_WRITE_PENDING = 159;
  SSL_F_SSL_ADD_DIR_CERT_SUBJECTS_TO_STACK = 215;
  SSL_F_SSL_ADD_FILE_CERT_SUBJECTS_TO_STACK = 216;
  SSL_F_SSL_BAD_METHOD = 160;
  SSL_F_SSL_BYTES_TO_CIPHER_LIST = 161;
  SSL_F_SSL_CERT_DUP = 221;
  SSL_F_SSL_CERT_INST = 222;
  SSL_F_SSL_CERT_INSTANTIATE = 214;
  SSL_F_SSL_CERT_NEW = 162;
  SSL_F_SSL_CHECK_PRIVATE_KEY = 163;
  SSL_F_SSL_CLEAR = 164;
  SSL_F_SSL_COMP_ADD_COMPRESSION_METHOD = 165;
  SSL_F_SSL_CREATE_CIPHER_LIST = 166;
  SSL_F_SSL_CTX_CHECK_PRIVATE_KEY = 168;
  SSL_F_SSL_CTX_NEW = 169;
  SSL_F_SSL_CTX_SET_SESSION_ID_CONTEXT = 219;
  SSL_F_SSL_CTX_SET_SSL_VERSION = 170;
  SSL_F_SSL_CTX_USE_CERTIFICATE = 171;
  SSL_F_SSL_CTX_USE_CERTIFICATE_ASN1 = 172;
  SSL_F_SSL_CTX_USE_CERTIFICATE_CHAIN_FILE = 220;
  SSL_F_SSL_CTX_USE_CERTIFICATE_FILE = 173;
  SSL_F_SSL_CTX_USE_PRIVATEKEY = 174;
  SSL_F_SSL_CTX_USE_PRIVATEKEY_ASN1 = 175;
  SSL_F_SSL_CTX_USE_PRIVATEKEY_FILE = 176;
  SSL_F_SSL_CTX_USE_RSAPRIVATEKEY = 177;
  SSL_F_SSL_CTX_USE_RSAPRIVATEKEY_ASN1 = 178;
  SSL_F_SSL_CTX_USE_RSAPRIVATEKEY_FILE = 179;
  SSL_F_SSL_DO_HANDSHAKE = 180;
  SSL_F_SSL_GET_NEW_SESSION = 181;
  SSL_F_SSL_GET_PREV_SESSION = 217;
  SSL_F_SSL_GET_SERVER_SEND_CERT = 182;
  SSL_F_SSL_GET_SIGN_PKEY = 183;
  SSL_F_SSL_INIT_WBIO_BUFFER = 184;
  SSL_F_SSL_LOAD_CLIENT_CA_FILE = 185;
  SSL_F_SSL_NEW = 186;
  SSL_F_SSL_READ = 223;
  SSL_F_SSL_RSA_PRIVATE_DECRYPT = 187;
  SSL_F_SSL_RSA_PUBLIC_ENCRYPT = 188;
  SSL_F_SSL_SESSION_NEW = 189;
  SSL_F_SSL_SESSION_PRINT_FP = 190;
  SSL_F_SSL_SESS_CERT_NEW = 225;
  SSL_F_SSL_SET_CERT = 191;
  SSL_F_SSL_SET_FD = 192;
  SSL_F_SSL_SET_PKEY = 193;
  SSL_F_SSL_SET_RFD = 194;
  SSL_F_SSL_SET_SESSION = 195;
  SSL_F_SSL_SET_SESSION_ID_CONTEXT = 218;
  SSL_F_SSL_SET_WFD = 196;
  SSL_F_SSL_SHUTDOWN = 224;
  SSL_F_SSL_UNDEFINED_FUNCTION = 197;
  SSL_F_SSL_USE_CERTIFICATE = 198;
  SSL_F_SSL_USE_CERTIFICATE_ASN1 = 199;
  SSL_F_SSL_USE_CERTIFICATE_FILE = 200;
  SSL_F_SSL_USE_PRIVATEKEY = 201;
  SSL_F_SSL_USE_PRIVATEKEY_ASN1 = 202;
  SSL_F_SSL_USE_PRIVATEKEY_FILE = 203;
  SSL_F_SSL_USE_RSAPRIVATEKEY = 204;
  SSL_F_SSL_USE_RSAPRIVATEKEY_ASN1 = 205;
  SSL_F_SSL_USE_RSAPRIVATEKEY_FILE = 206;
  SSL_F_SSL_VERIFY_CERT_CHAIN = 207;
  SSL_F_SSL_WRITE = 208;
  SSL_F_TLS1_CHANGE_CIPHER_STATE = 209;
  SSL_F_TLS1_ENC = 210;
  SSL_F_TLS1_SETUP_KEY_BLOCK = 211;
  SSL_F_WRITE_PENDING = 212;
  SSL_MAX_KEY_ARG_LENGTH = 8;
  SSL_MAX_MASTER_KEY_LENGTH = 48;
  SSL_MAX_SID_CTX_LENGTH = 32;
  SSL_MAX_SSL_SESSION_ID_LENGTH = 32;
  SSL_MODE_ACCEPT_MOVING_WRITE_BUFFER = $00000002;
  SSL_MODE_ENABLE_PARTIAL_WRITE = $00000001;
  SSL_NOTHING = 1;
  SSL_OP_ALL = $000FFFFF;
  SSL_OP_EPHEMERAL_RSA = $00200000;
  SSL_OP_MICROSOFT_BIG_SSLV3_BUFFER = $00000020;
  SSL_OP_MICROSOFT_SESS_ID_BUG = $00000001;
  SSL_OP_MSIE_SSLV2_RSA_PADDING = $00000040;
  SSL_OP_NETSCAPE_CA_DN_BUG = $20000000;
  SSL_OP_NETSCAPE_CHALLENGE_BUG = $00000002;
  SSL_OP_NETSCAPE_DEMO_CIPHER_CHANGE_BUG = $80000000;
  SSL_OP_NETSCAPE_REUSE_CIPHER_CHANGE_BUG = $00000008;
  SSL_OP_NON_EXPORT_FIRST = $40000000;
  SSL_OP_NO_SSLv2 = $01000000;
  SSL_OP_NO_SSLv3 = $02000000;
  SSL_OP_NO_TLSv1 = $04000000;
  SSL_OP_PKCS1_CHECK_1 = $08000000;
  SSL_OP_PKCS1_CHECK_2 = $10000000;
  SSL_OP_SINGLE_DH_USE = $00100000;
  SSL_OP_SSLEAY_080_CLIENT_DH_BUG = $00000080;
  SSL_OP_SSLREF2_REUSE_CERT_TYPE_BUG = $00000010;
  SSL_OP_TLS_BLOCK_PADDING_BUG = $00000200;
  SSL_OP_TLS_D5_BUG = $00000100;
  SSL_OP_TLS_ROLLBACK_BUG = $00000400;
  SSL_READING = 3;
  SSL_RECEIVED_SHUTDOWN = 2;
  SSL_R_APP_DATA_IN_HANDSHAKE = 100;
  SSL_R_ATTEMPT_TO_REUSE_SESSION_IN_DIFFERENT_CONTEXT = 272;
  SSL_R_BAD_ALERT_RECORD = 101;
  SSL_R_BAD_AUTHENTICATION_TYPE = 102;
  SSL_R_BAD_CHANGE_CIPHER_SPEC = 103;
  SSL_R_BAD_CHECKSUM = 104;
  SSL_R_BAD_CLIENT_REQUEST = 105;
  SSL_R_BAD_DATA_RETURNED_BY_CALLBACK = 106;
  SSL_R_BAD_DECOMPRESSION = 107;
  SSL_R_BAD_DH_G_LENGTH = 108;
  SSL_R_BAD_DH_PUB_KEY_LENGTH = 109;
  SSL_R_BAD_DH_P_LENGTH = 110;
  SSL_R_BAD_DIGEST_LENGTH = 111;
  SSL_R_BAD_DSA_SIGNATURE = 112;
  SSL_R_BAD_LENGTH = 271;
  SSL_R_BAD_MAC_DECODE = 113;
  SSL_R_BAD_MESSAGE_TYPE = 114;
  SSL_R_BAD_PACKET_LENGTH = 115;
  SSL_R_BAD_PROTOCOL_VERSION_NUMBER = 116;
  SSL_R_BAD_RESPONSE_ARGUMENT = 117;
  SSL_R_BAD_RSA_DECRYPT = 118;
  SSL_R_BAD_RSA_ENCRYPT = 119;
  SSL_R_BAD_RSA_E_LENGTH = 120;
  SSL_R_BAD_RSA_MODULUS_LENGTH = 121;
  SSL_R_BAD_RSA_SIGNATURE = 122;
  SSL_R_BAD_SIGNATURE = 123;
  SSL_R_BAD_SSL_FILETYPE = 124;
  SSL_R_BAD_SSL_SESSION_ID_LENGTH = 125;
  SSL_R_BAD_STATE = 126;
  SSL_R_BAD_WRITE_RETRY = 127;
  SSL_R_BIO_NOT_SET = 128;
  SSL_R_BLOCK_CIPHER_PAD_IS_WRONG = 129;
  SSL_R_BN_LIB = 130;
  SSL_R_CA_DN_LENGTH_MISMATCH = 131;
  SSL_R_CA_DN_TOO_LONG = 132;
  SSL_R_CCS_RECEIVED_EARLY = 133;
  SSL_R_CERTIFICATE_VERIFY_FAILED = 134;
  SSL_R_CERT_LENGTH_MISMATCH = 135;
  SSL_R_CHALLENGE_IS_DIFFERENT = 136;
  SSL_R_CIPHER_CODE_WRONG_LENGTH = 137;
  SSL_R_CIPHER_OR_HASH_UNAVAILABLE = 138;
  SSL_R_CIPHER_TABLE_SRC_ERROR = 139;
  SSL_R_COMPRESSED_LENGTH_TOO_LONG = 140;
  SSL_R_COMPRESSION_FAILURE = 141;
  SSL_R_COMPRESSION_LIBRARY_ERROR = 142;
  SSL_R_CONNECTION_ID_IS_DIFFERENT = 143;
  SSL_R_CONNECTION_TYPE_NOT_SET = 144;
  SSL_R_DATA_BETWEEN_CCS_AND_FINISHED = 145;
  SSL_R_DATA_LENGTH_TOO_LONG = 146;
  SSL_R_DECRYPTION_FAILED = 147;
  SSL_R_DH_PUBLIC_VALUE_LENGTH_IS_WRONG = 148;
  SSL_R_DIGEST_CHECK_FAILED = 149;
  SSL_R_ENCRYPTED_LENGTH_TOO_LONG = 150;
  SSL_R_ERROR_IN_RECEIVED_CIPHER_LIST = 151;
  SSL_R_EXCESSIVE_MESSAGE_SIZE = 152;
  SSL_R_EXTRA_DATA_IN_MESSAGE = 153;
  SSL_R_GOT_A_FIN_BEFORE_A_CCS = 154;
  SSL_R_HTTPS_PROXY_REQUEST = 155;
  SSL_R_HTTP_REQUEST = 156;
  SSL_R_INTERNAL_ERROR = 157;
  SSL_R_INVALID_CHALLENGE_LENGTH = 158;
  SSL_R_LENGTH_MISMATCH = 159;
  SSL_R_LENGTH_TOO_SHORT = 160;
  SSL_R_LIBRARY_BUG = 274;
  SSL_R_LIBRARY_HAS_NO_CIPHERS = 161;
  SSL_R_MISSING_DH_DSA_CERT = 162;
  SSL_R_MISSING_DH_KEY = 163;
  SSL_R_MISSING_DH_RSA_CERT = 164;
  SSL_R_MISSING_DSA_SIGNING_CERT = 165;
  SSL_R_MISSING_EXPORT_TMP_DH_KEY = 166;
  SSL_R_MISSING_EXPORT_TMP_RSA_KEY = 167;
  SSL_R_MISSING_RSA_CERTIFICATE = 168;
  SSL_R_MISSING_RSA_ENCRYPTING_CERT = 169;
  SSL_R_MISSING_RSA_SIGNING_CERT = 170;
  SSL_R_MISSING_TMP_DH_KEY = 171;
  SSL_R_MISSING_TMP_RSA_KEY = 172;
  SSL_R_MISSING_TMP_RSA_PKEY = 173;
  SSL_R_MISSING_VERIFY_MESSAGE = 174;
  SSL_R_NON_SSLV2_INITIAL_PACKET = 175;
  SSL_R_NO_CERTIFICATES_RETURNED = 176;
  SSL_R_NO_CERTIFICATE_ASSIGNED = 177;
  SSL_R_NO_CERTIFICATE_RETURNED = 178;
  SSL_R_NO_CERTIFICATE_SET = 179;
  SSL_R_NO_CERTIFICATE_SPECIFIED = 180;
  SSL_R_NO_CIPHERS_AVAILABLE = 181;
  SSL_R_NO_CIPHERS_PASSED = 182;
  SSL_R_NO_CIPHERS_SPECIFIED = 183;
  SSL_R_NO_CIPHER_LIST = 184;
  SSL_R_NO_CIPHER_MATCH = 185;
  SSL_R_NO_CLIENT_CERT_RECEIVED = 186;
  SSL_R_NO_COMPRESSION_SPECIFIED = 187;
  SSL_R_NO_METHOD_SPECIFIED = 188;
  SSL_R_NO_PRIVATEKEY = 189;
  SSL_R_NO_PRIVATE_KEY_ASSIGNED = 190;
  SSL_R_NO_PROTOCOLS_AVAILABLE = 191;
  SSL_R_NO_PUBLICKEY = 192;
  SSL_R_NO_SHARED_CIPHER = 193;
  SSL_R_NO_VERIFY_CALLBACK = 194;
  SSL_R_NULL_SSL_CTX = 195;
  SSL_R_NULL_SSL_METHOD_PASSED = 196;
  SSL_R_OLD_SESSION_CIPHER_NOT_RETURNED = 197;
  SSL_R_PACKET_LENGTH_TOO_LONG = 198;
  SSL_R_PATH_TOO_LONG = 270;
  SSL_R_PEER_DID_NOT_RETURN_A_CERTIFICATE = 199;
  SSL_R_PEER_ERROR = 200;
  SSL_R_PEER_ERROR_CERTIFICATE = 201;
  SSL_R_PEER_ERROR_NO_CERTIFICATE = 202;
  SSL_R_PEER_ERROR_NO_CIPHER = 203;
  SSL_R_PEER_ERROR_UNSUPPORTED_CERTIFICATE_TYPE = 204;
  SSL_R_PRE_MAC_LENGTH_TOO_LONG = 205;
  SSL_R_PROBLEMS_MAPPING_CIPHER_FUNCTIONS = 206;
  SSL_R_PROTOCOL_IS_SHUTDOWN = 207;
  SSL_R_PUBLIC_KEY_ENCRYPT_ERROR = 208;
  SSL_R_PUBLIC_KEY_IS_NOT_RSA = 209;
  SSL_R_PUBLIC_KEY_NOT_RSA = 210;
  SSL_R_READ_BIO_NOT_SET = 211;
  SSL_R_READ_WRONG_PACKET_TYPE = 212;
  SSL_R_RECORD_LENGTH_MISMATCH = 213;
  SSL_R_RECORD_TOO_LARGE = 214;
  SSL_R_REQUIRED_CIPHER_MISSING = 215;
  SSL_R_REUSE_CERT_LENGTH_NOT_ZERO = 216;
  SSL_R_REUSE_CERT_TYPE_NOT_ZERO = 217;
  SSL_R_REUSE_CIPHER_LIST_NOT_ZERO = 218;
  SSL_R_SESSION_ID_CONTEXT_UNINITIALIZED = 277;
  SSL_R_SHORT_READ = 219;
  SSL_R_SIGNATURE_FOR_NON_SIGNING_CERTIFICATE = 220;
  SSL_R_SSL23_DOING_SESSION_ID_REUSE = 221;
  SSL_R_SSL3_SESSION_ID_TOO_SHORT = 222;
  SSL_R_SSLV3_ALERT_BAD_CERTIFICATE = 1042;
  SSL_R_SSLV3_ALERT_BAD_RECORD_MAC = 1020;
  SSL_R_SSLV3_ALERT_CERTIFICATE_EXPIRED = 1045;
  SSL_R_SSLV3_ALERT_CERTIFICATE_REVOKED = 1044;
  SSL_R_SSLV3_ALERT_CERTIFICATE_UNKNOWN = 1046;
  SSL_R_SSLV3_ALERT_DECOMPRESSION_FAILURE = 1030;
  SSL_R_SSLV3_ALERT_HANDSHAKE_FAILURE = 1040;
  SSL_R_SSLV3_ALERT_ILLEGAL_PARAMETER = 1047;
  SSL_R_SSLV3_ALERT_NO_CERTIFICATE = 1041;
  SSL_R_SSLV3_ALERT_PEER_ERROR_CERTIFICATE = 223;
  SSL_R_SSLV3_ALERT_PEER_ERROR_NO_CERTIFICATE = 224;
  SSL_R_SSLV3_ALERT_PEER_ERROR_NO_CIPHER = 225;
  SSL_R_SSLV3_ALERT_PEER_ERROR_UNSUPPORTED_CERTIFICATE_TYPE = 226;
  SSL_R_SSLV3_ALERT_UNEXPECTED_MESSAGE = 1010;
  SSL_R_SSLV3_ALERT_UNKNOWN_REMOTE_ERROR_TYPE = 227;
  SSL_R_SSLV3_ALERT_UNSUPPORTED_CERTIFICATE = 1043;
  SSL_R_SSL_CTX_HAS_NO_DEFAULT_SSL_VERSION = 228;
  SSL_R_SSL_HANDSHAKE_FAILURE = 229;
  SSL_R_SSL_LIBRARY_HAS_NO_CIPHERS = 230;
  SSL_R_SSL_SESSION_ID_CONTEXT_TOO_LONG = 273;
  SSL_R_SSL_SESSION_ID_IS_DIFFERENT = 231;
  SSL_R_TLSV1_ALERT_ACCESS_DENIED = 1049;
  SSL_R_TLSV1_ALERT_DECODE_ERROR = 1050;
  SSL_R_TLSV1_ALERT_DECRYPTION_FAILED = 1021;
  SSL_R_TLSV1_ALERT_DECRYPT_ERROR = 1051;
  SSL_R_TLSV1_ALERT_EXPORT_RESTRICION = 1060;
  SSL_R_TLSV1_ALERT_INSUFFICIENT_SECURITY = 1071;
  SSL_R_TLSV1_ALERT_INTERNAL_ERROR = 1080;
  SSL_R_TLSV1_ALERT_NO_RENEGOTIATION = 1100;
  SSL_R_TLSV1_ALERT_PROTOCOL_VERSION = 1070;
  SSL_R_TLSV1_ALERT_RECORD_OVERFLOW = 1022;
  SSL_R_TLSV1_ALERT_UNKNOWN_CA = 1048;
  SSL_R_TLSV1_ALERT_USER_CANCLED = 1090;
  SSL_R_TLS_CLIENT_CERT_REQ_WITH_ANON_CIPHER = 232;
  SSL_R_TLS_PEER_DID_NOT_RESPOND_WITH_CERTIFICATE_LIST = 233;
  SSL_R_TLS_RSA_ENCRYPTED_VALUE_LENGTH_IS_WRONG = 234;
  SSL_R_TRIED_TO_USE_UNSUPPORTED_CIPHER = 235;
  SSL_R_UNABLE_TO_DECODE_DH_CERTS = 236;
  SSL_R_UNABLE_TO_EXTRACT_PUBLIC_KEY = 237;
  SSL_R_UNABLE_TO_FIND_DH_PARAMETERS = 238;
  SSL_R_UNABLE_TO_FIND_PUBLIC_KEY_PARAMETERS = 239;
  SSL_R_UNABLE_TO_FIND_SSL_METHOD = 240;
  SSL_R_UNABLE_TO_LOAD_SSL2_MD5_ROUTINES = 241;
  SSL_R_UNABLE_TO_LOAD_SSL3_MD5_ROUTINES = 242;
  SSL_R_UNABLE_TO_LOAD_SSL3_SHA1_ROUTINES = 243;
  SSL_R_UNEXPECTED_MESSAGE = 244;
  SSL_R_UNEXPECTED_RECORD = 245;
  SSL_R_UNINITIALIZED = 276;
  SSL_R_UNKNOWN_ALERT_TYPE = 246;
  SSL_R_UNKNOWN_CERTIFICATE_TYPE = 247;
  SSL_R_UNKNOWN_CIPHER_RETURNED = 248;
  SSL_R_UNKNOWN_CIPHER_TYPE = 249;
  SSL_R_UNKNOWN_KEY_EXCHANGE_TYPE = 250;
  SSL_R_UNKNOWN_PKEY_TYPE = 251;
  SSL_R_UNKNOWN_PROTOCOL = 252;
  SSL_R_UNKNOWN_REMOTE_ERROR_TYPE = 253;
  SSL_R_UNKNOWN_SSL_VERSION = 254;
  SSL_R_UNKNOWN_STATE = 255;
  SSL_R_UNSUPPORTED_CIPHER = 256;
  SSL_R_UNSUPPORTED_COMPRESSION_ALGORITHM = 257;
  SSL_R_UNSUPPORTED_PROTOCOL = 258;
  SSL_R_UNSUPPORTED_SSL_VERSION = 259;
  SSL_R_WRITE_BIO_NOT_SET = 260;
  SSL_R_WRONG_CIPHER_RETURNED = 261;
  SSL_R_WRONG_MESSAGE_TYPE = 262;
  SSL_R_WRONG_NUMBER_OF_KEY_BITS = 263;
  SSL_R_WRONG_SIGNATURE_LENGTH = 264;
  SSL_R_WRONG_SIGNATURE_SIZE = 265;
  SSL_R_WRONG_SSL_VERSION = 266;
  SSL_R_WRONG_VERSION_NUMBER = 267;
  SSL_R_X509_LIB = 268;
  SSL_R_X509_VERIFICATION_SETUP_PROBLEMS = 269;
  SSL_SENT_SHUTDOWN = 1;
  SSL_SESSION_ASN1_VERSION = $0001;
  SSL_SESSION_CACHE_MAX_SIZE_DEFAULT = 1024*20;
  SSL_SESS_CACHE_CLIENT = $0001;
  SSL_SESS_CACHE_SERVER = $0002;
  SSL_SESS_CACHE_BOTH = SSL_SESS_CACHE_CLIENT or SSL_SESS_CACHE_SERVER;
  SSL_SESS_CACHE_NO_AUTO_CLEAR = $0080;
  SSL_SESS_CACHE_NO_INTERNAL_LOOKUP = $0100;
  SSL_SESS_CACHE_OFF = $0000;
  SSL_ST_BEFORE = $4000;
  SSL_ST_INIT = SSL_ST_CONNECT or SSL_ST_ACCEPT;
  SSL_ST_MASK = $0FFF;
  SSL_ST_OK = $03;
  SSL_ST_READ_BODY = $F1;
  SSL_ST_READ_DONE = $F2;
  SSL_ST_READ_HEADER = $F0;
  SSL_ST_RENEGOTIATE = $04 or SSL_ST_INIT;
  SSL_TXT_3DES = '3DES';
  SSL_TXT_ADH_C = 'ADH';
  SSL_TXT_ALL = 'ALL';
  SSL_TXT_DES = 'DES';
  SSL_TXT_DES_192_EDE3_CBC_WITH_MD5 = SSL2_TXT_DES_192_EDE3_CBC_WITH_MD5;
  SSL_TXT_DES_192_EDE3_CBC_WITH_SHA = SSL2_TXT_DES_192_EDE3_CBC_WITH_SHA;
  SSL_TXT_DES_64_CBC_WITH_MD5 = SSL2_TXT_DES_64_CBC_WITH_MD5;
  SSL_TXT_DES_64_CBC_WITH_SHA = SSL2_TXT_DES_64_CBC_WITH_SHA;
  SSL_TXT_DH = 'DH';
  SSL_TXT_DSS = 'DSS';
  SSL_TXT_EDH = 'EDH';
  SSL_TXT_EXP40 = 'EXP';
  SSL_TXT_EXP56 = 'EXPORT56';
  SSL_TXT_EXPORT = 'EXPORT';
  SSL_TXT_FZA = 'FZA';
  SSL_TXT_HIGH = 'HIGH';
  SSL_TXT_IDEA = 'IDEA';
  SSL_TXT_IDEA_128_CBC_WITH_MD5 = SSL2_TXT_IDEA_128_CBC_WITH_MD5;
  SSL_TXT_LOW = 'LOW';
  SSL_TXT_MD5 = 'MD5';
  SSL_TXT_MEDIUM = 'MEDIUM';
  SSL_TXT_NULL = 'NULL';
  SSL_TXT_NULL_WITH_MD5 = SSL2_TXT_NULL_WITH_MD5;
  SSL_TXT_RC2 = 'RC2';
  SSL_TXT_RC2_128_CBC_EXPORT40_WITH_MD5 = SSL2_TXT_RC2_128_CBC_EXPORT40_WITH_MD5;
  SSL_TXT_RC2_128_CBC_WITH_MD5 = SSL2_TXT_RC2_128_CBC_WITH_MD5;
  SSL_TXT_RC4 = 'RC4';
  SSL_TXT_RC4_128_EXPORT40_WITH_MD5 = SSL2_TXT_RC4_128_EXPORT40_WITH_MD5;
  SSL_TXT_RC4_128_WITH_MD5 = SSL2_TXT_RC4_128_WITH_MD5;
  SSL_TXT_RSA = 'RSA';
  SSL_TXT_SHA = 'SHA';
  SSL_TXT_SHA1 = 'SHA1';
  SSL_TXT_SSLV2 = 'SSLv2';
  SSL_TXT_SSLV3 = 'SSLv3';
  SSL_TXT_TLSV1 = 'TLSv1';
  SSL_TXT_aDH_S = 'aDH';
  SSL_TXT_aDSS = 'aDSS';
  SSL_TXT_aFZA = 'aFZA';
  SSL_TXT_aNULL = 'aNULL';
  SSL_TXT_aRSA = 'aRSA';
  SSL_TXT_eFZA = 'eFZA';
  SSL_TXT_eNULL = 'eNULL';
  SSL_TXT_kDHd = 'kDHd';
  SSL_TXT_kDHr = 'kDHr';
  SSL_TXT_kEDH = 'kEDH';
  SSL_TXT_kFZA = 'kFZA';
  SSL_TXT_kRSA = 'kRSA';
  SSL_VERIFY_CLIENT_ONCE = $04;
  SSL_VERIFY_FAIL_IF_NO_PEER_CERT = $02;
  SSL_VERIFY_NONE = $00;
  SSL_VERIFY_PEER = $01;
  SSL_WRITING = 2;
  SSL_X509_LOOKUP = 4;
  TLS1_ALLOW_EXPERIMENTAL_CIPHERSUITES = 0;
  TLS1_CK_DHE_DSS_EXPORT1024_WITH_DES_CBC_SHA = $03000063;
  TLS1_CK_DHE_DSS_EXPORT1024_WITH_RC4_56_SHA = $03000065;
  TLS1_CK_DHE_DSS_WITH_RC4_128_SHA = $03000066;
  TLS1_CK_RSA_EXPORT1024_WITH_DES_CBC_SHA = $03000062;
  TLS1_CK_RSA_EXPORT1024_WITH_RC2_CBC_56_MD5 = $03000061;
  TLS1_CK_RSA_EXPORT1024_WITH_RC4_56_MD5 = $03000060;
  TLS1_CK_RSA_EXPORT1024_WITH_RC4_56_SHA = $03000064;
  TLS1_FINISH_MAC_LENGTH = 12;
  TLS1_FLAGS_TLS_PADDING_BUG = $0008;
  TLS1_TXT_DHE_DSS_EXPORT1024_WITH_DES_CBC_SHA = 'EXP1024-DHE-DSS-DES-CBC-SHA';
  TLS1_TXT_DHE_DSS_EXPORT1024_WITH_RC4_56_SHA = 'EXP1024-DHE-DSS-RC4-SHA';
  TLS1_TXT_DHE_DSS_WITH_RC4_128_SHA = 'DHE-DSS-RC4-SHA';
  TLS1_TXT_RSA_EXPORT1024_WITH_DES_CBC_SHA = 'EXP1024-DES-CBC-SHA';
  TLS1_TXT_RSA_EXPORT1024_WITH_RC2_CBC_56_MD5 = 'EXP1024-RC2-CBC-MD5';
  TLS1_TXT_RSA_EXPORT1024_WITH_RC4_56_MD5 = 'EXP1024-RC4-MD5';
  TLS1_TXT_RSA_EXPORT1024_WITH_RC4_56_SHA = 'EXP1024-RC4-SHA';
  TLS1_VERSION = $0301;
  TLS1_VERSION_MAJOR = $03;
  TLS1_VERSION_MINOR = $01;
  TLS_CT_DSS_FIXED_DH = 4;
  TLS_CT_DSS_SIGN = 2;
  TLS_CT_NUMBER = 4;
  TLS_CT_RSA_FIXED_DH = 3;
  TLS_CT_RSA_SIGN = 1;
  TLS_MD_CLIENT_FINISH_CONST = 'client finished';
  TLS_MD_CLIENT_FINISH_CONST_SIZE = 15;
  TLS_MD_CLIENT_WRITE_KEY_CONST = 'client write key';
  TLS_MD_CLIENT_WRITE_KEY_CONST_SIZE = 16;
  TLS_MD_IV_BLOCK_CONST = 'IV block';
  TLS_MD_IV_BLOCK_CONST_SIZE = 8;
  TLS_MD_KEY_EXPANSION_CONST = 'key expansion';
  TLS_MD_KEY_EXPANSION_CONST_SIZE = 13;
  TLS_MD_MASTER_SECRET_CONST = 'master secret';
  TLS_MD_MASTER_SECRET_CONST_SIZE = 13;
  TLS_MD_MAX_CONST_SIZE = 20;
  TLS_MD_SERVER_FINISH_CONST = 'server finished';
  TLS_MD_SERVER_FINISH_CONST_SIZE = 15;
  TLS_MD_SERVER_WRITE_KEY_CONST = 'server write key';
  TLS_MD_SERVER_WRITE_KEY_CONST_SIZE = 16;
  TMP_MAX = 26;
  V_ASN1_APPLICATION = $40;
  V_ASN1_APP_CHOOSE = -2;
  V_ASN1_BIT_STRING = 3;
  V_ASN1_BMPSTRING = 30;
  V_ASN1_BOOLEAN = 1;
  V_ASN1_CONSTRUCTED = $20;
  V_ASN1_CONTEXT_SPECIFIC = $80;
  V_ASN1_ENUMERATED = 10;
  V_ASN1_EOC = 0;
  V_ASN1_EXTERNAL = 8;
  V_ASN1_GENERALIZEDTIME = 24;
  V_ASN1_GENERALSTRING = 27;
  V_ASN1_GRAPHICSTRING = 25;
  V_ASN1_IA5STRING = 22;
  V_ASN1_INTEGER = 2;
  V_ASN1_ISO64STRING = 26;
  V_ASN1_NEG_ENUMERATED = 10+$100;
  V_ASN1_NEG_INTEGER = 2+$100;
  V_ASN1_NULL = 5;
  V_ASN1_NUMERICSTRING = 18;
  V_ASN1_OBJECT = 6;
  V_ASN1_OBJECT_DESCRIPTOR = 7;
  V_ASN1_OCTET_STRING = 4;
  V_ASN1_PRIMATIVE_TAG = $1f;
  V_ASN1_PRIMITIVE_TAG = $1f;
  V_ASN1_PRINTABLESTRING = 19;
  V_ASN1_PRIVATE = $c0;
  V_ASN1_REAL = 9;
  V_ASN1_SEQUENCE = 16;
  V_ASN1_SET = 17;
  V_ASN1_T61STRING = 20;
  V_ASN1_TELETEXSTRING = 20;
  V_ASN1_UNDEF = -1;
  V_ASN1_UNIVERSAL = $00;
  V_ASN1_UNIVERSALSTRING = 28;
  V_ASN1_UTCTIME = 23;
  V_ASN1_UTF8STRING = 12;
  V_ASN1_VIDEOTEXSTRING = 21;
  V_ASN1_VISIBLESTRING = 26;
  WINNT = 1;
  X509_EXT_PACK_STRING = 2;
  X509_EXT_PACK_UNKNOWN = 1;
  X509_EX_V_INIT = $0001;
  X509_EX_V_NETSCAPE_HACK = $8000;
  X509_FILETYPE_DEFAULT = 3;
  X509_F_ADD_CERT_DIR = 100;
  X509_F_BY_FILE_CTRL = 101;
  X509_F_DIR_CTRL = 102;
  X509_F_GET_CERT_BY_SUBJECT = 103;
  X509_F_X509V3_ADD_EXT = 104;
  X509_F_X509_CHECK_PRIVATE_KEY = 128;
  X509_F_X509_EXTENSION_CREATE_BY_NID = 108;
  X509_F_X509_EXTENSION_CREATE_BY_OBJ = 109;
  X509_F_X509_GET_PUBKEY_PARAMETERS = 110;
  X509_F_X509_LOAD_CERT_FILE = 111;
  X509_F_X509_LOAD_CRL_FILE = 112;
  X509_F_X509_NAME_ADD_ENTRY = 113;
  X509_F_X509_NAME_ENTRY_CREATE_BY_NID = 114;
  X509_F_X509_NAME_ENTRY_SET_OBJECT = 115;
  X509_F_X509_NAME_ONELINE = 116;
  X509_F_X509_NAME_PRINT = 117;
  X509_F_X509_PRINT_FP = 118;
  X509_F_X509_PUBKEY_GET = 119;
  X509_F_X509_PUBKEY_SET = 120;
  X509_F_X509_REQ_PRINT = 121;
  X509_F_X509_REQ_PRINT_FP = 122;
  X509_F_X509_REQ_TO_X509 = 123;
  X509_F_X509_STORE_ADD_CERT = 124;
  X509_F_X509_STORE_ADD_CRL = 125;
  X509_F_X509_TO_X509_REQ = 126;
  X509_F_X509_VERIFY_CERT = 127;
  X509_LU_CRL = 2;
  X509_LU_FAIL = 0;
  X509_LU_PKEY = 3;
  X509_LU_RETRY = -1;
  X509_LU_X509 = 1;
  X509_L_ADD_DIR = 2;
  X509_L_FILE_LOAD = 1;
  X509_R_BAD_X509_FILETYPE = 100;
  X509_R_CANT_CHECK_DH_KEY = 114;
  X509_R_CERT_ALREADY_IN_HASH_TABLE = 101;
  X509_R_ERR_ASN1_LIB = 102;
  X509_R_INVALID_DIRECTORY = 113;
  X509_R_KEY_TYPE_MISMATCH = 115;
  X509_R_KEY_VALUES_MISMATCH = 116;
  X509_R_LOADING_CERT_DIR = 103;
  X509_R_LOADING_DEFAULTS = 104;
  X509_R_NO_CERT_SET_FOR_US_TO_VERIFY = 105;
  X509_R_SHOULD_RETRY = 106;
  X509_R_UNABLE_TO_FIND_PARAMETERS_IN_CHAIN = 107;
  X509_R_UNABLE_TO_GET_CERTS_PUBLIC_KEY = 108;
  X509_R_UNKNOWN_KEY_TYPE = 117;
  X509_R_UNKNOWN_NID = 109;
  X509_R_UNSUPPORTED_ALGORITHM = 111;
  X509_R_WRONG_LOOKUP_TYPE = 112;
  X509_V_ERR_APPLICATION_VERIFICATION = 50;
  X509_V_ERR_CERT_CHAIN_TOO_LONG = 22;
  X509_V_ERR_CERT_HAS_EXPIRED = 10;
  X509_V_ERR_CERT_NOT_YET_VALID = 9;
  X509_V_ERR_CERT_REVOKED = 23;
  X509_V_ERR_CERT_SIGNATURE_FAILURE = 7;
  X509_V_ERR_CRL_HAS_EXPIRED = 12;
  X509_V_ERR_CRL_NOT_YET_VALID = 11;
  X509_V_ERR_CRL_SIGNATURE_FAILURE = 8;
  X509_V_ERR_DEPTH_ZERO_SELF_SIGNED_CERT = 18;
  X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD = 14;
  X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD = 13;
  X509_V_ERR_ERROR_IN_CRL_LAST_UPDATE_FIELD = 15;
  X509_V_ERR_ERROR_IN_CRL_NEXT_UPDATE_FIELD = 16;
  X509_V_ERR_OUT_OF_MEM = 17;
  X509_V_ERR_SELF_SIGNED_CERT_IN_CHAIN = 19;
  X509_V_ERR_UNABLE_TO_DECODE_ISSUER_PUBLIC_KEY = 6;
  X509_V_ERR_UNABLE_TO_DECRYPT_CERT_SIGNATURE = 4;
  X509_V_ERR_UNABLE_TO_DECRYPT_CRL_SIGNATURE = 5;
  X509_V_ERR_UNABLE_TO_GET_CRL = 3;
  X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT = 2;
  X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY = 20;
  X509_V_ERR_UNABLE_TO_VERIFY_LEAF_SIGNATURE = 21;
  X509_V_OK = 0;
  X509v3_KU_CRL_SIGN = $0002;
  X509v3_KU_DATA_ENCIPHERMENT = $0010;
  X509v3_KU_DECIPHER_ONLY = $8000;
  X509v3_KU_DIGITAL_SIGNATURE = $0080;
  X509v3_KU_ENCIPHER_ONLY = $0001;
  X509v3_KU_KEY_AGREEMENT = $0008;
  X509v3_KU_KEY_CERT_SIGN = $0004;
  X509v3_KU_KEY_ENCIPHERMENT = $0020;
  X509v3_KU_NON_REPUDIATION = $0040;
  X509v3_KU_UNDEF = $ffff;
  _ATEXIT_SIZE = 32;
  _IOFBF = 0;
  _IOLBF = 1;
  _IONBF = 2;
  _N_LISTS = 30;
  _MSS_WIN32 = 1;
  _MSS_X86_ = 1;
  __CYGWIN32__ = 1;
  __CYGWIN__ = 1;
  __GNUC_MINOR__ = 91;
  __GNUC__ = 2;
  __SAPP = $0100;
  __SEOF = $0020;
  __SERR = $0040;
  __SLBF = $0001;
  __SMBF = $0080;
  __SMOD = $2000;
  __SNBF = $0002;
  __SNPT = $0800;
  __SOFF = $1000;
  __SOPT = $0400;
  __SRD = $0004;
  __SRW = $0010;
  __SSTR = $0200;
  __STDC__ = 1;
  __SWR = $0008;
  __WINNT = 1;
  __WINNT__ = 1;
  __i386 = 1;
  __i386__ = 1;
  __i586 = 1;
  __i586__ = 1;
  __pentium = 1;
  __pentium__ = 1;
  i386 = 1;
  i586 = 1;
  pentium = 1;


(* ---------------------------------------------------------------------------
  List of renamed constants:

    SSL_TXT_ADH => SSL_TXT_ADH_C = "ADH" 
    SSL_TXT_aDH => SSL_TXT_aDH_S = "aDH" 
--------------------------------------------------------------------------- *)


(* ---------------------------------------------------------------------------
  The folowing lines contains elments which propably are not constants

    ASN1_BIT_STRING = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_BMPSTRING = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_ENUMERATED = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_GENERALIZEDTIME = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_GENERALSTRING = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_IA5STRING = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_INTEGER = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_OCTET_STRING = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_PRINTABLESTRING = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_STRING =  {dependency error: not defined};
    ASN1_T61STRING = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_TIME = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_UNIVERSALSTRING = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_UTCTIME = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_UTF8STRING = ASN1_STRING {dependency error: right side incompletely defined};
    ASN1_VISIBLESTRING = ASN1_STRING {dependency error: right side incompletely defined};
    BF_LONG = unsigned int ;
    BIO_new_file =  {dependency error: not defined};
    BIO_new_file_internal = BIO_new_file {dependency error: right side incompletely defined};
    BIO_new_fp_internal = BIO_s_file {dependency error: right side incompletely defined};
    BIO_s_file =  {dependency error: not defined};
    BIO_s_file_internal = BIO_s_file {dependency error: right side incompletely defined};
    BN_DEC_CONV = (1000000000L) ;
    BN_LLONG = ;
    BN_LONG = long {dependency error: right side incompletely defined};
    BN_MASK = (0xffffffffffffffffLL) ;
    BN_MUL_COMBA = ;
    BN_RECURSION = ;
    BN_SQR_COMBA = ;
    BN_ULLONG = unsigned long long ;
    BN_ULONG = unsigned long ;
    BN_prime_checks = (5) ;
    CAST_LONG = unsigned long ;
    CERT = char {dependency error: right side incompletely defined};
    CONFIG_HEADER_BN_H = ;
    CRYPTO_remalloc =  {dependency error: not defined};
    C_Block = des_cblock {dependency error: right side incompletely defined};
    DES_KEY_SZ =  {dependency error: not defined};
    DES_LONG = unsigned long ;
    DES_SCHEDULE_SZ = (sizeof(des_key_schedule)) ;
    EOF = (-1) ;
    EVP_PKEY_DSA_method = DSA_sign,DSA_verify, {EVP_PKEY_DSA,EVP_PKEY_DSA2,EVP_PKEY_DSA3, EVP_PKEY_DSA4,0} ;
    EVP_PKEY_NULL_method = NULL,NULL,{0,0,0,0} ;
    EVP_PKEY_RSA_ASN1_OCTET_STRING_method = RSA_sign_ASN1_OCTET_STRING, RSA_verify_ASN1_OCTET_STRING, {EVP_PKEY_RSA,EVP_PKEY_RSA2,0,0} ;
    EVP_PKEY_RSA_method = RSA_sign,RSA_verify, {EVP_PKEY_RSA,EVP_PKEY_RSA2,0,0} ;
    FreeFunc = free {dependency error: right side incompletely defined};
    HEADER_ASN1_H = ;
    HEADER_BIO_H = ;
    HEADER_BLOWFISH_H = ;
    HEADER_BN_H = ;
    HEADER_BUFFER_H = ;
    HEADER_CAST_H = ;
    HEADER_CRYPTO_H = ;
    HEADER_DES_H = ;
    HEADER_DH_H = ;
    HEADER_DSA_H = ;
    HEADER_ENVELOPE_H = ;
    HEADER_E_OS2_H = ;
    HEADER_IDEA_H = ;
    HEADER_LHASH_H = ;
    HEADER_MD2_H = ;
    HEADER_MD5_H = ;
    HEADER_MDC2_H = ;
    HEADER_OBJECTS_H = ;
    HEADER_OPENSSLV_H = ;
    HEADER_PEM_H = ;
    HEADER_PKCS7_H = ;
    HEADER_RC2_H = ;
    HEADER_RC4_H = ;
    HEADER_RC5_H = ;
    HEADER_RIPEMD_H = ;
    HEADER_RSA_H = ;
    HEADER_SAFESTACK_H = ;
    HEADER_SHA_H = ;
    HEADER_SSL23_H = ;
    HEADER_SSL2_H = ;
    HEADER_SSL3_H = ;
    HEADER_SSL_H = ;
    HEADER_STACK_H = ;
    HEADER_TLS1_H = ;
    HEADER_X509_H = ;
    HEADER_X509_VFY_H = ;
    IDEA_INT = unsigned int ;
    KEY_SZ = DES_KEY_SZ {dependency error: right side incompletely defined};
    Key_schedule = des_key_schedule {dependency error: right side incompletely defined};
    MB_CUR_MAX = __mb_cur_max {dependency error: right side incompletely defined};
    MD2_INT = unsigned int ;
    MD5_LBLOCK = (MD5_CBLOCK/4) ;
    MD5_LONG = unsigned int ;
    MONT_MUL_MOD = ;
    Malloc = malloc {dependency error: right side incompletely defined};
    Malloc_locked = malloc {dependency error: right side incompletely defined};
    NULL = 0L ;
    OBJ_SMIMECapabilities = OBJ_id_pkcs9,15L ;
    OBJ_X500 = 2L,5L ;
    OBJ_X509 = OBJ_X500,4L ;
    OBJ_algorithm = 1L,3L,14L,3L,2L ;
    OBJ_authority_key_identifier = OBJ_ld_ce,35L ;
    OBJ_basic_constraints = OBJ_ld_ce,19L ;
    OBJ_cast5_cbc = 1L,2L,840L,113533L,7L,66L,10L ;
    OBJ_certBag = OBJ_pkcs12_BagIds, 3L ;
    OBJ_certTypes = OBJ_pkcs9, 22L ;
    OBJ_certificate_policies = OBJ_ld_ce,32L ;
    OBJ_client_auth = OBJ_id_kp,2L ;
    OBJ_code_sign = OBJ_id_kp,3L ;
    OBJ_commonName = OBJ_X509,3L ;
    OBJ_countryName = OBJ_X509,6L ;
    OBJ_crlBag = OBJ_pkcs12_BagIds, 4L ;
    OBJ_crlTypes = OBJ_pkcs9, 23L ;
    OBJ_crl_distribution_points = OBJ_ld_ce,31L ;
    OBJ_crl_number = OBJ_ld_ce,20L ;
    OBJ_crl_reason = OBJ_ld_ce,21L ;
    OBJ_delta_crl = OBJ_ld_ce,27L ;
    OBJ_des_cbc = OBJ_algorithm,7L ;
    OBJ_des_cfb64 = OBJ_algorithm,9L ;
    OBJ_des_ecb = OBJ_algorithm,6L ;
    OBJ_des_ede = OBJ_algorithm,17L ;
    OBJ_des_ede3_cbc = OBJ_rsadsi,3L,7L ;
    OBJ_des_ofb64 = OBJ_algorithm,8L ;
    OBJ_description = OBJ_X509,13L ;
    OBJ_dhKeyAgreement = OBJ_pkcs3,1L ;
    OBJ_dsa = 1L,2L,840L,10040L,4L,1L ;
    OBJ_dsaWithSHA = OBJ_algorithm,13L ;
    OBJ_dsaWithSHA1 = 1L,2L,840L,10040L,4L,3L ;
    OBJ_dsaWithSHA1_2 = OBJ_algorithm,27L ;
    OBJ_dsa_2 = OBJ_algorithm,12L ;
    OBJ_email_protect = OBJ_id_kp,4L ;
    OBJ_ext_key_usage = OBJ_ld_ce,37 ;
    OBJ_friendlyName = OBJ_pkcs9, 20L ;
    OBJ_givenName = OBJ_X509,42L ;
    OBJ_hmacWithSHA1 = OBJ_rsadsi,2L,7L ;
    OBJ_id_kp = OBJ_id_pkix,3L ;
    OBJ_id_pbkdf2 = OBJ_pkcs,5L,12L ;
    OBJ_id_pkix = 1L,3L,6L,1L,5L,5L,7L ;
    OBJ_id_qt_cps = OBJ_id_pkix,2L,1L ;
    OBJ_id_qt_unotice = OBJ_id_pkix,2L,2L ;
    OBJ_initials = OBJ_X509,43L ;
    OBJ_invalidity_date = OBJ_ld_ce,24L ;
    OBJ_issuer_alt_name = OBJ_ld_ce,18L ;
    OBJ_keyBag = OBJ_pkcs12_BagIds, 1L ;
    OBJ_key_usage = OBJ_ld_ce,15L ;
    OBJ_ld_ce = 2L,5L,29L ;
    OBJ_localKeyID = OBJ_pkcs9, 21L ;
    OBJ_localityName = OBJ_X509,7L ;
    OBJ_md2 = OBJ_rsadsi,2L,2L ;
    OBJ_md2WithRSAEncryption = OBJ_pkcs,1L,2L ;
    OBJ_md5 = OBJ_rsadsi,2L,5L ;
    OBJ_md5WithRSA = OBJ_algorithm,3L ;
    OBJ_md5WithRSAEncryption = OBJ_pkcs,1L,4L ;
    OBJ_mdc2 = 2L,5L,8L,3L,101L ;
    OBJ_mdc2WithRSA = 2L,5L,8L,3L,100L ;
    OBJ_ms_code_com = 1L,3L,6L,1L,4L,1L,311L,2L,1L,22L ;
    OBJ_ms_code_ind = 1L,3L,6L,1L,4L,1L,311L,2L,1L,21L ;
    OBJ_ms_ctl_sign = 1L,3L,6L,1L,4L,1L,311L,10L,3L,1L ;
    OBJ_ms_efs = 1L,3L,6L,1L,4L,1L,311L,10L,3L,4L ;
    OBJ_ms_sgc = 1L,3L,6L,1L,4L,1L,311L,10L,3L,3L ;
    OBJ_netscape = 2L,16L,840L,1L,113730L ;
    OBJ_netscape_base_url = OBJ_netscape_cert_extension,2L ;
    OBJ_netscape_ca_policy_url = OBJ_netscape_cert_extension,8L ;
    OBJ_netscape_ca_revocation_url = OBJ_netscape_cert_extension,4L ;
    OBJ_netscape_cert_extension = OBJ_netscape,1L ;
    OBJ_netscape_cert_sequence = OBJ_netscape_data_type,5L ;
    OBJ_netscape_cert_type = OBJ_netscape_cert_extension,1L ;
    OBJ_netscape_comment = OBJ_netscape_cert_extension,13L ;
    OBJ_netscape_data_type = OBJ_netscape,2L ;
    OBJ_netscape_renewal_url = OBJ_netscape_cert_extension,7L ;
    OBJ_netscape_revocation_url = OBJ_netscape_cert_extension,3L ;
    OBJ_netscape_ssl_server_name = OBJ_netscape_cert_extension,12L ;
    OBJ_ns_sgc = OBJ_netscape,4L,1L ;
    OBJ_organizationName = OBJ_X509,10L ;
    OBJ_organizationalUnitName = OBJ_X509,11L ;
    OBJ_pbeWithMD2AndDES_CBC = OBJ_pkcs,5L,1L ;
    OBJ_pbeWithMD2AndRC2_CBC = OBJ_pkcs,5L,4L ;
    OBJ_pbeWithMD5AndCast5_CBC = 1L,2L,840L,113533L,7L,66L,12L ;
    OBJ_pbeWithMD5AndDES_CBC = OBJ_pkcs,5L,3L ;
    OBJ_pbeWithMD5AndRC2_CBC = OBJ_pkcs,5L,6L ;
    OBJ_pbeWithSHA1AndDES_CBC = OBJ_pkcs,5L,10L ;
    OBJ_pbeWithSHA1AndRC2_CBC = OBJ_pkcs,5L,11L ;
    OBJ_pbe_WithSHA1And128BitRC2_CBC = OBJ_pkcs12_pbeids, 5L ;
    OBJ_pbe_WithSHA1And128BitRC4 = OBJ_pkcs12_pbeids, 1L ;
    OBJ_pbe_WithSHA1And2_Key_TripleDES_CBC = OBJ_pkcs12_pbeids, 4L ;
    OBJ_pbe_WithSHA1And3_Key_TripleDES_CBC = OBJ_pkcs12_pbeids, 3L ;
    OBJ_pbe_WithSHA1And40BitRC2_CBC = OBJ_pkcs12_pbeids, 6L ;
    OBJ_pbe_WithSHA1And40BitRC4 = OBJ_pkcs12_pbeids, 2L ;
    OBJ_pbes2 = OBJ_pkcs,5L,13L ;
    OBJ_pbmac1 = OBJ_pkcs,5L,14L ;
    OBJ_pkcs = OBJ_rsadsi,1L ;
    OBJ_pkcs12 = OBJ_pkcs,12L ;
    OBJ_pkcs12_BagIds = OBJ_pkcs12_Version1, 1L ;
    OBJ_pkcs12_Version1 = OBJ_pkcs12, 10L ;
    OBJ_pkcs12_pbeids = OBJ_pkcs12, 1 ;
    OBJ_pkcs3 = OBJ_pkcs,3L ;
    OBJ_pkcs7 = OBJ_pkcs,7L ;
    OBJ_pkcs7_data = OBJ_pkcs7,1L ;
    OBJ_pkcs7_digest = OBJ_pkcs7,5L ;
    OBJ_pkcs7_encrypted = OBJ_pkcs7,6L ;
    OBJ_pkcs7_enveloped = OBJ_pkcs7,3L ;
    OBJ_pkcs7_signed = OBJ_pkcs7,2L ;
    OBJ_pkcs7_signedAndEnveloped = OBJ_pkcs7,4L ;
    OBJ_pkcs8ShroudedKeyBag = OBJ_pkcs12_BagIds, 2L ;
    OBJ_pkcs9 = OBJ_pkcs,9L ;
    OBJ_pkcs9_challengePassword = OBJ_pkcs9,7L ;
    OBJ_pkcs9_contentType = OBJ_pkcs9,3L ;
    OBJ_pkcs9_countersignature = OBJ_pkcs9,6L ;
    OBJ_pkcs9_emailAddress = OBJ_pkcs9,1L ;
    OBJ_pkcs9_extCertAttributes = OBJ_pkcs9,9L ;
    OBJ_pkcs9_messageDigest = OBJ_pkcs9,4L ;
    OBJ_pkcs9_signingTime = OBJ_pkcs9,5L ;
    OBJ_pkcs9_unstructuredAddress = OBJ_pkcs9,8L ;
    OBJ_pkcs9_unstructuredName = OBJ_pkcs9,2L ;
    OBJ_private_key_usage_period = OBJ_ld_ce,16L ;
    OBJ_rc2_cbc = OBJ_rsadsi,3L,2L ;
    OBJ_rc4 = OBJ_rsadsi,3L,4L ;
    OBJ_rc5_cbc = OBJ_rsadsi,3L,8L ;
    OBJ_ripemd160 = 1L,3L,36L,3L,2L,1L ;
    OBJ_ripemd160WithRSA = 1L,3L,36L,3L,3L,1L,2L ;
    OBJ_rle_compression = 1L,1L,1L,1L,666L.1L ;
    OBJ_rsa = OBJ_X500,8L,1L,1L ;
    OBJ_rsaEncryption = OBJ_pkcs,1L,1L ;
    OBJ_rsadsi = 1L,2L,840L,113549L ;
    OBJ_safeContentsBag = OBJ_pkcs12_BagIds, 6L ;
    OBJ_sdsiCertificate = OBJ_certTypes, 2L ;
    OBJ_secretBag = OBJ_pkcs12_BagIds, 5L ;
    OBJ_serialNumber = OBJ_X509,5L ;
    OBJ_server_auth = OBJ_id_kp,1L ;
    OBJ_sha = OBJ_algorithm,18L ;
    OBJ_sha1 = OBJ_algorithm,26L ;
    OBJ_sha1WithRSA = OBJ_algorithm,29L ;
    OBJ_sha1WithRSAEncryption = OBJ_pkcs,1L,5L ;
    OBJ_shaWithRSAEncryption = OBJ_algorithm,15L ;
    OBJ_stateOrProvinceName = OBJ_X509,8L ;
    OBJ_subject_alt_name = OBJ_ld_ce,17L ;
    OBJ_subject_key_identifier = OBJ_ld_ce,14L ;
    OBJ_surname = OBJ_X509,4L ;
    OBJ_sxnet = 1L,3L,101L,1L,4L,1L ;
    OBJ_time_stamp = OBJ_id_kp,8L ;
    OBJ_title = OBJ_X509,12L ;
    OBJ_undef = 0L ;
    OBJ_uniqueIdentifier = OBJ_X509,45L ;
    OBJ_x509Certificate = OBJ_certTypes, 1L ;
    OBJ_x509Crl = OBJ_crlTypes, 1L ;
    OBJ_zlib_compression = 1L,1L,1L,1L,666L.2L ;
    OPENSSL_DECLARE_EXIT = ;
    OPENSSL_EXTERN = extern {dependency error: right side incompletely defined};
    OPENSSL_GLOBAL = ;
    OPENSSL_UNISTD =  {dependency error: not defined};
    OPENSSL_UNISTD_IO = OPENSSL_UNISTD {dependency error: right side incompletely defined};
    OPENSSL_VERSION_PTEXT = " part of " OPENSSL_VERSION_TEXT ;
    RC2_INT = unsigned int ;
    RC4_INT = unsigned int ;
    RC5_32_INT = unsigned long ;
    RECP_MUL_MOD = ;
    Realloc = realloc {dependency error: right side incompletely defined};
    Remalloc = CRYPTO_remalloc {dependency error: right side incompletely defined};
    SHA_CBLOCK = (SHA_LBLOCK*4) ;
    SHA_LAST_BLOCK = (SHA_CBLOCK-8) ;
    SHA_LONG = unsigned int ;
    SSL2_MAX_RECORD_LENGTH_2_BYTE_HEADER = (unsigned int)32767 ;
    SSL3_MD_CLIENT_FINISHED_CONST = {0x43,0x4C,0x4E,0x54} ;
    SSL3_MD_SERVER_FINISHED_CONST = {0x53,0x52,0x56,0x52} ;
    SSL3_RS_DATA = ;
    SSL3_RS_WRITE_MORE = ;
    SSL_MIN_RSA_MODULUS_LENGTH_IN_BYTES = (512/8) ;
    THIRTY_TWO_BIT = ;
    _AND = , ;
    _ANSIDECL_H_ = ;
    _BSD_SIZE_T_ = ;
    _CAST_VOID = void {dependency error: right side incompletely defined};
    _CLOCK_T_ = unsigned long ;
    _CONST = const {dependency error: right side incompletely defined};
    _DOTS = , ... ;
    _FLOAT_RET = double {dependency error: right side incompletely defined};
    _FSTDIO = ;
    _GCC_SIZE_T = ;
    _GCC_WCHAR_T = ;
    _HAVE_STDC = ;
    _KERBEROS_DES_H = ;
    _LONG_DOUBLE = long double ;
    _MACHTIME_H_ = ;
    _MACHTYPES_H_ = ;
    _NOARGS = void {dependency error: right side incompletely defined};
    _POINTER_INT = long {dependency error: right side incompletely defined};
    _PTR = void * ;
    _REENT = _impure_ptr {dependency error: right side incompletely defined};
    _SIGNED = signed {dependency error: right side incompletely defined};
    _SIZET_ = ;
    _SIZE_T = ;
    _SIZE_T_ = ;
    _SIZE_T_DEFINED = ;
    _SIZE_T_DEFINED_ = ;
    _STDIO_H_ = ;
    _STDLIB_H_ = ;
    _SYS_REENT_H_ = ;
    _SYS_SIZE_T_H = ;
    _TIME_H_ = ;
    _TIME_T_ = long {dependency error: right side incompletely defined};
    _T_SIZE = ;
    _T_SIZE_ = ;
    _T_WCHAR = ;
    _T_WCHAR_ = ;
    _VOID = void {dependency error: right side incompletely defined};
    _VOLATILE = volatile {dependency error: right side incompletely defined};
    _WCHAR_T = ;
    _WCHAR_T_ = ;
    _WCHAR_T_DEFINED = ;
    _WCHAR_T_DEFINED_ = ;
    _WCHAR_T_H = ;
    __ATTRIBUTE_IMPURE_PTR__ = ;
    __GNUC_VA_LIST = ;
    __INT_WCHAR_T_H = ;
    __SIZE_T = ;
    __SYS_CONFIG_H__ = ;
    __VALIST = __gnuc_va_list {dependency error: right side incompletely defined};
    __WCHAR_T = ;
    ___int_size_t_h = ;
    ___int_wchar_t_h = ;
    __cdecl = __attribute__((__cdecl__)) ;
    __clock_t_defined = ;
    __gnuc_va_list =  {dependency error: not defined};
    __mb_cur_max =  {dependency error: not defined};
    __size_t = ;
    __size_t__ = ;
    __stdcall = __attribute__((__stdcall__)) ;
    __time_t_defined = ;
    __wchar_t__ = ;
    _daylight = (*__imp__daylight) ;
    _impure_ptr =  {dependency error: not defined};
    _timezone = (*__imp__timezone) ;
    _tzname = (*__imp__tzname) ;
    cbc_cksum = des_cbc_cksum {dependency error: right side incompletely defined};
    cbc_encrypt = des_cbc_encrypt {dependency error: right side incompletely defined};
    char =  {dependency error: not defined};
    check_parity =  {dependency error: not defined};
    const =  {dependency error: not defined};
    des_cbc_cksum =  {dependency error: not defined};
    des_cbc_encrypt =  {dependency error: not defined};
    des_cblock =  {dependency error: not defined};
    des_check_key_parity = check_parity {dependency error: right side incompletely defined};
    des_ecb_encrypt =  {dependency error: not defined};
    des_fixup_key_parity = des_set_odd_parity {dependency error: right side incompletely defined};
    des_key_sched =  {dependency error: not defined};
    des_key_schedule =  {dependency error: not defined};
    des_ncbc_encrypt =  {dependency error: not defined};
    des_pcbc_encrypt =  {dependency error: not defined};
    des_quad_cksum =  {dependency error: not defined};
    des_random_key =  {dependency error: not defined};
    des_read_pw_string =  {dependency error: not defined};
    des_set_key =  {dependency error: not defined};
    des_set_odd_parity =  {dependency error: not defined};
    des_string_to_key =  {dependency error: not defined};
    des_xcbc_encrypt =  {dependency error: not defined};
    double =  {dependency error: not defined};
    ecb_encrypt = des_ecb_encrypt {dependency error: right side incompletely defined};
    extern =  {dependency error: not defined};
    free =  {dependency error: not defined};
    key_sched = des_key_sched {dependency error: right side incompletely defined};
    long =  {dependency error: not defined};
    malloc =  {dependency error: not defined};
    ncbc_encrypt = des_ncbc_encrypt {dependency error: right side incompletely defined};
    pcbc_encrypt = des_pcbc_encrypt {dependency error: right side incompletely defined};
    quad_cksum = des_quad_cksum {dependency error: right side incompletely defined};
    random_key = des_random_key {dependency error: right side incompletely defined};
    read_pw_string = des_read_pw_string {dependency error: right side incompletely defined};
    realloc =  {dependency error: not defined};
    set_key = des_set_key {dependency error: right side incompletely defined};
    signed =  {dependency error: not defined};
    stderr = (_impure_ptr->_stderr) ;
    stdin = (_impure_ptr->_stdin) ;
    stdout = (_impure_ptr->_stdout) ;
    string_to_key = des_string_to_key {dependency error: right side incompletely defined};
    void =  {dependency error: not defined};
    volatile =  {dependency error: not defined};
    xcbc_encrypt = des_xcbc_encrypt {dependency error: right side incompletely defined};
--------------------------------------------------------------------------- *)


Type
  UInteger        = Longint;
  PUInteger	  =^UInteger;
  PFunction       = Procedure;
  // Kudzu - CB3,4 dont like this. I think its a typo anyways. I dont think they
  // intended a pointer to a pointer to an integer.
  //PInteger	  =^PInteger;
  PInteger	  =^Integer;
  // End Kudzu
  PLong		  =^Longint;
  // mlussier - CB3,4 dont like this. I think its a typo anyways. I dont think they
  // intended a pointer to a pointer to an cardinal.
  //PULong	  =^PULong;
  PULong	  =^Cardinal;
  PUShort	  =^Byte;
  PPChar	  =^PChar;
{ Corresponding types will be converted later. But ONLY if it is required for  }
{ correct work of unit. But prefered way is TO DO ALL IN C code, it is more    }
{ protable. It think that will be simple for ME mantain this package, specialy } 
{ include changes in new OpenSSL releases.                                     }
{                                                                              }
{ I try to write complex converter, for version 0.9.1c it works fine, but it   }
{ for version 0.9.2b it fails on unions ... it waste my work :-(               }
  PSSL_CTX        = Pointer;
  PSSL            = Pointer;
  PSSL_METHOD     = Pointer;
  PSSL_SESSION    = Pointer;
  PPSSL_SESSION   =^PSSL_SESSION;
  PSSL_CIPHER	  = Pointer;
  Pevp_pkey_st    = Pointer;
  PSTACK          = Pointer;
  PPSTACK         =^PSTACK;
  PCRYPTO_EX_DATA = Pointer;
  PLHASH	  = Pointer;
  PBUF_MEM	  = Pointer;
  PBIO		  = Pointer;
  PPBIO	          =^PBIO;
  PBIO_METHOD     = Pointer;
  PFILE		  = Pointer;
  PBIGNUM	  = Pointer;
  PPBIGNUM	  =^PBIGNUM;
  PBN_CTX	  = Pointer;
  PBN_MONT_CTX    = Pointer;
  PBN_BLINDING	  = Pointer;
  PBN_RECP_CTX    = Pointer;
  PASN1_TYPE	  = Pointer;
  PPASN1_TYPE     =^PASN1_TYPE;
  PASN1_OBJECT    = Pointer;
  PPASN1_OBJECT   =^PASN1_OBJECT;
  PASN1_STRING    = Pointer;
  PPASN1_STRING   =^PASN1_STRING;
  PASN1_CTX	  = Pointer;
  PASN1_HEADER	  = Pointer;
  PPASN1_HEADER   =^PASN1_HEADER;
  PASN1_METHOD    = Pointer;
  PRSA		  = Pointer;
  PPRSA		  =^PRSA;
  PRSA_METHOD	  = Pointer;
  PDSA		  = Pointer;
  PPDSA		  =^PDSA;
  PDH		  = Pointer;
  PPDH		  =^PDH;
  PEVP_MD_CTX     = Pointer;
  PEVP_MD	  = Pointer;
  PEVP_CIPHER	  = Pointer;
  PEVP_CIPHER_CTX = Pointer;
  PEVP_PKEY	  = Pointer;
  PPEVP_PKEY      =^PEVP_PKEY;
  PEVP_ENCODE_CTX = Pointer;
  PX509_LOOKUP    = Pointer;
  PX509_STORE     = Pointer;
  PX509_STORE_CTX = Pointer;
  PX509_CRL	  = Pointer;
  PPX509_CRL               =^PX509_CRL;
  PX509_LOOKUP_METHOD      = Pointer;
  PX509_NAME               = Pointer;
  PPX509_NAME              =^PX509_NAME;
  PX509_OBJECT             = Pointer;
  PX509                    = Pointer;
  PPX509		   =^PX509;
  PX509_EXTENSION_METHOD   = Pointer;
  PX509_REQ	           = Pointer;
  PPX509_REQ		   =^PX509_REQ;
  PX509_ATTRIBUTE	   = Pointer;
  PPX509_ATTRIBUTE	   =^PX509_ATTRIBUTE;
  PX509_EXTENSION	   = Pointer;
  PPX509_EXTENSION	   =^PX509_EXTENSION;
  PX509_NAME_ENTRY	   = Pointer;
  PPX509_NAME_ENTRY	   =^PX509_NAME_ENTRY;
  PX509_ALGOR		   = Pointer;
  PPX509_ALGOR		   =^PX509_ALGOR;
  PX509_VAL		   = Pointer;
  PPX509_VAL		   =^PX509_VAL;
  PX509_PUBKEY		   = Pointer;
  PPX509_PUBKEY		   =^PX509_PUBKEY;
  PX509_SIG		   = Pointer;
  PPX509_SIG		   =^PX509_SIG;
  PX509_REQ_INFO	   = Pointer;
  PPX509_REQ_INFO	   =^PX509_REQ_INFO;
  PX509_CINF		   = Pointer;
  PPX509_CINF		   =^PX509_CINF;
  PX509_REVOKED		   = Pointer;
  PPX509_REVOKED	   =^PX509_REVOKED;
  PX509_CRL_INFO	   = Pointer;
  PPX509_CRL_INFO	   =^PX509_CRL_INFO;
  PX509_PKEY		   = Pointer;
  PPX509_PKEY		   =^PX509_PKEY;
  PX509_INFO	           = Pointer;
  PPX509_INFO		   =^PX509_INFO;
  PPKCS7_ISSUER_AND_SERIAL = Pointer;
  PKCS7			   = Pointer; 
  PPKCS7                   =^PKCS7;
  PPPKCS7		   =^PPKCS7;
  PKCS7_SIGNER_INFO	   = Pointer;
    // Kudzu - For CB
    {$IFDEF VER110}{$NODEFINE PKCS7_SIGNER_INFO}{$ENDIF} // Took out WinsockIntf.
    {$IFDEF VER125}{$NODEFINE PKCS7_SIGNER_INFO}{$ENDIF}
    {$IFDEF VER130}{$NODEFINE PKCS7_SIGNER_INFO}{$ENDIF}
  PPKCS7_SIGNER_INFO       =^PKCS7_SIGNER_INFO;
  PPPKCS7_SIGNER_INFO      =^PPKCS7_SIGNER_INFO;
  PKCS7_RECIP_INFO	   = Pointer;
  PPKCS7_RECIP_INFO        =^PKCS7_RECIP_INFO;
  PPPKCS7_RECIP_INFO       =^PPKCS7_RECIP_INFO;
  PPPKCS7_ISSUER_AND_SERIAL=^PPKCS7_ISSUER_AND_SERIAL;
  PKCS7_SIGNED	           = Pointer;
  PPKCS7_SIGNED		   =^PKCS7_SIGNED;
  PPPKCS7_SIGNED	   = Pointer;
  PPKCS7_ENC_CONTENT	   = Pointer;
  PPPKCS7_ENC_CONTENT	   =^PPKCS7_ENC_CONTENT;
  PPKCS7_ENVELOPE	   = Pointer;
  PPPKCS7_ENVELOPE	   =^PPKCS7_ENVELOPE;
  PPKCS7_SIGN_ENVELOPE	   = Pointer;
  PPPKCS7_SIGN_ENVELOPE	   =^PPKCS7_SIGN_ENVELOPE;
  PPKCS7_DIGEST		   = Pointer;
  PPPKCS7_DIGEST	   =^PPKCS7_DIGEST;
  PPKCS7_ENCRYPT	   = Pointer;
  PPPKCS7_ENCRYPT	   =^PPKCS7_ENCRYPT;
  PNETSCAPE_SPKI	   = Pointer;
  PPNETSCAPE_SPKI	   =^PNETSCAPE_SPKI;
  PNETSCAPE_SPKAC	   = Pointer;
  PPNETSCAPE_SPKAC	   =^PNETSCAPE_SPKAC;
  PNETSCAPE_CERT_SEQUENCE  = Pointer;
  PPNETSCAPE_CERT_SEQUENCE =^PNETSCAPE_CERT_SEQUENCE;
  Pbio_st		   = Pointer;
  PMD2_CTX		   = Pointer;
  PMD5_CTX		   = Pointer;
  PSHA_CTX		   = Pointer;
  PRIPEMD160_CTX	   = Pointer;
  PRC4_KEY		   = Pointer;
  PRC2_KEY		   = Pointer;
  PRC5_32_KEY		   = Pointer;
  PBF_KEY		   = Pointer;
  PCAST_KEY		   = Pointer;
  PIDEA_KEY_SCHEDULE       = Pointer;
  PMDC2_CTX                = Pointer;
  PPDSA_SIG                = Pointer;
  P_des_cblock		   = Pointer;
  Pdes_cblock		   = Pointer;
  PDSA_SIG		   = Pointer;
  PSTACK_ASN1_TYPE	   = Pointer;
  PPSTACK_ASN1_TYPE	   = Pointer;
  PSTACK_X509_NAME_ENTRY   = Pointer;
  PPSTACK_X509_NAME_ENTRY  = Pointer;
  PSTACK_X509_NAME         = Pointer;
  PSTACK_X509_EXTENSION	   = Pointer;
  PPSTACK_X509_EXTENSIO    = Pointer;
  PSTACK_X509_ATTRIBUTE    = Pointer;
  PPSTACK_X509_ATTRIBUTE   =^PSTACK_X509_ATTRIBUTE;
  PSTACK_X509		   = Pointer;
  PPSTACK_X509		   =^PSTACK_X509;
  PSTACK_X509_INFO         = Pointer;
  PPBEPARAM		   = Pointer;
  PPPBEPARAM		   =^PPBEPARAM;
  PPBKDF2PARAM		   = Pointer;
  PPPBKDF2PARAM		   =^PPBKDF2PARAM;
  PPBE2PARAM		   = Pointer;
  PPPBE2PARAM		   =^PPBE2PARAM;
  PPSTACK_X509_EXTENSION   = Pointer;
  PPKCS8_PRIV_KEY_INFO	   = Pointer;
  PPPKCS8_PRIV_KEY_INFO    =^PPKCS8_PRIV_KEY_INFO;
  PEVP_PBE_KEYGEN          = Pointer;
  PEVP_CIPHER_INFO	   = Pointer;
  Ppem_password_cb	   = Pointer;
  PPEM_ENCODE_SEAL_CTX     = Pointer;
  PSTACK_SSL_CIPHER        = Pointer;
  PSTACK_SSL_COMP          = Pointer;
  PSSL_COMP		   = Pointer;
  PASN1_UTCTIME		   = Pointer;
  PSTACK_ASN1_OBJECT	   = Pointer;
  PPSTACK_ASN1_OBJECT      =^PSTACK_ASN1_OBJECT;
  PSTACK_X509_ALGOR        = Pointer;
  PPSTACK_X509_ALGOR       =^PSTACK_X509_ALGOR;
  PSTACK_X509_REVOKED      = Pointer;
  PPSTACK_X509_REVOKED     =^PSTACK_X509_REVOKED;
  PSTACK_X509_CRL          = Pointer;
  PPSTACK_X509_CRL         =^PSTACK_X509_CRL;
  PSTACK_X509_LOOKUP       = Pointer;
  PPSTACK_X509_LOOKUP      =^PSTACK_X509_LOOKUP;
  PSTACK_PKCS7_SIGNER_INFO = Pointer;
  PPSTACK_PKCS7_SIGNER_INFO=^PSTACK_PKCS7_SIGNER_INFO;
  PSTACK_PKCS7_RECIP_INFO  = Pointer;
  PPSTACK_PKCS7_RECIP_INFO =^PSTACK_PKCS7_RECIP_INFO;

//GREGOR - spremenjana deklaracija ker se tolèe
//  Phostent	  = Pointer;
  Phostent2	  = Pointer;
//END GREGOR
{ This should cause problems, but I will solve them ONLY if they came ...      }
{ !!!InvalidTypes!!!                                                           }
  time_t	  = Integer;
  des_cblock	  = Integer;
  des_key_schedule= Integer;
  des_cblocks     = Integer; 
  size_t	  = Integer;

	
{$IFDEF MySSL_STATIC}
  function  f_sk_num(arg0: PSTACK):Integer; cdecl
  function  f_sk_value(arg0: PSTACK; arg1: Integer):PChar; cdecl
  function  f_sk_set(arg0: PSTACK; arg1: Integer; arg2: PChar):PChar; cdecl
  function  f_sk_new(arg0: PFunction):PSTACK; cdecl
  procedure f_sk_free(arg0: PSTACK); cdecl;
  procedure f_sk_pop_free(st: PSTACK; arg1: PFunction); cdecl;
  function  f_sk_insert(sk: PSTACK; data: PChar; where: Integer):Integer; cdecl
  function  f_sk_delete(st: PSTACK; loc: Integer):PChar; cdecl
  function  f_sk_delete_ptr(st: PSTACK; p: PChar):PChar; cdecl
  function  f_sk_find(st: PSTACK; data: PChar):Integer; cdecl
  function  f_sk_push(st: PSTACK; data: PChar):Integer; cdecl
  function  f_sk_unshift(st: PSTACK; data: PChar):Integer; cdecl
  function  f_sk_shift(st: PSTACK):PChar; cdecl
  function  f_sk_pop(st: PSTACK):PChar; cdecl
  procedure f_sk_zero(st: PSTACK); cdecl;
  function  f_sk_dup(st: PSTACK):PSTACK; cdecl
  procedure f_sk_sort(st: PSTACK); cdecl;
  function  f_SSLeay_version(_type: Integer):PChar; cdecl
  function  f_SSLeay:Cardinal; cdecl
  function  f_CRYPTO_get_ex_new_index(idx: Integer; sk: PPSTACK; argl: Longint; argp: PChar; arg4: PFunction; arg5: PFunction; arg6: PFunction):Integer; cdecl
  function  f_CRYPTO_set_ex_data(ad: PCRYPTO_EX_DATA; idx: Integer; val: PChar):Integer; cdecl
  function  f_CRYPTO_get_ex_data(ad: PCRYPTO_EX_DATA; idx: Integer):PChar; cdecl
  function  f_CRYPTO_dup_ex_data(meth: PSTACK; from: PCRYPTO_EX_DATA; _to: PCRYPTO_EX_DATA):Integer; cdecl
  procedure f_CRYPTO_free_ex_data(meth: PSTACK; obj: PChar; ad: PCRYPTO_EX_DATA); cdecl;
  procedure f_CRYPTO_new_ex_data(meth: PSTACK; obj: PChar; ad: PCRYPTO_EX_DATA); cdecl;
  function  f_CRYPTO_mem_ctrl(mode: Integer):Integer; cdecl
  function  f_CRYPTO_get_new_lockid(name: PChar):Integer; cdecl
  function  f_CRYPTO_num_locks:Integer; cdecl
  procedure f_CRYPTO_lock(mode: Integer; _type: Integer; const _file: PChar; line: Integer); cdecl;
  procedure f_CRYPTO_set_locking_callback(arg0: PFunction); cdecl;
  procedure f_CRYPTO_set_add_lock_callback(arg0: PFunction); cdecl;
  procedure f_CRYPTO_set_id_callback(arg0: PFunction); cdecl;
  function  f_CRYPTO_thread_id:Cardinal; cdecl
  function  f_CRYPTO_get_lock_name(_type: Integer):PChar; cdecl
  function  f_CRYPTO_add_lock(pointer: PInteger; amount: Integer; _type: Integer; const _file: PChar; line: Integer):Integer; cdecl
  procedure f_CRYPTO_set_mem_functions(arg0: PFunction; arg1: PFunction; arg2: PFunction); cdecl;
  procedure f_CRYPTO_get_mem_functions(arg0: PFunction; arg1: PFunction; arg2: PFunction); cdecl;
  procedure f_CRYPTO_set_locked_mem_functions(arg0: PFunction; arg1: PFunction); cdecl;
  procedure f_CRYPTO_get_locked_mem_functions(arg0: PFunction; arg1: PFunction); cdecl;
  function  f_CRYPTO_malloc_locked(num: Integer):Pointer; cdecl
  procedure f_CRYPTO_free_locked(arg0: Pointer); cdecl;
  function  f_CRYPTO_malloc(num: Integer):Pointer; cdecl
  procedure f_CRYPTO_free(arg0: Pointer); cdecl;
  function  f_CRYPTO_realloc(addr: Pointer; num: Integer):Pointer; cdecl
  function  f_CRYPTO_remalloc(addr: Pointer; num: Integer):Pointer; cdecl
  function  f_CRYPTO_dbg_malloc(num: Integer; const _file: PChar; line: Integer):Pointer; cdecl
  function  f_CRYPTO_dbg_realloc(addr: Pointer; num: Integer; const _file: PChar; line: Integer):Pointer; cdecl
  procedure f_CRYPTO_dbg_free(arg0: Pointer); cdecl;
  function  f_CRYPTO_dbg_remalloc(addr: Pointer; num: Integer; const _file: PChar; line: Integer):Pointer; cdecl
  procedure f_CRYPTO_mem_leaks_fp(arg0: PFILE); cdecl;
  procedure f_CRYPTO_mem_leaks(bio: Pbio_st); cdecl;
  procedure f_CRYPTO_mem_leaks_cb(arg0: PFunction); cdecl;
  procedure f_ERR_load_CRYPTO_strings; cdecl;
  function  f_lh_new(arg0: PFunction; arg1: PFunction):PLHASH; cdecl
  procedure f_lh_free(lh: PLHASH); cdecl;
  function  f_lh_insert(lh: PLHASH; data: PChar):PChar; cdecl
  function  f_lh_delete(lh: PLHASH; data: PChar):PChar; cdecl
  function  f_lh_retrieve(lh: PLHASH; data: PChar):PChar; cdecl
  procedure f_lh_doall(lh: PLHASH; arg1: PFunction); cdecl;
  procedure f_lh_doall_arg(lh: PLHASH; arg1: PFunction; arg: PChar); cdecl;
  function  f_lh_strhash(const c: PChar):Cardinal; cdecl
  procedure f_lh_stats(lh: PLHASH; _out: PFILE); cdecl;
  procedure f_lh_node_stats(lh: PLHASH; _out: PFILE); cdecl;
  procedure f_lh_node_usage_stats(lh: PLHASH; _out: PFILE); cdecl;
  function  f_BUF_MEM_new:PBUF_MEM; cdecl
  procedure f_BUF_MEM_free(a: PBUF_MEM); cdecl;
  function  f_BUF_MEM_grow(str: PBUF_MEM; len: Integer):Integer; cdecl
  function  f_BUF_strdup(const str: PChar):PChar; cdecl
  procedure f_ERR_load_BUF_strings; cdecl;
  function  f_BIO_ctrl_pending(b: PBIO):size_t; cdecl
  function  f_BIO_ctrl_wpending(b: PBIO):size_t; cdecl
  function  f_BIO_ctrl_get_write_guarantee(b: PBIO):size_t; cdecl
  function  f_BIO_ctrl_get_read_request(b: PBIO):size_t; cdecl
  function  f_BIO_set_ex_data(bio: PBIO; idx: Integer; data: PChar):Integer; cdecl
  function  f_BIO_get_ex_data(bio: PBIO; idx: Integer):PChar; cdecl
  function  f_BIO_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; cdecl
  function  f_BIO_s_file:PBIO_METHOD; cdecl
  function  f_BIO_new_file(const filename: PChar; const mode: PChar):PBIO; cdecl
  function  f_BIO_new_fp(stream: PFILE; close_flag: Integer):PBIO; cdecl
  function  f_BIO_new(_type: PBIO_METHOD):PBIO; cdecl
  function  f_BIO_set(a: PBIO; _type: PBIO_METHOD):Integer; cdecl
  function  f_BIO_free(a: PBIO):Integer; cdecl
  function  f_BIO_read(b: PBIO; data: Pointer; len: Integer):Integer; cdecl
  function  f_BIO_gets(bp: PBIO; buf: PChar; size: Integer):Integer; cdecl
  function  f_BIO_write(b: PBIO; const data: PChar; len: Integer):Integer; cdecl
  function  f_BIO_puts(bp: PBIO; const buf: PChar):Integer; cdecl
  function  f_BIO_ctrl(bp: PBIO; cmd: Integer; larg: Longint; parg: Pointer):Longint; cdecl
  function  f_BIO_ptr_ctrl(bp: PBIO; cmd: Integer; larg: Longint):PChar; cdecl
  function  f_BIO_int_ctrl(bp: PBIO; cmd: Integer; larg: Longint; iarg: Integer):Longint; cdecl
  function  f_BIO_push(b: PBIO; append: PBIO):PBIO; cdecl
  function  f_BIO_pop(b: PBIO):PBIO; cdecl
  procedure f_BIO_free_all(a: PBIO); cdecl;
  function  f_BIO_find_type(b: PBIO; bio_type: Integer):PBIO; cdecl
  function  f_BIO_get_retry_BIO(bio: PBIO; reason: PInteger):PBIO; cdecl
  function  f_BIO_get_retry_reason(bio: PBIO):Integer; cdecl
  function  f_BIO_dup_chain(_in: PBIO):PBIO; cdecl
  function  f_BIO_debug_callback(bio: PBIO; cmd: Integer; const argp: PChar; argi: Integer; argl: Longint; ret: Longint):Longint; cdecl
  function  f_BIO_s_mem:PBIO_METHOD; cdecl
  function  f_BIO_s_socket:PBIO_METHOD; cdecl
  function  f_BIO_s_connect:PBIO_METHOD; cdecl
  function  f_BIO_s_accept:PBIO_METHOD; cdecl
  function  f_BIO_s_fd:PBIO_METHOD; cdecl
  function  f_BIO_s_bio:PBIO_METHOD; cdecl
  function  f_BIO_s_null:PBIO_METHOD; cdecl
  function  f_BIO_f_null:PBIO_METHOD; cdecl
  function  f_BIO_f_buffer:PBIO_METHOD; cdecl
  function  f_BIO_f_nbio_test:PBIO_METHOD; cdecl
  function  f_BIO_sock_should_retry(i: Integer):Integer; cdecl
  function  f_BIO_sock_non_fatal_error(error: Integer):Integer; cdecl
  function  f_BIO_fd_should_retry(i: Integer):Integer; cdecl
  function  f_BIO_fd_non_fatal_error(error: Integer):Integer; cdecl
  function  f_BIO_dump(b: PBIO; const bytes: PChar; len: Integer):Integer; cdecl
  function  f_BIO_gethostbyname(const name: PChar):Phostent2; cdecl
  function  f_BIO_sock_error(sock: Integer):Integer; cdecl
  function  f_BIO_socket_ioctl(fd: Integer; _type: Longint; arg: PULong):Integer; cdecl
  function  f_BIO_socket_nbio(fd: Integer; mode: Integer):Integer; cdecl
  function  f_BIO_get_port(const str: PChar; port_ptr: PUShort):Integer; cdecl
  function  f_BIO_get_host_ip(const str: PChar; ip: PChar):Integer; cdecl
  function  f_BIO_get_accept_socket(host_port: PChar; mode: Integer):Integer; cdecl
  function  f_BIO_accept(sock: Integer; ip_port: PPChar):Integer; cdecl
  function  f_BIO_sock_init:Integer; cdecl
  procedure f_BIO_sock_cleanup; cdecl;
  function  f_BIO_set_tcp_ndelay(sock: Integer; turn_on: Integer):Integer; cdecl
  procedure f_ERR_load_BIO_strings; cdecl;
  function  f_BIO_new_socket(sock: Integer; close_flag: Integer):PBIO; cdecl
  function  f_BIO_new_fd(fd: Integer; close_flag: Integer):PBIO; cdecl
  function  f_BIO_new_connect(host_port: PChar):PBIO; cdecl
  function  f_BIO_new_accept(host_port: PChar):PBIO; cdecl
  function  f_BIO_new_bio_pair(bio1: PPBIO; writebuf1: size_t; bio2: PPBIO; writebuf2: size_t):Integer; cdecl
  procedure f_BIO_copy_next_retry(b: PBIO); cdecl;
  function  f_BIO_ghbn_ctrl(cmd: Integer; iarg: Integer; parg: PChar):Longint; cdecl
  function  f_MD2_options:PChar; cdecl
  procedure f_MD2_Init(c: PMD2_CTX); cdecl;
  procedure f_MD2_Update(c: PMD2_CTX; data: PChar; len: Cardinal); cdecl;
  procedure f_MD2_Final(md: PChar; c: PMD2_CTX); cdecl;
  function  f_MD2(d: PChar; n: Cardinal; md: PChar):PChar; cdecl
  procedure f_MD5_Init(c: PMD5_CTX); cdecl;
  procedure f_MD5_Update(c: PMD5_CTX; const data: PChar; len: Cardinal); cdecl;
  procedure f_MD5_Final(md: PChar; c: PMD5_CTX); cdecl;
  function  f_MD5(d: PChar; n: Cardinal; md: PChar):PChar; cdecl
  procedure f_MD5_Transform(c: PMD5_CTX; const b: PChar); cdecl;
  procedure f_SHA_Init(c: PSHA_CTX); cdecl;
  procedure f_SHA_Update(c: PSHA_CTX; const data: PChar; len: Cardinal); cdecl;
  procedure f_SHA_Final(md: PChar; c: PSHA_CTX); cdecl;
  function  f_SHA(const d: PChar; n: Cardinal; md: PChar):PChar; cdecl
  procedure f_SHA_Transform(c: PSHA_CTX; data: PChar); cdecl;
  procedure f_SHA1_Init(c: PSHA_CTX); cdecl;
  procedure f_SHA1_Update(c: PSHA_CTX; const data: PChar; len: Cardinal); cdecl;
  procedure f_SHA1_Final(md: PChar; c: PSHA_CTX); cdecl;
  function  f_SHA1(const d: PChar; n: Cardinal; md: PChar):PChar; cdecl
  procedure f_SHA1_Transform(c: PSHA_CTX; data: PChar); cdecl;
  procedure f_RIPEMD160_Init(c: PRIPEMD160_CTX); cdecl;
  procedure f_RIPEMD160_Update(c: PRIPEMD160_CTX; data: PChar; len: Cardinal); cdecl;
  procedure f_RIPEMD160_Final(md: PChar; c: PRIPEMD160_CTX); cdecl;
  function  f_RIPEMD160(d: PChar; n: Cardinal; md: PChar):PChar; cdecl
  procedure f_RIPEMD160_Transform(c: PRIPEMD160_CTX; b: PChar); cdecl;
  function  f_des_options:PChar; cdecl
  procedure f_des_ecb3_encrypt(const input: P_des_cblock; output: Pdes_cblock; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; enc: Integer); cdecl;
  function  f_des_cbc_cksum(const input: PChar; output: Pdes_cblock; length: Longint; schedule: des_key_schedule; const ivec: P_des_cblock):Cardinal; cdecl
  procedure f_des_cbc_encrypt(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer); cdecl;
  procedure f_des_ncbc_encrypt(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer); cdecl;
  procedure f_des_xcbc_encrypt(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; const inw: P_des_cblock; const outw: P_des_cblock; enc: Integer); cdecl;
  procedure f_des_cfb_encrypt(const _in: PChar; _out: PChar; numbits: Integer; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer); cdecl;
  procedure f_des_ecb_encrypt(const input: P_des_cblock; output: Pdes_cblock; ks: des_key_schedule; enc: Integer); cdecl;
  procedure f_des_encrypt(data: PULong; ks: des_key_schedule; enc: Integer); cdecl;
  procedure f_des_encrypt2(data: PULong; ks: des_key_schedule; enc: Integer); cdecl;
  procedure f_des_encrypt3(data: PULong; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule); cdecl;
  procedure f_des_decrypt3(data: PULong; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule); cdecl;
  procedure f_des_ede3_cbc_encrypt(const input: PChar; output: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec: Pdes_cblock; enc: Integer); cdecl;
  procedure f_des_ede3_cbcm_encrypt(const _in: PChar; _out: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec1: Pdes_cblock; ivec2: Pdes_cblock; enc: Integer); cdecl;
  procedure f_des_ede3_cfb64_encrypt(const _in: PChar; _out: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec: Pdes_cblock; num: PInteger; enc: Integer); cdecl;
  procedure f_des_ede3_ofb64_encrypt(const _in: PChar; _out: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec: Pdes_cblock; num: PInteger); cdecl;
  procedure f_des_xwhite_in2out(const des_key: P_des_cblock; const in_white: P_des_cblock; out_white: Pdes_cblock); cdecl;
  function  f_des_enc_read(fd: Integer; buf: Pointer; len: Integer; sched: des_key_schedule; iv: Pdes_cblock):Integer; cdecl
  function  f_des_enc_write(fd: Integer; const buf: Pointer; len: Integer; sched: des_key_schedule; iv: Pdes_cblock):Integer; cdecl
  function  f_des_fcrypt(const buf: PChar; const salt: PChar; ret: PChar):PChar; cdecl
  function  f_crypt(const buf: PChar; const salt: PChar):PChar; cdecl
  procedure f_des_ofb_encrypt(const _in: PChar; _out: PChar; numbits: Integer; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock); cdecl;
  procedure f_des_pcbc_encrypt(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer); cdecl;
  function  f_des_quad_cksum(const input: PChar; output: des_cblock; length: Longint; out_count: Integer; seed: Pdes_cblock):Cardinal; cdecl
  procedure f_des_random_seed(key: Pdes_cblock); cdecl;
  procedure f_des_random_key(ret: Pdes_cblock); cdecl;
  function  f_des_read_password(key: Pdes_cblock; const prompt: PChar; verify: Integer):Integer; cdecl
  function  f_des_read_2passwords(key1: Pdes_cblock; key2: Pdes_cblock; const prompt: PChar; verify: Integer):Integer; cdecl
  function  f_des_read_pw_string(buf: PChar; length: Integer; const prompt: PChar; verify: Integer):Integer; cdecl
  procedure f_des_set_odd_parity(key: Pdes_cblock); cdecl;
  function  f_des_is_weak_key(const key: P_des_cblock):Integer; cdecl
  function  f_des_set_key(const key: P_des_cblock; schedule: des_key_schedule):Integer; cdecl
  function  f_des_key_sched(const key: P_des_cblock; schedule: des_key_schedule):Integer; cdecl
  procedure f_des_string_to_key(const str: PChar; key: Pdes_cblock); cdecl;
  procedure f_des_string_to_2keys(const str: PChar; key1: Pdes_cblock; key2: Pdes_cblock); cdecl;
  procedure f_des_cfb64_encrypt(const _in: PChar; _out: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; num: PInteger; enc: Integer); cdecl;
  procedure f_des_ofb64_encrypt(const _in: PChar; _out: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; num: PInteger); cdecl;
  function  f_des_read_pw(buf: PChar; buff: PChar; size: Integer; const prompt: PChar; verify: Integer):Integer; cdecl
  procedure f_des_cblock_print_file(const cb: P_des_cblock; fp: PFILE); cdecl;
  function  f_RC4_options:PChar; cdecl
  procedure f_RC4_set_key(key: PRC4_KEY; len: Integer; data: PChar); cdecl;
  procedure f_RC4(key: PRC4_KEY; len: Cardinal; indata: PChar; outdata: PChar); cdecl;
  procedure f_RC2_set_key(key: PRC2_KEY; len: Integer; data: PChar; bits: Integer); cdecl;
  procedure f_RC2_ecb_encrypt(_in: PChar; _out: PChar; key: PRC2_KEY; enc: Integer); cdecl;
  procedure f_RC2_encrypt(data: PULong; key: PRC2_KEY); cdecl;
  procedure f_RC2_decrypt(data: PULong; key: PRC2_KEY); cdecl;
  procedure f_RC2_cbc_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PRC2_KEY; iv: PChar; enc: Integer); cdecl;
  procedure f_RC2_cfb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PRC2_KEY; ivec: PChar; num: PInteger; enc: Integer); cdecl;
  procedure f_RC2_ofb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PRC2_KEY; ivec: PChar; num: PInteger); cdecl;
  procedure f_RC5_32_set_key(key: PRC5_32_KEY; len: Integer; data: PChar; rounds: Integer); cdecl;
  procedure f_RC5_32_ecb_encrypt(_in: PChar; _out: PChar; key: PRC5_32_KEY; enc: Integer); cdecl;
  procedure f_RC5_32_encrypt(data: PULong; key: PRC5_32_KEY); cdecl;
  procedure f_RC5_32_decrypt(data: PULong; key: PRC5_32_KEY); cdecl;
  procedure f_RC5_32_cbc_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PRC5_32_KEY; iv: PChar; enc: Integer); cdecl;
  procedure f_RC5_32_cfb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PRC5_32_KEY; ivec: PChar; num: PInteger; enc: Integer); cdecl;
  procedure f_RC5_32_ofb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PRC5_32_KEY; ivec: PChar; num: PInteger); cdecl;
  procedure f_BF_set_key(key: PBF_KEY; len: Integer; data: PChar); cdecl;
  procedure f_BF_ecb_encrypt(_in: PChar; _out: PChar; key: PBF_KEY; enc: Integer); cdecl;
  procedure f_BF_encrypt(data: PUInteger; key: PBF_KEY); cdecl;
  procedure f_BF_decrypt(data: PUInteger; key: PBF_KEY); cdecl;
  procedure f_BF_cbc_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PBF_KEY; iv: PChar; enc: Integer); cdecl;
  procedure f_BF_cfb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PBF_KEY; ivec: PChar; num: PInteger; enc: Integer); cdecl;
  procedure f_BF_ofb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PBF_KEY; ivec: PChar; num: PInteger); cdecl;
  function  f_BF_options:PChar; cdecl
  procedure f_CAST_set_key(key: PCAST_KEY; len: Integer; data: PChar); cdecl;
  procedure f_CAST_ecb_encrypt(const _in: PChar; _out: PChar; key: PCAST_KEY; enc: Integer); cdecl;
  procedure f_CAST_encrypt(data: PULong; key: PCAST_KEY); cdecl;
  procedure f_CAST_decrypt(data: PULong; key: PCAST_KEY); cdecl;
  procedure f_CAST_cbc_encrypt(const _in: PChar; _out: PChar; length: Longint; ks: PCAST_KEY; iv: PChar; enc: Integer); cdecl;
  procedure f_CAST_cfb64_encrypt(const _in: PChar; _out: PChar; length: Longint; schedule: PCAST_KEY; ivec: PChar; num: PInteger; enc: Integer); cdecl;
  procedure f_CAST_ofb64_encrypt(const _in: PChar; _out: PChar; length: Longint; schedule: PCAST_KEY; ivec: PChar; num: PInteger); cdecl;
  function  f_idea_options:PChar; cdecl
  procedure f_idea_ecb_encrypt(_in: PChar; _out: PChar; ks: PIDEA_KEY_SCHEDULE); cdecl;
  procedure f_idea_set_encrypt_key(key: PChar; ks: PIDEA_KEY_SCHEDULE); cdecl;
  procedure f_idea_set_decrypt_key(ek: PIDEA_KEY_SCHEDULE; dk: PIDEA_KEY_SCHEDULE); cdecl;
  procedure f_idea_cbc_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PIDEA_KEY_SCHEDULE; iv: PChar; enc: Integer); cdecl;
  procedure f_idea_cfb64_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PIDEA_KEY_SCHEDULE; iv: PChar; num: PInteger; enc: Integer); cdecl;
  procedure f_idea_ofb64_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PIDEA_KEY_SCHEDULE; iv: PChar; num: PInteger); cdecl;
  procedure f_idea_encrypt(_in: PULong; ks: PIDEA_KEY_SCHEDULE); cdecl;
  procedure f_MDC2_Init(c: PMDC2_CTX); cdecl;
  procedure f_MDC2_Update(c: PMDC2_CTX; data: PChar; len: Cardinal); cdecl;
  procedure f_MDC2_Final(md: PChar; c: PMDC2_CTX); cdecl;
  function  f_MDC2(d: PChar; n: Cardinal; md: PChar):PChar; cdecl
  function  f_BN_value_one:PBIGNUM; cdecl
  function  f_BN_options:PChar; cdecl
  function  f_BN_CTX_new:PBN_CTX; cdecl
  procedure f_BN_CTX_init(c: PBN_CTX); cdecl;
  procedure f_BN_CTX_free(c: PBN_CTX); cdecl;
  function  f_BN_rand(rnd: PBIGNUM; bits: Integer; top: Integer; bottom: Integer):Integer; cdecl
  function  f_BN_num_bits(const a: PBIGNUM):Integer; cdecl
  function  f_BN_num_bits_word(arg0: Cardinal):Integer; cdecl
  function  f_BN_new:PBIGNUM; cdecl
  procedure f_BN_init(arg0: PBIGNUM); cdecl;
  procedure f_BN_clear_free(a: PBIGNUM); cdecl;
  function  f_BN_copy(a: PBIGNUM; const b: PBIGNUM):PBIGNUM; cdecl
  function  f_BN_bin2bn(const s: PChar; len: Integer; ret: PBIGNUM):PBIGNUM; cdecl
  function  f_BN_bn2bin(const a: PBIGNUM; _to: PChar):Integer; cdecl
  function  f_BN_mpi2bn(s: PChar; len: Integer; ret: PBIGNUM):PBIGNUM; cdecl
  function  f_BN_bn2mpi(const a: PBIGNUM; _to: PChar):Integer; cdecl
  function  f_BN_sub(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM):Integer; cdecl
  function  f_BN_usub(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM):Integer; cdecl
  function  f_BN_uadd(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM):Integer; cdecl
  function  f_BN_add(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM):Integer; cdecl
  function  f_BN_mod(rem: PBIGNUM; const m: PBIGNUM; const d: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_div(dv: PBIGNUM; rem: PBIGNUM; const m: PBIGNUM; const d: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_mul(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_sqr(r: PBIGNUM; a: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_mod_word(a: PBIGNUM; w: Cardinal):Cardinal; cdecl
  function  f_BN_div_word(a: PBIGNUM; w: Cardinal):Cardinal; cdecl
  function  f_BN_mul_word(a: PBIGNUM; w: Cardinal):Integer; cdecl
  function  f_BN_add_word(a: PBIGNUM; w: Cardinal):Integer; cdecl
  function  f_BN_sub_word(a: PBIGNUM; w: Cardinal):Integer; cdecl
  function  f_BN_set_word(a: PBIGNUM; w: Cardinal):Integer; cdecl
  function  f_BN_get_word(a: PBIGNUM):Cardinal; cdecl
  function  f_BN_cmp(const a: PBIGNUM; const b: PBIGNUM):Integer; cdecl
  procedure f_BN_free(a: PBIGNUM); cdecl;
  function  f_BN_is_bit_set(const a: PBIGNUM; n: Integer):Integer; cdecl
  function  f_BN_lshift(r: PBIGNUM; const a: PBIGNUM; n: Integer):Integer; cdecl
  function  f_BN_lshift1(r: PBIGNUM; a: PBIGNUM):Integer; cdecl
  function  f_BN_exp(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_mod_exp(r: PBIGNUM; a: PBIGNUM; const p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_mod_exp_mont(r: PBIGNUM; a: PBIGNUM; const p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX):Integer; cdecl
  function  f_BN_mod_exp2_mont(r: PBIGNUM; a1: PBIGNUM; p1: PBIGNUM; a2: PBIGNUM; p2: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX):Integer; cdecl
  function  f_BN_mod_exp_simple(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_mask_bits(a: PBIGNUM; n: Integer):Integer; cdecl
  function  f_BN_mod_mul(ret: PBIGNUM; a: PBIGNUM; b: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_print_fp(fp: PFILE; a: PBIGNUM):Integer; cdecl
  function  f_BN_print(fp: PBIO; const a: PBIGNUM):Integer; cdecl
  function  f_BN_reciprocal(r: PBIGNUM; m: PBIGNUM; len: Integer; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_rshift(r: PBIGNUM; a: PBIGNUM; n: Integer):Integer; cdecl
  function  f_BN_rshift1(r: PBIGNUM; a: PBIGNUM):Integer; cdecl
  procedure f_BN_clear(a: PBIGNUM); cdecl;
  function  f_bn_expand2(b: PBIGNUM; bits: Integer):PBIGNUM; cdecl
  function  f_BN_dup(const a: PBIGNUM):PBIGNUM; cdecl
  function  f_BN_ucmp(const a: PBIGNUM; const b: PBIGNUM):Integer; cdecl
  function  f_BN_set_bit(a: PBIGNUM; n: Integer):Integer; cdecl
  function  f_BN_clear_bit(a: PBIGNUM; n: Integer):Integer; cdecl
  function  f_BN_bn2hex(const a: PBIGNUM):PChar; cdecl
  function  f_BN_bn2dec(const a: PBIGNUM):PChar; cdecl
  function  f_BN_hex2bn(a: PPBIGNUM; const str: PChar):Integer; cdecl
  function  f_BN_dec2bn(a: PPBIGNUM; const str: PChar):Integer; cdecl
  function  f_BN_gcd(r: PBIGNUM; in_a: PBIGNUM; in_b: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_mod_inverse(ret: PBIGNUM; a: PBIGNUM; const n: PBIGNUM; ctx: PBN_CTX):PBIGNUM; cdecl
  function  f_BN_generate_prime(ret: PBIGNUM; bits: Integer; strong: Integer; add: PBIGNUM; rem: PBIGNUM; arg5: PFunction; cb_arg: Pointer):PBIGNUM; cdecl
  function  f_BN_is_prime(p: PBIGNUM; nchecks: Integer; arg2: PFunction; ctx: PBN_CTX; cb_arg: Pointer):Integer; cdecl
  procedure f_ERR_load_BN_strings; cdecl;
  function  f_bn_mul_add_words(rp: PULong; ap: PULong; num: Integer; w: Cardinal):Cardinal; cdecl
  function  f_bn_mul_words(rp: PULong; ap: PULong; num: Integer; w: Cardinal):Cardinal; cdecl
  procedure f_bn_sqr_words(rp: PULong; ap: PULong; num: Integer); cdecl;
  function  f_bn_div_words(h: Cardinal; l: Cardinal; d: Cardinal):Cardinal; cdecl
  function  f_bn_add_words(rp: PULong; ap: PULong; bp: PULong; num: Integer):Cardinal; cdecl
  function  f_bn_sub_words(rp: PULong; ap: PULong; bp: PULong; num: Integer):Cardinal; cdecl
  function  f_BN_MONT_CTX_new:PBN_MONT_CTX; cdecl
  procedure f_BN_MONT_CTX_init(ctx: PBN_MONT_CTX); cdecl;
  function  f_BN_mod_mul_montgomery(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_from_montgomery(r: PBIGNUM; a: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX):Integer; cdecl
  procedure f_BN_MONT_CTX_free(mont: PBN_MONT_CTX); cdecl;
  function  f_BN_MONT_CTX_set(mont: PBN_MONT_CTX; const modulus: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_MONT_CTX_copy(_to: PBN_MONT_CTX; from: PBN_MONT_CTX):PBN_MONT_CTX; cdecl
  function  f_BN_BLINDING_new(A: PBIGNUM; Ai: PBIGNUM; _mod: PBIGNUM):PBN_BLINDING; cdecl
  procedure f_BN_BLINDING_free(b: PBN_BLINDING); cdecl;
  function  f_BN_BLINDING_update(b: PBN_BLINDING; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_BLINDING_convert(n: PBIGNUM; r: PBN_BLINDING; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_BLINDING_invert(n: PBIGNUM; b: PBN_BLINDING; ctx: PBN_CTX):Integer; cdecl
  procedure f_BN_set_params(mul: Integer; high: Integer; low: Integer; mont: Integer); cdecl;
  function  f_BN_get_params(which: Integer):Integer; cdecl
  procedure f_BN_RECP_CTX_init(recp: PBN_RECP_CTX); cdecl;
  function  f_BN_RECP_CTX_new:PBN_RECP_CTX; cdecl
  procedure f_BN_RECP_CTX_free(recp: PBN_RECP_CTX); cdecl;
  function  f_BN_RECP_CTX_set(recp: PBN_RECP_CTX; const rdiv: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_mod_mul_reciprocal(r: PBIGNUM; x: PBIGNUM; y: PBIGNUM; recp: PBN_RECP_CTX; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_mod_exp_recp(r: PBIGNUM; const a: PBIGNUM; const p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX):Integer; cdecl
  function  f_BN_div_recp(dv: PBIGNUM; rem: PBIGNUM; m: PBIGNUM; recp: PBN_RECP_CTX; ctx: PBN_CTX):Integer; cdecl
  function  f_RSA_new:PRSA; cdecl
  function  f_RSA_new_method(method: PRSA_METHOD):PRSA; cdecl
  function  f_RSA_size(arg0: PRSA):Integer; cdecl
  function  f_RSA_generate_key(bits: Integer; e: Cardinal; arg2: PFunction; cb_arg: Pointer):PRSA; cdecl
  function  f_RSA_check_key(arg0: PRSA):Integer; cdecl
  function  f_RSA_public_encrypt(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer; cdecl
  function  f_RSA_private_encrypt(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer; cdecl
  function  f_RSA_public_decrypt(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer; cdecl
  function  f_RSA_private_decrypt(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer; cdecl
  procedure f_RSA_free(r: PRSA); cdecl;
  function  f_RSA_flags(r: PRSA):Integer; cdecl
  procedure f_RSA_set_default_method(meth: PRSA_METHOD); cdecl;
  function  f_RSA_get_default_method:PRSA_METHOD; cdecl
  function  f_RSA_get_method(rsa: PRSA):PRSA_METHOD; cdecl
  function  f_RSA_set_method(rsa: PRSA; meth: PRSA_METHOD):PRSA_METHOD; cdecl
  function  f_RSA_memory_lock(r: PRSA):Integer; cdecl
  function  f_RSA_PKCS1_SSLeay:PRSA_METHOD; cdecl
  procedure f_ERR_load_RSA_strings; cdecl;
  function  f_d2i_RSAPublicKey(a: PPRSA; pp: PPChar; length: Longint):PRSA; cdecl
  function  f_i2d_RSAPublicKey(a: PRSA; pp: PPChar):Integer; cdecl
  function  f_d2i_RSAPrivateKey(a: PPRSA; pp: PPChar; length: Longint):PRSA; cdecl
  function  f_i2d_RSAPrivateKey(a: PRSA; pp: PPChar):Integer; cdecl
  function  f_RSA_print_fp(fp: PFILE; r: PRSA; offset: Integer):Integer; cdecl
  function  f_RSA_print(bp: PBIO; r: PRSA; offset: Integer):Integer; cdecl
  function  f_i2d_Netscape_RSA(a: PRSA; pp: PPChar; arg2: PFunction):Integer; cdecl
  function  f_d2i_Netscape_RSA(a: PPRSA; pp: PPChar; length: Longint; arg3: PFunction):PRSA; cdecl
  function  f_d2i_Netscape_RSA_2(a: PPRSA; pp: PPChar; length: Longint; arg3: PFunction):PRSA; cdecl
  function  f_RSA_sign(_type: Integer; m: PChar; m_len: UInteger; sigret: PChar; siglen: PUInteger; rsa: PRSA):Integer; cdecl
  function  f_RSA_verify(_type: Integer; m: PChar; m_len: UInteger; sigbuf: PChar; siglen: UInteger; rsa: PRSA):Integer; cdecl
  function  f_RSA_sign_ASN1_OCTET_STRING(_type: Integer; m: PChar; m_len: UInteger; sigret: PChar; siglen: PUInteger; rsa: PRSA):Integer; cdecl
  function  f_RSA_verify_ASN1_OCTET_STRING(_type: Integer; m: PChar; m_len: UInteger; sigbuf: PChar; siglen: UInteger; rsa: PRSA):Integer; cdecl
  function  f_RSA_blinding_on(rsa: PRSA; ctx: PBN_CTX):Integer; cdecl
  procedure f_RSA_blinding_off(rsa: PRSA); cdecl;
  function  f_RSA_padding_add_PKCS1_type_1(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer; cdecl
  function  f_RSA_padding_check_PKCS1_type_1(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer; cdecl
  function  f_RSA_padding_add_PKCS1_type_2(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer; cdecl
  function  f_RSA_padding_check_PKCS1_type_2(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer; cdecl
  function  f_RSA_padding_add_PKCS1_OAEP(_to: PChar; tlen: Integer; f: PChar; fl: Integer; p: PChar; pl: Integer):Integer; cdecl
  function  f_RSA_padding_check_PKCS1_OAEP(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer; p: PChar; pl: Integer):Integer; cdecl
  function  f_RSA_padding_add_SSLv23(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer; cdecl
  function  f_RSA_padding_check_SSLv23(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer; cdecl
  function  f_RSA_padding_add_none(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer; cdecl
  function  f_RSA_padding_check_none(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer; cdecl
  function  f_RSA_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; cdecl
  function  f_RSA_set_ex_data(r: PRSA; idx: Integer; arg: PChar):Integer; cdecl
  function  f_RSA_get_ex_data(r: PRSA; idx: Integer):PChar; cdecl
  function  f_DH_new:PDH; cdecl
  procedure f_DH_free(dh: PDH); cdecl;
  function  f_DH_size(dh: PDH):Integer; cdecl
  function  f_DH_generate_parameters(prime_len: Integer; generator: Integer; arg2: PFunction; cb_arg: Pointer):PDH; cdecl
  function  f_DH_check(dh: PDH; codes: PInteger):Integer; cdecl
  function  f_DH_generate_key(dh: PDH):Integer; cdecl
  function  f_DH_compute_key(key: PChar; pub_key: PBIGNUM; dh: PDH):Integer; cdecl
  function  f_d2i_DHparams(a: PPDH; pp: PPChar; length: Longint):PDH; cdecl
  function  f_i2d_DHparams(a: PDH; pp: PPChar):Integer; cdecl
  function  f_DHparams_print_fp(fp: PFILE; x: PDH):Integer; cdecl
  function  f_DHparams_print(bp: PBIO; x: PDH):Integer; cdecl
  procedure f_ERR_load_DH_strings; cdecl;
  function  f_DSA_SIG_new:PDSA_SIG; cdecl
  procedure f_DSA_SIG_free(a: PDSA_SIG); cdecl;
  function  f_i2d_DSA_SIG(a: PDSA_SIG; pp: PPChar):Integer; cdecl
  function  f_d2i_DSA_SIG(v: PPDSA_SIG; pp: PPChar; length: Longint):PDSA_SIG; cdecl
  function  f_DSA_do_sign(const dgst: PChar; dlen: Integer; dsa: PDSA):PDSA_SIG; cdecl
  function  f_DSA_do_verify(const dgst: PChar; dgst_len: Integer; sig: PDSA_SIG; dsa: PDSA):Integer; cdecl
  function  f_DSA_new:PDSA; cdecl
  function  f_DSA_size(arg0: PDSA):Integer; cdecl
  function  f_DSA_sign_setup(dsa: PDSA; ctx_in: PBN_CTX; kinvp: PPBIGNUM; rp: PPBIGNUM):Integer; cdecl
  function  f_DSA_sign(_type: Integer; const dgst: PChar; dlen: Integer; sig: PChar; siglen: PUInteger; dsa: PDSA):Integer; cdecl
  function  f_DSA_verify(_type: Integer; const dgst: PChar; dgst_len: Integer; sigbuf: PChar; siglen: Integer; dsa: PDSA):Integer; cdecl
  procedure f_DSA_free(r: PDSA); cdecl;
  procedure f_ERR_load_DSA_strings; cdecl;
  function  f_d2i_DSAPublicKey(a: PPDSA; pp: PPChar; length: Longint):PDSA; cdecl
  function  f_d2i_DSAPrivateKey(a: PPDSA; pp: PPChar; length: Longint):PDSA; cdecl
  function  f_d2i_DSAparams(a: PPDSA; pp: PPChar; length: Longint):PDSA; cdecl
  function  f_DSA_generate_parameters(bits: Integer; seed: PChar; seed_len: Integer; counter_ret: PInteger; h_ret: PULong; arg5: PFunction; cb_arg: PChar):PDSA; cdecl
  function  f_DSA_generate_key(a: PDSA):Integer; cdecl
  function  f_i2d_DSAPublicKey(a: PDSA; pp: PPChar):Integer; cdecl
  function  f_i2d_DSAPrivateKey(a: PDSA; pp: PPChar):Integer; cdecl
  function  f_i2d_DSAparams(a: PDSA; pp: PPChar):Integer; cdecl
  function  f_DSAparams_print(bp: PBIO; x: PDSA):Integer; cdecl
  function  f_DSA_print(bp: PBIO; x: PDSA; off: Integer):Integer; cdecl
  function  f_DSAparams_print_fp(fp: PFILE; x: PDSA):Integer; cdecl
  function  f_DSA_print_fp(bp: PFILE; x: PDSA; off: Integer):Integer; cdecl
  function  f_DSA_is_prime(q: PBIGNUM; arg1: PFunction; cb_arg: PChar):Integer; cdecl
  function  f_DSA_dup_DH(r: PDSA):PDH; cdecl
  function  f_sk_ASN1_TYPE_new(arg0: PFunction):PSTACK_ASN1_TYPE; cdecl
  function  f_sk_ASN1_TYPE_new_null:PSTACK_ASN1_TYPE; cdecl
  procedure f_sk_ASN1_TYPE_free(sk: PSTACK_ASN1_TYPE); cdecl;
  function  f_sk_ASN1_TYPE_num(const sk: PSTACK_ASN1_TYPE):Integer; cdecl
  function  f_sk_ASN1_TYPE_value(const sk: PSTACK_ASN1_TYPE; n: Integer):PASN1_TYPE; cdecl
  function  f_sk_ASN1_TYPE_set(sk: PSTACK_ASN1_TYPE; n: Integer; v: PASN1_TYPE):PASN1_TYPE; cdecl
  procedure f_sk_ASN1_TYPE_zero(sk: PSTACK_ASN1_TYPE); cdecl;
  function  f_sk_ASN1_TYPE_push(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE):Integer; cdecl
  function  f_sk_ASN1_TYPE_unshift(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE):Integer; cdecl
  function  f_sk_ASN1_TYPE_find(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE):Integer; cdecl
  function  f_sk_ASN1_TYPE_delete(sk: PSTACK_ASN1_TYPE; n: Integer):PASN1_TYPE; cdecl
  procedure f_sk_ASN1_TYPE_delete_ptr(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE); cdecl;
  function  f_sk_ASN1_TYPE_insert(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE; n: Integer):Integer; cdecl
  function  f_sk_ASN1_TYPE_dup(sk: PSTACK_ASN1_TYPE):PSTACK_ASN1_TYPE; cdecl
  procedure f_sk_ASN1_TYPE_pop_free(sk: PSTACK_ASN1_TYPE; arg1: PFunction); cdecl;
  function  f_sk_ASN1_TYPE_shift(sk: PSTACK_ASN1_TYPE):PASN1_TYPE; cdecl
  function  f_sk_ASN1_TYPE_pop(sk: PSTACK_ASN1_TYPE):PASN1_TYPE; cdecl
  procedure f_sk_ASN1_TYPE_sort(sk: PSTACK_ASN1_TYPE); cdecl;
  function  f_i2d_ASN1_SET_OF_ASN1_TYPE(a: PSTACK_ASN1_TYPE; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET_OF_ASN1_TYPE(a: PPSTACK_ASN1_TYPE; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_ASN1_TYPE; cdecl
  function  f_ASN1_TYPE_new:PASN1_TYPE; cdecl
  procedure f_ASN1_TYPE_free(a: PASN1_TYPE); cdecl;
  function  f_i2d_ASN1_TYPE(a: PASN1_TYPE; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_TYPE(a: PPASN1_TYPE; pp: PPChar; length: Longint):PASN1_TYPE; cdecl
  function  f_ASN1_TYPE_get(a: PASN1_TYPE):Integer; cdecl
  procedure f_ASN1_TYPE_set(a: PASN1_TYPE; _type: Integer; value: Pointer); cdecl;
  function  f_ASN1_OBJECT_new:PASN1_OBJECT; cdecl
  procedure f_ASN1_OBJECT_free(a: PASN1_OBJECT); cdecl;
  function  f_i2d_ASN1_OBJECT(a: PASN1_OBJECT; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_OBJECT(a: PPASN1_OBJECT; pp: PPChar; length: Longint):PASN1_OBJECT; cdecl
  function  f_sk_ASN1_OBJECT_new(arg0: PFunction):PSTACK_ASN1_OBJECT; cdecl
  function  f_sk_ASN1_OBJECT_new_null:PSTACK_ASN1_OBJECT; cdecl
  procedure f_sk_ASN1_OBJECT_free(sk: PSTACK_ASN1_OBJECT); cdecl;
  function  f_sk_ASN1_OBJECT_num(const sk: PSTACK_ASN1_OBJECT):Integer; cdecl
  function  f_sk_ASN1_OBJECT_value(const sk: PSTACK_ASN1_OBJECT; n: Integer):PASN1_OBJECT; cdecl
  function  f_sk_ASN1_OBJECT_set(sk: PSTACK_ASN1_OBJECT; n: Integer; v: PASN1_OBJECT):PASN1_OBJECT; cdecl
  procedure f_sk_ASN1_OBJECT_zero(sk: PSTACK_ASN1_OBJECT); cdecl;
  function  f_sk_ASN1_OBJECT_push(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT):Integer; cdecl
  function  f_sk_ASN1_OBJECT_unshift(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT):Integer; cdecl
  function  f_sk_ASN1_OBJECT_find(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT):Integer; cdecl
  function  f_sk_ASN1_OBJECT_delete(sk: PSTACK_ASN1_OBJECT; n: Integer):PASN1_OBJECT; cdecl
  procedure f_sk_ASN1_OBJECT_delete_ptr(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT); cdecl;
  function  f_sk_ASN1_OBJECT_insert(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT; n: Integer):Integer; cdecl
  function  f_sk_ASN1_OBJECT_dup(sk: PSTACK_ASN1_OBJECT):PSTACK_ASN1_OBJECT; cdecl
  procedure f_sk_ASN1_OBJECT_pop_free(sk: PSTACK_ASN1_OBJECT; arg1: PFunction); cdecl;
  function  f_sk_ASN1_OBJECT_shift(sk: PSTACK_ASN1_OBJECT):PASN1_OBJECT; cdecl
  function  f_sk_ASN1_OBJECT_pop(sk: PSTACK_ASN1_OBJECT):PASN1_OBJECT; cdecl
  procedure f_sk_ASN1_OBJECT_sort(sk: PSTACK_ASN1_OBJECT); cdecl;
  function  f_i2d_ASN1_SET_OF_ASN1_OBJECT(a: PSTACK_ASN1_OBJECT; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET_OF_ASN1_OBJECT(a: PPSTACK_ASN1_OBJECT; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_ASN1_OBJECT; cdecl
  function  f_ASN1_STRING_new:PASN1_STRING; cdecl
  procedure f_ASN1_STRING_free(a: PASN1_STRING); cdecl;
  function  f_ASN1_STRING_dup(a: PASN1_STRING):PASN1_STRING; cdecl
  function  f_ASN1_STRING_type_new(_type: Integer):PASN1_STRING; cdecl
  function  f_ASN1_STRING_cmp(a: PASN1_STRING; b: PASN1_STRING):Integer; cdecl
  function  f_ASN1_STRING_set(str: PASN1_STRING; const data: Pointer; len: Integer):Integer; cdecl
  function  f_i2d_ASN1_BIT_STRING(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_BIT_STRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_ASN1_BIT_STRING_set_bit(a: PASN1_STRING; n: Integer; value: Integer):Integer; cdecl
  function  f_ASN1_BIT_STRING_get_bit(a: PASN1_STRING; n: Integer):Integer; cdecl
  function  f_i2d_ASN1_BOOLEAN(a: Integer; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_BOOLEAN(a: PInteger; pp: PPChar; length: Longint):Integer; cdecl
  function  f_i2d_ASN1_INTEGER(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_INTEGER(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_d2i_ASN1_UINTEGER(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_i2d_ASN1_ENUMERATED(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_ENUMERATED(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_ASN1_UTCTIME_check(a: PASN1_STRING):Integer; cdecl
  function  f_ASN1_UTCTIME_set(s: PASN1_STRING; t: time_t):PASN1_STRING; cdecl
  function  f_ASN1_UTCTIME_set_string(s: PASN1_STRING; str: PChar):Integer; cdecl
  function  f_ASN1_GENERALIZEDTIME_check(a: PASN1_STRING):Integer; cdecl
  function  f_ASN1_GENERALIZEDTIME_set(s: PASN1_STRING; t: time_t):PASN1_STRING; cdecl
  function  f_ASN1_GENERALIZEDTIME_set_string(s: PASN1_STRING; str: PChar):Integer; cdecl
  function  f_i2d_ASN1_OCTET_STRING(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_OCTET_STRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_i2d_ASN1_VISIBLESTRING(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_VISIBLESTRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_i2d_ASN1_UTF8STRING(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_UTF8STRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_i2d_ASN1_BMPSTRING(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_BMPSTRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_i2d_ASN1_PRINTABLE(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_PRINTABLE(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING; cdecl
  function  f_d2i_ASN1_PRINTABLESTRING(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING; cdecl
  function  f_i2d_DIRECTORYSTRING(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_DIRECTORYSTRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_i2d_DISPLAYTEXT(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_DISPLAYTEXT(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_d2i_ASN1_T61STRING(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING; cdecl
  function  f_i2d_ASN1_IA5STRING(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_IA5STRING(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING; cdecl
  function  f_i2d_ASN1_UTCTIME(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_UTCTIME(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_i2d_ASN1_GENERALIZEDTIME(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_GENERALIZEDTIME(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_i2d_ASN1_TIME(a: PASN1_STRING; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_TIME(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; cdecl
  function  f_ASN1_TIME_set(s: PASN1_STRING; t: time_t):PASN1_STRING; cdecl
  function  f_i2d_ASN1_SET(a: PSTACK; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET(a: PPSTACK; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK; cdecl
  function  f_i2a_ASN1_INTEGER(bp: PBIO; a: PASN1_STRING):Integer; cdecl
  function  f_a2i_ASN1_INTEGER(bp: PBIO; bs: PASN1_STRING; buf: PChar; size: Integer):Integer; cdecl
  function  f_i2a_ASN1_ENUMERATED(bp: PBIO; a: PASN1_STRING):Integer; cdecl
  function  f_a2i_ASN1_ENUMERATED(bp: PBIO; bs: PASN1_STRING; buf: PChar; size: Integer):Integer; cdecl
  function  f_i2a_ASN1_OBJECT(bp: PBIO; a: PASN1_OBJECT):Integer; cdecl
  function  f_a2i_ASN1_STRING(bp: PBIO; bs: PASN1_STRING; buf: PChar; size: Integer):Integer; cdecl
  function  f_i2a_ASN1_STRING(bp: PBIO; a: PASN1_STRING; _type: Integer):Integer; cdecl
  function  f_i2t_ASN1_OBJECT(buf: PChar; buf_len: Integer; a: PASN1_OBJECT):Integer; cdecl
  function  f_a2d_ASN1_OBJECT(_out: PChar; olen: Integer; const buf: PChar; num: Integer):Integer; cdecl
  function  f_ASN1_OBJECT_create(nid: Integer; data: PChar; len: Integer; sn: PChar; ln: PChar):PASN1_OBJECT; cdecl
  function  f_ASN1_INTEGER_set(a: PASN1_STRING; v: Longint):Integer; cdecl
  function  f_ASN1_INTEGER_get(a: PASN1_STRING):Longint; cdecl
  function  f_BN_to_ASN1_INTEGER(bn: PBIGNUM; ai: PASN1_STRING):PASN1_STRING; cdecl
  function  f_ASN1_INTEGER_to_BN(ai: PASN1_STRING; bn: PBIGNUM):PBIGNUM; cdecl
  function  f_ASN1_ENUMERATED_set(a: PASN1_STRING; v: Longint):Integer; cdecl
  function  f_ASN1_ENUMERATED_get(a: PASN1_STRING):Longint; cdecl
  function  f_BN_to_ASN1_ENUMERATED(bn: PBIGNUM; ai: PASN1_STRING):PASN1_STRING; cdecl
  function  f_ASN1_ENUMERATED_to_BN(ai: PASN1_STRING; bn: PBIGNUM):PBIGNUM; cdecl
  function  f_ASN1_PRINTABLE_type(s: PChar; max: Integer):Integer; cdecl
  function  f_i2d_ASN1_bytes(a: PASN1_STRING; pp: PPChar; tag: Integer; xclass: Integer):Integer; cdecl
  function  f_d2i_ASN1_bytes(a: PPASN1_STRING; pp: PPChar; length: Longint; Ptag: Integer; Pclass: Integer):PASN1_STRING; cdecl
  function  f_d2i_ASN1_type_bytes(a: PPASN1_STRING; pp: PPChar; length: Longint; _type: Integer):PASN1_STRING; cdecl
  function  f_asn1_Finish(c: PASN1_CTX):Integer; cdecl
  function  f_ASN1_get_object(pp: PPChar; plength: PLong; ptag: PInteger; pclass: PInteger; omax: Longint):Integer; cdecl
  function  f_ASN1_check_infinite_end(p: PPChar; len: Longint):Integer; cdecl
  procedure f_ASN1_put_object(pp: PPChar; constructed: Integer; length: Integer; tag: Integer; xclass: Integer); cdecl;
  function  f_ASN1_object_size(constructed: Integer; length: Integer; tag: Integer):Integer; cdecl
  function  f_ASN1_dup(arg0: PFunction; arg1: PFunction; x: PChar):PChar; cdecl
  function  f_ASN1_d2i_fp(arg0: PFunction; arg1: PFunction; fp: PFILE; x: PPChar):PChar; cdecl
  function  f_ASN1_i2d_fp(arg0: PFunction; _out: PFILE; x: PChar):Integer; cdecl
  function  f_ASN1_d2i_bio(arg0: PFunction; arg1: PFunction; bp: PBIO; x: PPChar):PChar; cdecl
  function  f_ASN1_i2d_bio(arg0: PFunction; _out: PBIO; x: PChar):Integer; cdecl
  function  f_ASN1_UTCTIME_print(fp: PBIO; a: PASN1_STRING):Integer; cdecl
  function  f_ASN1_GENERALIZEDTIME_print(fp: PBIO; a: PASN1_STRING):Integer; cdecl
  function  f_ASN1_TIME_print(fp: PBIO; a: PASN1_STRING):Integer; cdecl
  function  f_ASN1_STRING_print(bp: PBIO; v: PASN1_STRING):Integer; cdecl
  function  f_ASN1_parse(bp: PBIO; pp: PChar; len: Longint; indent: Integer):Integer; cdecl
  function  f_i2d_ASN1_HEADER(a: PASN1_HEADER; pp: PPChar):Integer; cdecl
  function  f_d2i_ASN1_HEADER(a: PPASN1_HEADER; pp: PPChar; length: Longint):PASN1_HEADER; cdecl
  function  f_ASN1_HEADER_new:PASN1_HEADER; cdecl
  procedure f_ASN1_HEADER_free(a: PASN1_HEADER); cdecl;
  function  f_ASN1_UNIVERSALSTRING_to_string(s: PASN1_STRING):Integer; cdecl
  procedure f_ERR_load_ASN1_strings; cdecl;
  function  f_X509_asn1_meth:PASN1_METHOD; cdecl
  function  f_RSAPrivateKey_asn1_meth:PASN1_METHOD; cdecl
  function  f_ASN1_IA5STRING_asn1_meth:PASN1_METHOD; cdecl
  function  f_ASN1_BIT_STRING_asn1_meth:PASN1_METHOD; cdecl
  function  f_ASN1_TYPE_set_octetstring(a: PASN1_TYPE; data: PChar; len: Integer):Integer; cdecl
  function  f_ASN1_TYPE_get_octetstring(a: PASN1_TYPE; data: PChar; max_len: Integer):Integer; cdecl
  function  f_ASN1_TYPE_set_int_octetstring(a: PASN1_TYPE; num: Longint; data: PChar; len: Integer):Integer; cdecl
  function  f_ASN1_TYPE_get_int_octetstring(a: PASN1_TYPE; num: PLong; data: PChar; max_len: Integer):Integer; cdecl
  function  f_ASN1_seq_unpack(buf: PChar; len: Integer; arg2: PFunction; arg3: PFunction):PSTACK; cdecl
  function  f_ASN1_seq_pack(safes: PSTACK; arg1: PFunction; buf: PPChar; len: PInteger):PChar; cdecl
  function  f_ASN1_unpack_string(oct: PASN1_STRING; arg1: PFunction):Pointer; cdecl
  function  f_ASN1_pack_string(obj: Pointer; arg1: PFunction; oct: PPASN1_STRING):PASN1_STRING; cdecl
  function  f_OBJ_NAME_init:Integer; cdecl
  function  f_OBJ_NAME_new_index(arg0: PFunction; arg1: PFunction; arg2: PFunction):Integer; cdecl
  function  f_OBJ_NAME_get(const name: PChar; _type: Integer):PChar; cdecl
  function  f_OBJ_NAME_add(const name: PChar; _type: Integer; const data: PChar):Integer; cdecl
  function  f_OBJ_NAME_remove(const name: PChar; _type: Integer):Integer; cdecl
  procedure f_OBJ_NAME_cleanup(_type: Integer); cdecl;
  function  f_OBJ_dup(o: PASN1_OBJECT):PASN1_OBJECT; cdecl
  function  f_OBJ_nid2obj(n: Integer):PASN1_OBJECT; cdecl
  function  f_OBJ_nid2ln(n: Integer):PChar; cdecl
  function  f_OBJ_nid2sn(n: Integer):PChar; cdecl
  function  f_OBJ_obj2nid(o: PASN1_OBJECT):Integer; cdecl
  function  f_OBJ_txt2obj(const s: PChar; no_name: Integer):PASN1_OBJECT; cdecl
  function  f_OBJ_obj2txt(buf: PChar; buf_len: Integer; a: PASN1_OBJECT; no_name: Integer):Integer; cdecl
  function  f_OBJ_txt2nid(s: PChar):Integer; cdecl
  function  f_OBJ_ln2nid(const s: PChar):Integer; cdecl
  function  f_OBJ_sn2nid(const s: PChar):Integer; cdecl
  function  f_OBJ_cmp(a: PASN1_OBJECT; b: PASN1_OBJECT):Integer; cdecl
  function  f_OBJ_bsearch(key: PChar; base: PChar; num: Integer; size: Integer; arg4: PFunction):PChar; cdecl
  procedure f_ERR_load_OBJ_strings; cdecl;
  function  f_OBJ_new_nid(num: Integer):Integer; cdecl
  function  f_OBJ_add_object(obj: PASN1_OBJECT):Integer; cdecl
  function  f_OBJ_create(oid: PChar; sn: PChar; ln: PChar):Integer; cdecl
  procedure f_OBJ_cleanup; cdecl;
  function  f_OBJ_create_objects(_in: PBIO):Integer; cdecl
  function  f_EVP_MD_CTX_copy(_out: PEVP_MD_CTX; _in: PEVP_MD_CTX):Integer; cdecl
  procedure f_EVP_DigestInit(ctx: PEVP_MD_CTX; const _type: PEVP_MD); cdecl;
  procedure f_EVP_DigestUpdate(ctx: PEVP_MD_CTX; const d: Pointer; cnt: UInteger); cdecl;
  procedure f_EVP_DigestFinal(ctx: PEVP_MD_CTX; md: PChar; s: PUInteger); cdecl;
  function  f_EVP_read_pw_string(buf: PChar; length: Integer; const prompt: PChar; verify: Integer):Integer; cdecl
  procedure f_EVP_set_pw_prompt(prompt: PChar); cdecl;
  function  f_EVP_get_pw_prompt:PChar; cdecl
  function  f_EVP_BytesToKey(const _type: PEVP_CIPHER; md: PEVP_MD; salt: PChar; data: PChar; datal: Integer; count: Integer; key: PChar; iv: PChar):Integer; cdecl
  procedure f_EVP_EncryptInit(ctx: PEVP_CIPHER_CTX; const _type: PEVP_CIPHER; key: PChar; iv: PChar); cdecl;
  procedure f_EVP_EncryptUpdate(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer); cdecl;
  procedure f_EVP_EncryptFinal(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger); cdecl;
  procedure f_EVP_DecryptInit(ctx: PEVP_CIPHER_CTX; const _type: PEVP_CIPHER; key: PChar; iv: PChar); cdecl;
  procedure f_EVP_DecryptUpdate(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer); cdecl;
  function  f_EVP_DecryptFinal(ctx: PEVP_CIPHER_CTX; outm: PChar; outl: PInteger):Integer; cdecl
  procedure f_EVP_CipherInit(ctx: PEVP_CIPHER_CTX; const _type: PEVP_CIPHER; key: PChar; iv: PChar; enc: Integer); cdecl;
  procedure f_EVP_CipherUpdate(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer); cdecl;
  function  f_EVP_CipherFinal(ctx: PEVP_CIPHER_CTX; outm: PChar; outl: PInteger):Integer; cdecl
  function  f_EVP_SignFinal(ctx: PEVP_MD_CTX; md: PChar; s: PUInteger; pkey: PEVP_PKEY):Integer; cdecl
  function  f_EVP_VerifyFinal(ctx: PEVP_MD_CTX; sigbuf: PChar; siglen: UInteger; pkey: PEVP_PKEY):Integer; cdecl
  function  f_EVP_OpenInit(ctx: PEVP_CIPHER_CTX; _type: PEVP_CIPHER; ek: PChar; ekl: Integer; iv: PChar; priv: PEVP_PKEY):Integer; cdecl
  function  f_EVP_OpenFinal(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger):Integer; cdecl
  function  f_EVP_SealInit(ctx: PEVP_CIPHER_CTX; _type: PEVP_CIPHER; ek: PPChar; ekl: PInteger; iv: PChar; pubk: PPEVP_PKEY; npubk: Integer):Integer; cdecl
  procedure f_EVP_SealFinal(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger); cdecl;
  procedure f_EVP_EncodeInit(ctx: PEVP_ENCODE_CTX); cdecl;
  procedure f_EVP_EncodeUpdate(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer); cdecl;
  procedure f_EVP_EncodeFinal(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger); cdecl;
  function  f_EVP_EncodeBlock(t: PChar; f: PChar; n: Integer):Integer; cdecl
  procedure f_EVP_DecodeInit(ctx: PEVP_ENCODE_CTX); cdecl;
  function  f_EVP_DecodeUpdate(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer):Integer; cdecl
  function  f_EVP_DecodeFinal(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger):Integer; cdecl
  function  f_EVP_DecodeBlock(t: PChar; f: PChar; n: Integer):Integer; cdecl
  procedure f_ERR_load_EVP_strings; cdecl;
  procedure f_EVP_CIPHER_CTX_init(a: PEVP_CIPHER_CTX); cdecl;
  procedure f_EVP_CIPHER_CTX_cleanup(a: PEVP_CIPHER_CTX); cdecl;
  function  f_BIO_f_md:PBIO_METHOD; cdecl
  function  f_BIO_f_base64:PBIO_METHOD; cdecl
  function  f_BIO_f_cipher:PBIO_METHOD; cdecl
  function  f_BIO_f_reliable:PBIO_METHOD; cdecl
  procedure f_BIO_set_cipher(b: PBIO; const c: PEVP_CIPHER; k: PChar; i: PChar; enc: Integer); cdecl;
  function  f_EVP_md_null:PEVP_MD; cdecl
  function  f_EVP_md2:PEVP_MD; cdecl
  function  f_EVP_md5:PEVP_MD; cdecl
  function  f_EVP_sha:PEVP_MD; cdecl
  function  f_EVP_sha1:PEVP_MD; cdecl
  function  f_EVP_dss:PEVP_MD; cdecl
  function  f_EVP_dss1:PEVP_MD; cdecl
  function  f_EVP_mdc2:PEVP_MD; cdecl
  function  f_EVP_ripemd160:PEVP_MD; cdecl
  function  f_EVP_enc_null:PEVP_CIPHER; cdecl
  function  f_EVP_des_ecb:PEVP_CIPHER; cdecl
  function  f_EVP_des_ede:PEVP_CIPHER; cdecl
  function  f_EVP_des_ede3:PEVP_CIPHER; cdecl
  function  f_EVP_des_cfb:PEVP_CIPHER; cdecl
  function  f_EVP_des_ede_cfb:PEVP_CIPHER; cdecl
  function  f_EVP_des_ede3_cfb:PEVP_CIPHER; cdecl
  function  f_EVP_des_ofb:PEVP_CIPHER; cdecl
  function  f_EVP_des_ede_ofb:PEVP_CIPHER; cdecl
  function  f_EVP_des_ede3_ofb:PEVP_CIPHER; cdecl
  function  f_EVP_des_cbc:PEVP_CIPHER; cdecl
  function  f_EVP_des_ede_cbc:PEVP_CIPHER; cdecl
  function  f_EVP_des_ede3_cbc:PEVP_CIPHER; cdecl
  function  f_EVP_desx_cbc:PEVP_CIPHER; cdecl
  function  f_EVP_rc4:PEVP_CIPHER; cdecl
  function  f_EVP_rc4_40:PEVP_CIPHER; cdecl
  function  f_EVP_idea_ecb:PEVP_CIPHER; cdecl
  function  f_EVP_idea_cfb:PEVP_CIPHER; cdecl
  function  f_EVP_idea_ofb:PEVP_CIPHER; cdecl
  function  f_EVP_idea_cbc:PEVP_CIPHER; cdecl
  function  f_EVP_rc2_ecb:PEVP_CIPHER; cdecl
  function  f_EVP_rc2_cbc:PEVP_CIPHER; cdecl
  function  f_EVP_rc2_40_cbc:PEVP_CIPHER; cdecl
  function  f_EVP_rc2_64_cbc:PEVP_CIPHER; cdecl
  function  f_EVP_rc2_cfb:PEVP_CIPHER; cdecl
  function  f_EVP_rc2_ofb:PEVP_CIPHER; cdecl
  function  f_EVP_bf_ecb:PEVP_CIPHER; cdecl
  function  f_EVP_bf_cbc:PEVP_CIPHER; cdecl
  function  f_EVP_bf_cfb:PEVP_CIPHER; cdecl
  function  f_EVP_bf_ofb:PEVP_CIPHER; cdecl
  function  f_EVP_cast5_ecb:PEVP_CIPHER; cdecl
  function  f_EVP_cast5_cbc:PEVP_CIPHER; cdecl
  function  f_EVP_cast5_cfb:PEVP_CIPHER; cdecl
  function  f_EVP_cast5_ofb:PEVP_CIPHER; cdecl
  function  f_EVP_rc5_32_12_16_cbc:PEVP_CIPHER; cdecl
  function  f_EVP_rc5_32_12_16_ecb:PEVP_CIPHER; cdecl
  function  f_EVP_rc5_32_12_16_cfb:PEVP_CIPHER; cdecl
  function  f_EVP_rc5_32_12_16_ofb:PEVP_CIPHER; cdecl
  procedure f_SSLeay_add_all_algorithms; cdecl;
  procedure f_SSLeay_add_all_ciphers; cdecl;
  procedure f_SSLeay_add_all_digests; cdecl;
  function  f_EVP_add_cipher(cipher: PEVP_CIPHER):Integer; cdecl
  function  f_EVP_add_digest(digest: PEVP_MD):Integer; cdecl
  function  f_EVP_get_cipherbyname(const name: PChar):PEVP_CIPHER; cdecl
  function  f_EVP_get_digestbyname(const name: PChar):PEVP_MD; cdecl
  procedure f_EVP_cleanup; cdecl;
  function  f_EVP_PKEY_decrypt(dec_key: PChar; enc_key: PChar; enc_key_len: Integer; private_key: PEVP_PKEY):Integer; cdecl
  function  f_EVP_PKEY_encrypt(enc_key: PChar; key: PChar; key_len: Integer; pub_key: PEVP_PKEY):Integer; cdecl
  function  f_EVP_PKEY_type(_type: Integer):Integer; cdecl
  function  f_EVP_PKEY_bits(pkey: PEVP_PKEY):Integer; cdecl
  function  f_EVP_PKEY_size(pkey: PEVP_PKEY):Integer; cdecl
  function  f_EVP_PKEY_assign(pkey: PEVP_PKEY; _type: Integer; key: PChar):Integer; cdecl
  function  f_EVP_PKEY_new:PEVP_PKEY; cdecl
  procedure f_EVP_PKEY_free(pkey: PEVP_PKEY); cdecl;
  function  f_d2i_PublicKey(_type: Integer; a: PPEVP_PKEY; pp: PPChar; length: Longint):PEVP_PKEY; cdecl
  function  f_i2d_PublicKey(a: PEVP_PKEY; pp: PPChar):Integer; cdecl
  function  f_d2i_PrivateKey(_type: Integer; a: PPEVP_PKEY; pp: PPChar; length: Longint):PEVP_PKEY; cdecl
  function  f_i2d_PrivateKey(a: PEVP_PKEY; pp: PPChar):Integer; cdecl
  function  f_EVP_PKEY_copy_parameters(_to: PEVP_PKEY; from: PEVP_PKEY):Integer; cdecl
  function  f_EVP_PKEY_missing_parameters(pkey: PEVP_PKEY):Integer; cdecl
  function  f_EVP_PKEY_save_parameters(pkey: PEVP_PKEY; mode: Integer):Integer; cdecl
  function  f_EVP_PKEY_cmp_parameters(a: PEVP_PKEY; b: PEVP_PKEY):Integer; cdecl
  function  f_EVP_CIPHER_type(const ctx: PEVP_CIPHER):Integer; cdecl
  function  f_EVP_CIPHER_param_to_asn1(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer; cdecl
  function  f_EVP_CIPHER_asn1_to_param(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer; cdecl
  function  f_EVP_CIPHER_set_asn1_iv(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer; cdecl
  function  f_EVP_CIPHER_get_asn1_iv(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer; cdecl
  function  f_PKCS5_PBE_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PChar; passlen: Integer; param: PASN1_TYPE; cipher: PEVP_CIPHER; md: PEVP_MD; en_de: Integer):Integer; cdecl
  function  f_PKCS5_PBKDF2_HMAC_SHA1(const pass: PChar; passlen: Integer; salt: PChar; saltlen: Integer; iter: Integer; keylen: Integer; _out: PChar):Integer; cdecl
  function  f_PKCS5_v2_PBE_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PChar; passlen: Integer; param: PASN1_TYPE; cipher: PEVP_CIPHER; md: PEVP_MD; en_de: Integer):Integer; cdecl
  procedure f_PKCS5_PBE_add; cdecl;
  function  f_EVP_PBE_CipherInit(pbe_obj: PASN1_OBJECT; const pass: PChar; passlen: Integer; param: PASN1_TYPE; ctx: PEVP_CIPHER_CTX; en_de: Integer):Integer; cdecl
  function  f_EVP_PBE_alg_add(nid: Integer; cipher: PEVP_CIPHER; md: PEVP_MD; keygen: PEVP_PBE_KEYGEN):Integer; cdecl
  procedure f_EVP_PBE_cleanup; cdecl;
  function  f_sk_X509_ALGOR_new(arg0: PFunction):PSTACK_X509_ALGOR; cdecl
  function  f_sk_X509_ALGOR_new_null:PSTACK_X509_ALGOR; cdecl
  procedure f_sk_X509_ALGOR_free(sk: PSTACK_X509_ALGOR); cdecl;
  function  f_sk_X509_ALGOR_num(const sk: PSTACK_X509_ALGOR):Integer; cdecl
  function  f_sk_X509_ALGOR_value(const sk: PSTACK_X509_ALGOR; n: Integer):PX509_ALGOR; cdecl
  function  f_sk_X509_ALGOR_set(sk: PSTACK_X509_ALGOR; n: Integer; v: PX509_ALGOR):PX509_ALGOR; cdecl
  procedure f_sk_X509_ALGOR_zero(sk: PSTACK_X509_ALGOR); cdecl;
  function  f_sk_X509_ALGOR_push(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR):Integer; cdecl
  function  f_sk_X509_ALGOR_unshift(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR):Integer; cdecl
  function  f_sk_X509_ALGOR_find(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR):Integer; cdecl
  function  f_sk_X509_ALGOR_delete(sk: PSTACK_X509_ALGOR; n: Integer):PX509_ALGOR; cdecl
  procedure f_sk_X509_ALGOR_delete_ptr(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR); cdecl;
  function  f_sk_X509_ALGOR_insert(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR; n: Integer):Integer; cdecl
  function  f_sk_X509_ALGOR_dup(sk: PSTACK_X509_ALGOR):PSTACK_X509_ALGOR; cdecl
  procedure f_sk_X509_ALGOR_pop_free(sk: PSTACK_X509_ALGOR; arg1: PFunction); cdecl;
  function  f_sk_X509_ALGOR_shift(sk: PSTACK_X509_ALGOR):PX509_ALGOR; cdecl
  function  f_sk_X509_ALGOR_pop(sk: PSTACK_X509_ALGOR):PX509_ALGOR; cdecl
  procedure f_sk_X509_ALGOR_sort(sk: PSTACK_X509_ALGOR); cdecl;
  function  f_i2d_ASN1_SET_OF_X509_ALGOR(a: PSTACK_X509_ALGOR; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET_OF_X509_ALGOR(a: PPSTACK_X509_ALGOR; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_ALGOR; cdecl
  function  f_sk_X509_NAME_ENTRY_new(arg0: PFunction):PSTACK_X509_NAME_ENTRY; cdecl
  function  f_sk_X509_NAME_ENTRY_new_null:PSTACK_X509_NAME_ENTRY; cdecl
  procedure f_sk_X509_NAME_ENTRY_free(sk: PSTACK_X509_NAME_ENTRY); cdecl;
  function  f_sk_X509_NAME_ENTRY_num(const sk: PSTACK_X509_NAME_ENTRY):Integer; cdecl
  function  f_sk_X509_NAME_ENTRY_value(const sk: PSTACK_X509_NAME_ENTRY; n: Integer):PX509_NAME_ENTRY; cdecl
  function  f_sk_X509_NAME_ENTRY_set(sk: PSTACK_X509_NAME_ENTRY; n: Integer; v: PX509_NAME_ENTRY):PX509_NAME_ENTRY; cdecl
  procedure f_sk_X509_NAME_ENTRY_zero(sk: PSTACK_X509_NAME_ENTRY); cdecl;
  function  f_sk_X509_NAME_ENTRY_push(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY):Integer; cdecl
  function  f_sk_X509_NAME_ENTRY_unshift(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY):Integer; cdecl
  function  f_sk_X509_NAME_ENTRY_find(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY):Integer; cdecl
  function  f_sk_X509_NAME_ENTRY_delete(sk: PSTACK_X509_NAME_ENTRY; n: Integer):PX509_NAME_ENTRY; cdecl
  procedure f_sk_X509_NAME_ENTRY_delete_ptr(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY); cdecl;
  function  f_sk_X509_NAME_ENTRY_insert(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY; n: Integer):Integer; cdecl
  function  f_sk_X509_NAME_ENTRY_dup(sk: PSTACK_X509_NAME_ENTRY):PSTACK_X509_NAME_ENTRY; cdecl
  procedure f_sk_X509_NAME_ENTRY_pop_free(sk: PSTACK_X509_NAME_ENTRY; arg1: PFunction); cdecl;
  function  f_sk_X509_NAME_ENTRY_shift(sk: PSTACK_X509_NAME_ENTRY):PX509_NAME_ENTRY; cdecl
  function  f_sk_X509_NAME_ENTRY_pop(sk: PSTACK_X509_NAME_ENTRY):PX509_NAME_ENTRY; cdecl
  procedure f_sk_X509_NAME_ENTRY_sort(sk: PSTACK_X509_NAME_ENTRY); cdecl;
  function  f_i2d_ASN1_SET_OF_X509_NAME_ENTRY(a: PSTACK_X509_NAME_ENTRY; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET_OF_X509_NAME_ENTRY(a: PPSTACK_X509_NAME_ENTRY; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_NAME_ENTRY; cdecl
  function  f_sk_X509_NAME_new(arg0: PFunction):PSTACK_X509_NAME; cdecl
  function  f_sk_X509_NAME_new_null:PSTACK_X509_NAME; cdecl
  procedure f_sk_X509_NAME_free(sk: PSTACK_X509_NAME); cdecl;
  function  f_sk_X509_NAME_num(const sk: PSTACK_X509_NAME):Integer; cdecl
  function  f_sk_X509_NAME_value(const sk: PSTACK_X509_NAME; n: Integer):PX509_NAME; cdecl
  function  f_sk_X509_NAME_set(sk: PSTACK_X509_NAME; n: Integer; v: PX509_NAME):PX509_NAME; cdecl
  procedure f_sk_X509_NAME_zero(sk: PSTACK_X509_NAME); cdecl;
  function  f_sk_X509_NAME_push(sk: PSTACK_X509_NAME; v: PX509_NAME):Integer; cdecl
  function  f_sk_X509_NAME_unshift(sk: PSTACK_X509_NAME; v: PX509_NAME):Integer; cdecl
  function  f_sk_X509_NAME_find(sk: PSTACK_X509_NAME; v: PX509_NAME):Integer; cdecl
  function  f_sk_X509_NAME_delete(sk: PSTACK_X509_NAME; n: Integer):PX509_NAME; cdecl
  procedure f_sk_X509_NAME_delete_ptr(sk: PSTACK_X509_NAME; v: PX509_NAME); cdecl;
  function  f_sk_X509_NAME_insert(sk: PSTACK_X509_NAME; v: PX509_NAME; n: Integer):Integer; cdecl
  function  f_sk_X509_NAME_dup(sk: PSTACK_X509_NAME):PSTACK_X509_NAME; cdecl
  procedure f_sk_X509_NAME_pop_free(sk: PSTACK_X509_NAME; arg1: PFunction); cdecl;
  function  f_sk_X509_NAME_shift(sk: PSTACK_X509_NAME):PX509_NAME; cdecl
  function  f_sk_X509_NAME_pop(sk: PSTACK_X509_NAME):PX509_NAME; cdecl
  procedure f_sk_X509_NAME_sort(sk: PSTACK_X509_NAME); cdecl;
  function  f_sk_X509_EXTENSION_new(arg0: PFunction):PSTACK_X509_EXTENSION; cdecl
  function  f_sk_X509_EXTENSION_new_null:PSTACK_X509_EXTENSION; cdecl
  procedure f_sk_X509_EXTENSION_free(sk: PSTACK_X509_EXTENSION); cdecl;
  function  f_sk_X509_EXTENSION_num(const sk: PSTACK_X509_EXTENSION):Integer; cdecl
  function  f_sk_X509_EXTENSION_value(const sk: PSTACK_X509_EXTENSION; n: Integer):PX509_EXTENSION; cdecl
  function  f_sk_X509_EXTENSION_set(sk: PSTACK_X509_EXTENSION; n: Integer; v: PX509_EXTENSION):PX509_EXTENSION; cdecl
  procedure f_sk_X509_EXTENSION_zero(sk: PSTACK_X509_EXTENSION); cdecl;
  function  f_sk_X509_EXTENSION_push(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION):Integer; cdecl
  function  f_sk_X509_EXTENSION_unshift(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION):Integer; cdecl
  function  f_sk_X509_EXTENSION_find(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION):Integer; cdecl
  function  f_sk_X509_EXTENSION_delete(sk: PSTACK_X509_EXTENSION; n: Integer):PX509_EXTENSION; cdecl
  procedure f_sk_X509_EXTENSION_delete_ptr(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION); cdecl;
  function  f_sk_X509_EXTENSION_insert(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION; n: Integer):Integer; cdecl
  function  f_sk_X509_EXTENSION_dup(sk: PSTACK_X509_EXTENSION):PSTACK_X509_EXTENSION; cdecl
  procedure f_sk_X509_EXTENSION_pop_free(sk: PSTACK_X509_EXTENSION; arg1: PFunction); cdecl;
  function  f_sk_X509_EXTENSION_shift(sk: PSTACK_X509_EXTENSION):PX509_EXTENSION; cdecl
  function  f_sk_X509_EXTENSION_pop(sk: PSTACK_X509_EXTENSION):PX509_EXTENSION; cdecl
  procedure f_sk_X509_EXTENSION_sort(sk: PSTACK_X509_EXTENSION); cdecl;
  function  f_i2d_ASN1_SET_OF_X509_EXTENSION(a: PSTACK_X509_EXTENSION; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET_OF_X509_EXTENSION(a: PPSTACK_X509_EXTENSION; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_EXTENSION; cdecl
  function  f_sk_X509_ATTRIBUTE_new(arg0: PFunction):PSTACK_X509_ATTRIBUTE; cdecl
  function  f_sk_X509_ATTRIBUTE_new_null:PSTACK_X509_ATTRIBUTE; cdecl
  procedure f_sk_X509_ATTRIBUTE_free(sk: PSTACK_X509_ATTRIBUTE); cdecl;
  function  f_sk_X509_ATTRIBUTE_num(const sk: PSTACK_X509_ATTRIBUTE):Integer; cdecl
  function  f_sk_X509_ATTRIBUTE_value(const sk: PSTACK_X509_ATTRIBUTE; n: Integer):PX509_ATTRIBUTE; cdecl
  function  f_sk_X509_ATTRIBUTE_set(sk: PSTACK_X509_ATTRIBUTE; n: Integer; v: PX509_ATTRIBUTE):PX509_ATTRIBUTE; cdecl
  procedure f_sk_X509_ATTRIBUTE_zero(sk: PSTACK_X509_ATTRIBUTE); cdecl;
  function  f_sk_X509_ATTRIBUTE_push(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE):Integer; cdecl
  function  f_sk_X509_ATTRIBUTE_unshift(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE):Integer; cdecl
  function  f_sk_X509_ATTRIBUTE_find(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE):Integer; cdecl
  function  f_sk_X509_ATTRIBUTE_delete(sk: PSTACK_X509_ATTRIBUTE; n: Integer):PX509_ATTRIBUTE; cdecl
  procedure f_sk_X509_ATTRIBUTE_delete_ptr(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE); cdecl;
  function  f_sk_X509_ATTRIBUTE_insert(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE; n: Integer):Integer; cdecl
  function  f_sk_X509_ATTRIBUTE_dup(sk: PSTACK_X509_ATTRIBUTE):PSTACK_X509_ATTRIBUTE; cdecl
  procedure f_sk_X509_ATTRIBUTE_pop_free(sk: PSTACK_X509_ATTRIBUTE; arg1: PFunction); cdecl;
  function  f_sk_X509_ATTRIBUTE_shift(sk: PSTACK_X509_ATTRIBUTE):PX509_ATTRIBUTE; cdecl
  function  f_sk_X509_ATTRIBUTE_pop(sk: PSTACK_X509_ATTRIBUTE):PX509_ATTRIBUTE; cdecl
  procedure f_sk_X509_ATTRIBUTE_sort(sk: PSTACK_X509_ATTRIBUTE); cdecl;
  function  f_i2d_ASN1_SET_OF_X509_ATTRIBUTE(a: PSTACK_X509_ATTRIBUTE; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET_OF_X509_ATTRIBUTE(a: PPSTACK_X509_ATTRIBUTE; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_ATTRIBUTE; cdecl
  function  f_sk_X509_new(arg0: PFunction):PSTACK_X509; cdecl
  function  f_sk_X509_new_null:PSTACK_X509; cdecl
  procedure f_sk_X509_free(sk: PSTACK_X509); cdecl;
  function  f_sk_X509_num(const sk: PSTACK_X509):Integer; cdecl
  function  f_sk_X509_value(const sk: PSTACK_X509; n: Integer):PX509; cdecl
  function  f_sk_X509_set(sk: PSTACK_X509; n: Integer; v: PX509):PX509; cdecl
  procedure f_sk_X509_zero(sk: PSTACK_X509); cdecl;
  function  f_sk_X509_push(sk: PSTACK_X509; v: PX509):Integer; cdecl
  function  f_sk_X509_unshift(sk: PSTACK_X509; v: PX509):Integer; cdecl
  function  f_sk_X509_find(sk: PSTACK_X509; v: PX509):Integer; cdecl
  function  f_sk_X509_delete(sk: PSTACK_X509; n: Integer):PX509; cdecl
  procedure f_sk_X509_delete_ptr(sk: PSTACK_X509; v: PX509); cdecl;
  function  f_sk_X509_insert(sk: PSTACK_X509; v: PX509; n: Integer):Integer; cdecl
  function  f_sk_X509_dup(sk: PSTACK_X509):PSTACK_X509; cdecl
  procedure f_sk_X509_pop_free(sk: PSTACK_X509; arg1: PFunction); cdecl;
  function  f_sk_X509_shift(sk: PSTACK_X509):PX509; cdecl
  function  f_sk_X509_pop(sk: PSTACK_X509):PX509; cdecl
  procedure f_sk_X509_sort(sk: PSTACK_X509); cdecl;
  function  f_i2d_ASN1_SET_OF_X509(a: PSTACK_X509; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET_OF_X509(a: PPSTACK_X509; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509; cdecl
  function  f_sk_X509_REVOKED_new(arg0: PFunction):PSTACK_X509_REVOKED; cdecl
  function  f_sk_X509_REVOKED_new_null:PSTACK_X509_REVOKED; cdecl
  procedure f_sk_X509_REVOKED_free(sk: PSTACK_X509_REVOKED); cdecl;
  function  f_sk_X509_REVOKED_num(const sk: PSTACK_X509_REVOKED):Integer; cdecl
  function  f_sk_X509_REVOKED_value(const sk: PSTACK_X509_REVOKED; n: Integer):PX509_REVOKED; cdecl
  function  f_sk_X509_REVOKED_set(sk: PSTACK_X509_REVOKED; n: Integer; v: PX509_REVOKED):PX509_REVOKED; cdecl
  procedure f_sk_X509_REVOKED_zero(sk: PSTACK_X509_REVOKED); cdecl;
  function  f_sk_X509_REVOKED_push(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED):Integer; cdecl
  function  f_sk_X509_REVOKED_unshift(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED):Integer; cdecl
  function  f_sk_X509_REVOKED_find(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED):Integer; cdecl
  function  f_sk_X509_REVOKED_delete(sk: PSTACK_X509_REVOKED; n: Integer):PX509_REVOKED; cdecl
  procedure f_sk_X509_REVOKED_delete_ptr(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED); cdecl;
  function  f_sk_X509_REVOKED_insert(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED; n: Integer):Integer; cdecl
  function  f_sk_X509_REVOKED_dup(sk: PSTACK_X509_REVOKED):PSTACK_X509_REVOKED; cdecl
  procedure f_sk_X509_REVOKED_pop_free(sk: PSTACK_X509_REVOKED; arg1: PFunction); cdecl;
  function  f_sk_X509_REVOKED_shift(sk: PSTACK_X509_REVOKED):PX509_REVOKED; cdecl
  function  f_sk_X509_REVOKED_pop(sk: PSTACK_X509_REVOKED):PX509_REVOKED; cdecl
  procedure f_sk_X509_REVOKED_sort(sk: PSTACK_X509_REVOKED); cdecl;
  function  f_i2d_ASN1_SET_OF_X509_REVOKED(a: PSTACK_X509_REVOKED; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET_OF_X509_REVOKED(a: PPSTACK_X509_REVOKED; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_REVOKED; cdecl
  function  f_sk_X509_CRL_new(arg0: PFunction):PSTACK_X509_CRL; cdecl
  function  f_sk_X509_CRL_new_null:PSTACK_X509_CRL; cdecl
  procedure f_sk_X509_CRL_free(sk: PSTACK_X509_CRL); cdecl;
  function  f_sk_X509_CRL_num(const sk: PSTACK_X509_CRL):Integer; cdecl
  function  f_sk_X509_CRL_value(const sk: PSTACK_X509_CRL; n: Integer):PX509_CRL; cdecl
  function  f_sk_X509_CRL_set(sk: PSTACK_X509_CRL; n: Integer; v: PX509_CRL):PX509_CRL; cdecl
  procedure f_sk_X509_CRL_zero(sk: PSTACK_X509_CRL); cdecl;
  function  f_sk_X509_CRL_push(sk: PSTACK_X509_CRL; v: PX509_CRL):Integer; cdecl
  function  f_sk_X509_CRL_unshift(sk: PSTACK_X509_CRL; v: PX509_CRL):Integer; cdecl
  function  f_sk_X509_CRL_find(sk: PSTACK_X509_CRL; v: PX509_CRL):Integer; cdecl
  function  f_sk_X509_CRL_delete(sk: PSTACK_X509_CRL; n: Integer):PX509_CRL; cdecl
  procedure f_sk_X509_CRL_delete_ptr(sk: PSTACK_X509_CRL; v: PX509_CRL); cdecl;
  function  f_sk_X509_CRL_insert(sk: PSTACK_X509_CRL; v: PX509_CRL; n: Integer):Integer; cdecl
  function  f_sk_X509_CRL_dup(sk: PSTACK_X509_CRL):PSTACK_X509_CRL; cdecl
  procedure f_sk_X509_CRL_pop_free(sk: PSTACK_X509_CRL; arg1: PFunction); cdecl;
  function  f_sk_X509_CRL_shift(sk: PSTACK_X509_CRL):PX509_CRL; cdecl
  function  f_sk_X509_CRL_pop(sk: PSTACK_X509_CRL):PX509_CRL; cdecl
  procedure f_sk_X509_CRL_sort(sk: PSTACK_X509_CRL); cdecl;
  function  f_i2d_ASN1_SET_OF_X509_CRL(a: PSTACK_X509_CRL; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET_OF_X509_CRL(a: PPSTACK_X509_CRL; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_CRL; cdecl
  function  f_sk_X509_INFO_new(arg0: PFunction):PSTACK_X509_INFO; cdecl
  function  f_sk_X509_INFO_new_null:PSTACK_X509_INFO; cdecl
  procedure f_sk_X509_INFO_free(sk: PSTACK_X509_INFO); cdecl;
  function  f_sk_X509_INFO_num(const sk: PSTACK_X509_INFO):Integer; cdecl
  function  f_sk_X509_INFO_value(const sk: PSTACK_X509_INFO; n: Integer):PX509_INFO; cdecl
  function  f_sk_X509_INFO_set(sk: PSTACK_X509_INFO; n: Integer; v: PX509_INFO):PX509_INFO; cdecl
  procedure f_sk_X509_INFO_zero(sk: PSTACK_X509_INFO); cdecl;
  function  f_sk_X509_INFO_push(sk: PSTACK_X509_INFO; v: PX509_INFO):Integer; cdecl
  function  f_sk_X509_INFO_unshift(sk: PSTACK_X509_INFO; v: PX509_INFO):Integer; cdecl
  function  f_sk_X509_INFO_find(sk: PSTACK_X509_INFO; v: PX509_INFO):Integer; cdecl
  function  f_sk_X509_INFO_delete(sk: PSTACK_X509_INFO; n: Integer):PX509_INFO; cdecl
  procedure f_sk_X509_INFO_delete_ptr(sk: PSTACK_X509_INFO; v: PX509_INFO); cdecl;
  function  f_sk_X509_INFO_insert(sk: PSTACK_X509_INFO; v: PX509_INFO; n: Integer):Integer; cdecl
  function  f_sk_X509_INFO_dup(sk: PSTACK_X509_INFO):PSTACK_X509_INFO; cdecl
  procedure f_sk_X509_INFO_pop_free(sk: PSTACK_X509_INFO; arg1: PFunction); cdecl;
  function  f_sk_X509_INFO_shift(sk: PSTACK_X509_INFO):PX509_INFO; cdecl
  function  f_sk_X509_INFO_pop(sk: PSTACK_X509_INFO):PX509_INFO; cdecl
  procedure f_sk_X509_INFO_sort(sk: PSTACK_X509_INFO); cdecl;
  function  f_sk_X509_LOOKUP_new(arg0: PFunction):PSTACK_X509_LOOKUP; cdecl
  function  f_sk_X509_LOOKUP_new_null:PSTACK_X509_LOOKUP; cdecl
  procedure f_sk_X509_LOOKUP_free(sk: PSTACK_X509_LOOKUP); cdecl;
  function  f_sk_X509_LOOKUP_num(const sk: PSTACK_X509_LOOKUP):Integer; cdecl
  function  f_sk_X509_LOOKUP_value(const sk: PSTACK_X509_LOOKUP; n: Integer):PX509_LOOKUP; cdecl
  function  f_sk_X509_LOOKUP_set(sk: PSTACK_X509_LOOKUP; n: Integer; v: PX509_LOOKUP):PX509_LOOKUP; cdecl
  procedure f_sk_X509_LOOKUP_zero(sk: PSTACK_X509_LOOKUP); cdecl;
  function  f_sk_X509_LOOKUP_push(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP):Integer; cdecl
  function  f_sk_X509_LOOKUP_unshift(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP):Integer; cdecl
  function  f_sk_X509_LOOKUP_find(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP):Integer; cdecl
  function  f_sk_X509_LOOKUP_delete(sk: PSTACK_X509_LOOKUP; n: Integer):PX509_LOOKUP; cdecl
  procedure f_sk_X509_LOOKUP_delete_ptr(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP); cdecl;
  function  f_sk_X509_LOOKUP_insert(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP; n: Integer):Integer; cdecl
  function  f_sk_X509_LOOKUP_dup(sk: PSTACK_X509_LOOKUP):PSTACK_X509_LOOKUP; cdecl
  procedure f_sk_X509_LOOKUP_pop_free(sk: PSTACK_X509_LOOKUP; arg1: PFunction); cdecl;
  function  f_sk_X509_LOOKUP_shift(sk: PSTACK_X509_LOOKUP):PX509_LOOKUP; cdecl
  function  f_sk_X509_LOOKUP_pop(sk: PSTACK_X509_LOOKUP):PX509_LOOKUP; cdecl
  procedure f_sk_X509_LOOKUP_sort(sk: PSTACK_X509_LOOKUP); cdecl;
  function  f_X509_OBJECT_retrieve_by_subject(h: PLHASH; _type: Integer; name: PX509_NAME):PX509_OBJECT; cdecl
  procedure f_X509_OBJECT_up_ref_count(a: PX509_OBJECT); cdecl;
  procedure f_X509_OBJECT_free_contents(a: PX509_OBJECT); cdecl;
  function  f_X509_STORE_new:PX509_STORE; cdecl
  procedure f_X509_STORE_free(v: PX509_STORE); cdecl;
  procedure f_X509_STORE_CTX_init(ctx: PX509_STORE_CTX; store: PX509_STORE; x509: PX509; chain: PSTACK_X509); cdecl;
  procedure f_X509_STORE_CTX_cleanup(ctx: PX509_STORE_CTX); cdecl;
  function  f_X509_STORE_add_lookup(v: PX509_STORE; m: PX509_LOOKUP_METHOD):PX509_LOOKUP; cdecl
  function  f_X509_LOOKUP_hash_dir:PX509_LOOKUP_METHOD; cdecl
  function  f_X509_LOOKUP_file:PX509_LOOKUP_METHOD; cdecl
  function  f_X509_STORE_add_cert(ctx: PX509_STORE; x: PX509):Integer; cdecl
  function  f_X509_STORE_add_crl(ctx: PX509_STORE; x: PX509_CRL):Integer; cdecl
  function  f_X509_STORE_get_by_subject(vs: PX509_STORE_CTX; _type: Integer; name: PX509_NAME; ret: PX509_OBJECT):Integer; cdecl
  function  f_X509_LOOKUP_ctrl(ctx: PX509_LOOKUP; cmd: Integer; const argc: PChar; argl: Longint; ret: PPChar):Integer; cdecl
  function  f_X509_load_cert_file(ctx: PX509_LOOKUP; const _file: PChar; _type: Integer):Integer; cdecl
  function  f_X509_load_crl_file(ctx: PX509_LOOKUP; const _file: PChar; _type: Integer):Integer; cdecl
  function  f_X509_LOOKUP_new(method: PX509_LOOKUP_METHOD):PX509_LOOKUP; cdecl
  procedure f_X509_LOOKUP_free(ctx: PX509_LOOKUP); cdecl;
  function  f_X509_LOOKUP_init(ctx: PX509_LOOKUP):Integer; cdecl
  function  f_X509_LOOKUP_by_subject(ctx: PX509_LOOKUP; _type: Integer; name: PX509_NAME; ret: PX509_OBJECT):Integer; cdecl
  function  f_X509_LOOKUP_by_issuer_serial(ctx: PX509_LOOKUP; _type: Integer; name: PX509_NAME; serial: PASN1_STRING; ret: PX509_OBJECT):Integer; cdecl
  function  f_X509_LOOKUP_by_fingerprint(ctx: PX509_LOOKUP; _type: Integer; bytes: PChar; len: Integer; ret: PX509_OBJECT):Integer; cdecl
  function  f_X509_LOOKUP_by_alias(ctx: PX509_LOOKUP; _type: Integer; str: PChar; len: Integer; ret: PX509_OBJECT):Integer; cdecl
  function  f_X509_LOOKUP_shutdown(ctx: PX509_LOOKUP):Integer; cdecl
  function  f_X509_STORE_load_locations(ctx: PX509_STORE; const _file: PChar; const dir: PChar):Integer; cdecl
  function  f_X509_STORE_set_default_paths(ctx: PX509_STORE):Integer; cdecl
  function  f_X509_STORE_CTX_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; cdecl
  function  f_X509_STORE_CTX_set_ex_data(ctx: PX509_STORE_CTX; idx: Integer; data: Pointer):Integer; cdecl
  function  f_X509_STORE_CTX_get_ex_data(ctx: PX509_STORE_CTX; idx: Integer):Pointer; cdecl
  function  f_X509_STORE_CTX_get_error(ctx: PX509_STORE_CTX):Integer; cdecl
  procedure f_X509_STORE_CTX_set_error(ctx: PX509_STORE_CTX; s: Integer); cdecl;
  function  f_X509_STORE_CTX_get_error_depth(ctx: PX509_STORE_CTX):Integer; cdecl
  function  f_X509_STORE_CTX_get_current_cert(ctx: PX509_STORE_CTX):PX509; cdecl
  function  f_X509_STORE_CTX_get_chain(ctx: PX509_STORE_CTX):PSTACK_X509; cdecl
  procedure f_X509_STORE_CTX_set_cert(c: PX509_STORE_CTX; x: PX509); cdecl;
  procedure f_X509_STORE_CTX_set_chain(c: PX509_STORE_CTX; sk: PSTACK_X509); cdecl;
  function  f_sk_PKCS7_SIGNER_INFO_new(arg0: PFunction):PSTACK_PKCS7_SIGNER_INFO; cdecl
  function  f_sk_PKCS7_SIGNER_INFO_new_null:PSTACK_PKCS7_SIGNER_INFO; cdecl
  procedure f_sk_PKCS7_SIGNER_INFO_free(sk: PSTACK_PKCS7_SIGNER_INFO); cdecl;
  function  f_sk_PKCS7_SIGNER_INFO_num(const sk: PSTACK_PKCS7_SIGNER_INFO):Integer; cdecl
  function  f_sk_PKCS7_SIGNER_INFO_value(const sk: PSTACK_PKCS7_SIGNER_INFO; n: Integer):PPKCS7_SIGNER_INFO; cdecl
  function  f_sk_PKCS7_SIGNER_INFO_set(sk: PSTACK_PKCS7_SIGNER_INFO; n: Integer; v: PPKCS7_SIGNER_INFO):PPKCS7_SIGNER_INFO; cdecl
  procedure f_sk_PKCS7_SIGNER_INFO_zero(sk: PSTACK_PKCS7_SIGNER_INFO); cdecl;
  function  f_sk_PKCS7_SIGNER_INFO_push(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO):Integer; cdecl
  function  f_sk_PKCS7_SIGNER_INFO_unshift(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO):Integer; cdecl
  function  f_sk_PKCS7_SIGNER_INFO_find(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO):Integer; cdecl
  function  f_sk_PKCS7_SIGNER_INFO_delete(sk: PSTACK_PKCS7_SIGNER_INFO; n: Integer):PPKCS7_SIGNER_INFO; cdecl
  procedure f_sk_PKCS7_SIGNER_INFO_delete_ptr(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO); cdecl;
  function  f_sk_PKCS7_SIGNER_INFO_insert(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO; n: Integer):Integer; cdecl
  function  f_sk_PKCS7_SIGNER_INFO_dup(sk: PSTACK_PKCS7_SIGNER_INFO):PSTACK_PKCS7_SIGNER_INFO; cdecl
  procedure f_sk_PKCS7_SIGNER_INFO_pop_free(sk: PSTACK_PKCS7_SIGNER_INFO; arg1: PFunction); cdecl;
  function  f_sk_PKCS7_SIGNER_INFO_shift(sk: PSTACK_PKCS7_SIGNER_INFO):PPKCS7_SIGNER_INFO; cdecl
  function  f_sk_PKCS7_SIGNER_INFO_pop(sk: PSTACK_PKCS7_SIGNER_INFO):PPKCS7_SIGNER_INFO; cdecl
  procedure f_sk_PKCS7_SIGNER_INFO_sort(sk: PSTACK_PKCS7_SIGNER_INFO); cdecl;
  function  f_i2d_ASN1_SET_OF_PKCS7_SIGNER_INFO(a: PSTACK_PKCS7_SIGNER_INFO; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET_OF_PKCS7_SIGNER_INFO(a: PPSTACK_PKCS7_SIGNER_INFO; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_PKCS7_SIGNER_INFO; cdecl
  function  f_sk_PKCS7_RECIP_INFO_new(arg0: PFunction):PSTACK_PKCS7_RECIP_INFO; cdecl
  function  f_sk_PKCS7_RECIP_INFO_new_null:PSTACK_PKCS7_RECIP_INFO; cdecl
  procedure f_sk_PKCS7_RECIP_INFO_free(sk: PSTACK_PKCS7_RECIP_INFO); cdecl;
  function  f_sk_PKCS7_RECIP_INFO_num(const sk: PSTACK_PKCS7_RECIP_INFO):Integer; cdecl
  function  f_sk_PKCS7_RECIP_INFO_value(const sk: PSTACK_PKCS7_RECIP_INFO; n: Integer):PPKCS7_RECIP_INFO; cdecl
  function  f_sk_PKCS7_RECIP_INFO_set(sk: PSTACK_PKCS7_RECIP_INFO; n: Integer; v: PPKCS7_RECIP_INFO):PPKCS7_RECIP_INFO; cdecl
  procedure f_sk_PKCS7_RECIP_INFO_zero(sk: PSTACK_PKCS7_RECIP_INFO); cdecl;
  function  f_sk_PKCS7_RECIP_INFO_push(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO):Integer; cdecl
  function  f_sk_PKCS7_RECIP_INFO_unshift(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO):Integer; cdecl
  function  f_sk_PKCS7_RECIP_INFO_find(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO):Integer; cdecl
  function  f_sk_PKCS7_RECIP_INFO_delete(sk: PSTACK_PKCS7_RECIP_INFO; n: Integer):PPKCS7_RECIP_INFO; cdecl
  procedure f_sk_PKCS7_RECIP_INFO_delete_ptr(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO); cdecl;
  function  f_sk_PKCS7_RECIP_INFO_insert(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO; n: Integer):Integer; cdecl
  function  f_sk_PKCS7_RECIP_INFO_dup(sk: PSTACK_PKCS7_RECIP_INFO):PSTACK_PKCS7_RECIP_INFO; cdecl
  procedure f_sk_PKCS7_RECIP_INFO_pop_free(sk: PSTACK_PKCS7_RECIP_INFO; arg1: PFunction); cdecl;
  function  f_sk_PKCS7_RECIP_INFO_shift(sk: PSTACK_PKCS7_RECIP_INFO):PPKCS7_RECIP_INFO; cdecl
  function  f_sk_PKCS7_RECIP_INFO_pop(sk: PSTACK_PKCS7_RECIP_INFO):PPKCS7_RECIP_INFO; cdecl
  procedure f_sk_PKCS7_RECIP_INFO_sort(sk: PSTACK_PKCS7_RECIP_INFO); cdecl;
  function  f_i2d_ASN1_SET_OF_PKCS7_RECIP_INFO(a: PSTACK_PKCS7_RECIP_INFO; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; cdecl
  function  f_d2i_ASN1_SET_OF_PKCS7_RECIP_INFO(a: PPSTACK_PKCS7_RECIP_INFO; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_PKCS7_RECIP_INFO; cdecl
  function  f_PKCS7_ISSUER_AND_SERIAL_new:PPKCS7_ISSUER_AND_SERIAL; cdecl
  procedure f_PKCS7_ISSUER_AND_SERIAL_free(a: PPKCS7_ISSUER_AND_SERIAL); cdecl;
  function  f_i2d_PKCS7_ISSUER_AND_SERIAL(a: PPKCS7_ISSUER_AND_SERIAL; pp: PPChar):Integer; cdecl
  function  f_d2i_PKCS7_ISSUER_AND_SERIAL(a: PPPKCS7_ISSUER_AND_SERIAL; pp: PPChar; length: Longint):PPKCS7_ISSUER_AND_SERIAL; cdecl
  function  f_PKCS7_ISSUER_AND_SERIAL_digest(data: PPKCS7_ISSUER_AND_SERIAL; _type: PEVP_MD; md: PChar; len: PUInteger):Integer; cdecl
  function  f_d2i_PKCS7_fp(fp: PFILE; p7: PPPKCS7):PPKCS7; cdecl
  function  f_i2d_PKCS7_fp(fp: PFILE; p7: PPKCS7):Integer; cdecl
  function  f_PKCS7_dup(p7: PPKCS7):PPKCS7; cdecl
  function  f_d2i_PKCS7_bio(bp: PBIO; p7: PPPKCS7):PPKCS7; cdecl
  function  f_i2d_PKCS7_bio(bp: PBIO; p7: PPKCS7):Integer; cdecl
  function  f_PKCS7_SIGNER_INFO_new:PPKCS7_SIGNER_INFO; cdecl
  procedure f_PKCS7_SIGNER_INFO_free(a: PPKCS7_SIGNER_INFO); cdecl;
  function  f_i2d_PKCS7_SIGNER_INFO(a: PPKCS7_SIGNER_INFO; pp: PPChar):Integer; cdecl
  function  f_d2i_PKCS7_SIGNER_INFO(a: PPPKCS7_SIGNER_INFO; pp: PPChar; length: Longint):PPKCS7_SIGNER_INFO; cdecl
  function  f_PKCS7_RECIP_INFO_new:PPKCS7_RECIP_INFO; cdecl
  procedure f_PKCS7_RECIP_INFO_free(a: PPKCS7_RECIP_INFO); cdecl;
  function  f_i2d_PKCS7_RECIP_INFO(a: PPKCS7_RECIP_INFO; pp: PPChar):Integer; cdecl
  function  f_d2i_PKCS7_RECIP_INFO(a: PPPKCS7_RECIP_INFO; pp: PPChar; length: Longint):PPKCS7_RECIP_INFO; cdecl
  function  f_PKCS7_SIGNED_new:PPKCS7_SIGNED; cdecl
  procedure f_PKCS7_SIGNED_free(a: PPKCS7_SIGNED); cdecl;
  function  f_i2d_PKCS7_SIGNED(a: PPKCS7_SIGNED; pp: PPChar):Integer; cdecl
  function  f_d2i_PKCS7_SIGNED(a: PPPKCS7_SIGNED; pp: PPChar; length: Longint):PPKCS7_SIGNED; cdecl
  function  f_PKCS7_ENC_CONTENT_new:PPKCS7_ENC_CONTENT; cdecl
  procedure f_PKCS7_ENC_CONTENT_free(a: PPKCS7_ENC_CONTENT); cdecl;
  function  f_i2d_PKCS7_ENC_CONTENT(a: PPKCS7_ENC_CONTENT; pp: PPChar):Integer; cdecl
  function  f_d2i_PKCS7_ENC_CONTENT(a: PPPKCS7_ENC_CONTENT; pp: PPChar; length: Longint):PPKCS7_ENC_CONTENT; cdecl
  function  f_PKCS7_ENVELOPE_new:PPKCS7_ENVELOPE; cdecl
  procedure f_PKCS7_ENVELOPE_free(a: PPKCS7_ENVELOPE); cdecl;
  function  f_i2d_PKCS7_ENVELOPE(a: PPKCS7_ENVELOPE; pp: PPChar):Integer; cdecl
  function  f_d2i_PKCS7_ENVELOPE(a: PPPKCS7_ENVELOPE; pp: PPChar; length: Longint):PPKCS7_ENVELOPE; cdecl
  function  f_PKCS7_SIGN_ENVELOPE_new:PPKCS7_SIGN_ENVELOPE; cdecl
  procedure f_PKCS7_SIGN_ENVELOPE_free(a: PPKCS7_SIGN_ENVELOPE); cdecl;
  function  f_i2d_PKCS7_SIGN_ENVELOPE(a: PPKCS7_SIGN_ENVELOPE; pp: PPChar):Integer; cdecl
  function  f_d2i_PKCS7_SIGN_ENVELOPE(a: PPPKCS7_SIGN_ENVELOPE; pp: PPChar; length: Longint):PPKCS7_SIGN_ENVELOPE; cdecl
  function  f_PKCS7_DIGEST_new:PPKCS7_DIGEST; cdecl
  procedure f_PKCS7_DIGEST_free(a: PPKCS7_DIGEST); cdecl;
  function  f_i2d_PKCS7_DIGEST(a: PPKCS7_DIGEST; pp: PPChar):Integer; cdecl
  function  f_d2i_PKCS7_DIGEST(a: PPPKCS7_DIGEST; pp: PPChar; length: Longint):PPKCS7_DIGEST; cdecl
  function  f_PKCS7_ENCRYPT_new:PPKCS7_ENCRYPT; cdecl
  procedure f_PKCS7_ENCRYPT_free(a: PPKCS7_ENCRYPT); cdecl;
  function  f_i2d_PKCS7_ENCRYPT(a: PPKCS7_ENCRYPT; pp: PPChar):Integer; cdecl
  function  f_d2i_PKCS7_ENCRYPT(a: PPPKCS7_ENCRYPT; pp: PPChar; length: Longint):PPKCS7_ENCRYPT; cdecl
  function  f_PKCS7_new:PPKCS7; cdecl
  procedure f_PKCS7_free(a: PPKCS7); cdecl;
  procedure f_PKCS7_content_free(a: PPKCS7); cdecl;
  function  f_i2d_PKCS7(a: PPKCS7; pp: PPChar):Integer; cdecl
  function  f_d2i_PKCS7(a: PPPKCS7; pp: PPChar; length: Longint):PPKCS7; cdecl
  procedure f_ERR_load_PKCS7_strings; cdecl;
  function  f_PKCS7_ctrl(p7: PPKCS7; cmd: Integer; larg: Longint; parg: PChar):Longint; cdecl
  function  f_PKCS7_set_type(p7: PPKCS7; _type: Integer):Integer; cdecl
  function  f_PKCS7_set_content(p7: PPKCS7; p7_data: PPKCS7):Integer; cdecl
  function  f_PKCS7_SIGNER_INFO_set(p7i: PPKCS7_SIGNER_INFO; x509: PX509; pkey: PEVP_PKEY; dgst: PEVP_MD):Integer; cdecl
  function  f_PKCS7_add_signer(p7: PPKCS7; p7i: PPKCS7_SIGNER_INFO):Integer; cdecl
  function  f_PKCS7_add_certificate(p7: PPKCS7; x509: PX509):Integer; cdecl
  function  f_PKCS7_add_crl(p7: PPKCS7; x509: PX509_CRL):Integer; cdecl
  function  f_PKCS7_content_new(p7: PPKCS7; nid: Integer):Integer; cdecl
  function  f_PKCS7_dataVerify(cert_store: PX509_STORE; ctx: PX509_STORE_CTX; bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO):Integer; cdecl
  function  f_PKCS7_signatureVerify(bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO; x509: PX509):Integer; cdecl
  function  f_PKCS7_dataInit(p7: PPKCS7; bio: PBIO):PBIO; cdecl
  function  f_PKCS7_dataFinal(p7: PPKCS7; bio: PBIO):Integer; cdecl
  function  f_PKCS7_dataDecode(p7: PPKCS7; pkey: PEVP_PKEY; in_bio: PBIO; pcert: PX509):PBIO; cdecl
  function  f_PKCS7_add_signature(p7: PPKCS7; x509: PX509; pkey: PEVP_PKEY; dgst: PEVP_MD):PPKCS7_SIGNER_INFO; cdecl
  function  f_PKCS7_cert_from_signer_info(p7: PPKCS7; si: PPKCS7_SIGNER_INFO):PX509; cdecl
  function  f_PKCS7_get_signer_info(p7: PPKCS7):PSTACK_PKCS7_SIGNER_INFO; cdecl
  function  f_PKCS7_add_recipient(p7: PPKCS7; x509: PX509):PPKCS7_RECIP_INFO; cdecl
  function  f_PKCS7_add_recipient_info(p7: PPKCS7; ri: PPKCS7_RECIP_INFO):Integer; cdecl
  function  f_PKCS7_RECIP_INFO_set(p7i: PPKCS7_RECIP_INFO; x509: PX509):Integer; cdecl
  function  f_PKCS7_set_cipher(p7: PPKCS7; const cipher: PEVP_CIPHER):Integer; cdecl
  function  f_PKCS7_get_issuer_and_serial(p7: PPKCS7; idx: Integer):PPKCS7_ISSUER_AND_SERIAL; cdecl
  function  f_PKCS7_digest_from_attributes(sk: PSTACK_X509_ATTRIBUTE):PASN1_STRING; cdecl
  function  f_PKCS7_add_signed_attribute(p7si: PPKCS7_SIGNER_INFO; nid: Integer; _type: Integer; data: Pointer):Integer; cdecl
  function  f_PKCS7_add_attribute(p7si: PPKCS7_SIGNER_INFO; nid: Integer; atrtype: Integer; value: Pointer):Integer; cdecl
  function  f_PKCS7_get_attribute(si: PPKCS7_SIGNER_INFO; nid: Integer):PASN1_TYPE; cdecl
  function  f_PKCS7_get_signed_attribute(si: PPKCS7_SIGNER_INFO; nid: Integer):PASN1_TYPE; cdecl
  function  f_PKCS7_set_signed_attributes(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_X509_ATTRIBUTE):Integer; cdecl
  function  f_PKCS7_set_attributes(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_X509_ATTRIBUTE):Integer; cdecl
  function  f_X509_verify_cert_error_string(n: Longint):PChar; cdecl
  function  f_X509_verify(a: PX509; r: PEVP_PKEY):Integer; cdecl
  function  f_X509_REQ_verify(a: PX509_REQ; r: PEVP_PKEY):Integer; cdecl
  function  f_X509_CRL_verify(a: PX509_CRL; r: PEVP_PKEY):Integer; cdecl
  function  f_NETSCAPE_SPKI_verify(a: PNETSCAPE_SPKI; r: PEVP_PKEY):Integer; cdecl
  function  f_X509_sign(x: PX509; pkey: PEVP_PKEY; const md: PEVP_MD):Integer; cdecl
  function  f_X509_REQ_sign(x: PX509_REQ; pkey: PEVP_PKEY; const md: PEVP_MD):Integer; cdecl
  function  f_X509_CRL_sign(x: PX509_CRL; pkey: PEVP_PKEY; const md: PEVP_MD):Integer; cdecl
  function  f_NETSCAPE_SPKI_sign(x: PNETSCAPE_SPKI; pkey: PEVP_PKEY; const md: PEVP_MD):Integer; cdecl
  function  f_X509_digest(data: PX509; _type: PEVP_MD; md: PChar; len: PUInteger):Integer; cdecl
  function  f_X509_NAME_digest(data: PX509_NAME; _type: PEVP_MD; md: PChar; len: PUInteger):Integer; cdecl
  function  f_d2i_X509_fp(fp: PFILE; x509: PPX509):PX509; cdecl
  function  f_i2d_X509_fp(fp: PFILE; x509: PX509):Integer; cdecl
  function  f_d2i_X509_CRL_fp(fp: PFILE; crl: PPX509_CRL):PX509_CRL; cdecl
  function  f_i2d_X509_CRL_fp(fp: PFILE; crl: PX509_CRL):Integer; cdecl
  function  f_d2i_X509_REQ_fp(fp: PFILE; req: PPX509_REQ):PX509_REQ; cdecl
  function  f_i2d_X509_REQ_fp(fp: PFILE; req: PX509_REQ):Integer; cdecl
  function  f_d2i_RSAPrivateKey_fp(fp: PFILE; rsa: PPRSA):PRSA; cdecl
  function  f_i2d_RSAPrivateKey_fp(fp: PFILE; rsa: PRSA):Integer; cdecl
  function  f_d2i_RSAPublicKey_fp(fp: PFILE; rsa: PPRSA):PRSA; cdecl
  function  f_i2d_RSAPublicKey_fp(fp: PFILE; rsa: PRSA):Integer; cdecl
  function  f_d2i_DSAPrivateKey_fp(fp: PFILE; dsa: PPDSA):PDSA; cdecl
  function  f_i2d_DSAPrivateKey_fp(fp: PFILE; dsa: PDSA):Integer; cdecl
  function  f_d2i_PKCS8_fp(fp: PFILE; p8: PPX509_SIG):PX509_SIG; cdecl
  function  f_i2d_PKCS8_fp(fp: PFILE; p8: PX509_SIG):Integer; cdecl
  function  f_d2i_PKCS8_PRIV_KEY_INFO_fp(fp: PFILE; p8inf: PPPKCS8_PRIV_KEY_INFO):PPKCS8_PRIV_KEY_INFO; cdecl
  function  f_i2d_PKCS8_PRIV_KEY_INFO_fp(fp: PFILE; p8inf: PPKCS8_PRIV_KEY_INFO):Integer; cdecl
  function  f_d2i_X509_bio(bp: PBIO; x509: PPX509):PX509; cdecl
  function  f_i2d_X509_bio(bp: PBIO; x509: PX509):Integer; cdecl
  function  f_d2i_X509_CRL_bio(bp: PBIO; crl: PPX509_CRL):PX509_CRL; cdecl
  function  f_i2d_X509_CRL_bio(bp: PBIO; crl: PX509_CRL):Integer; cdecl
  function  f_d2i_X509_REQ_bio(bp: PBIO; req: PPX509_REQ):PX509_REQ; cdecl
  function  f_i2d_X509_REQ_bio(bp: PBIO; req: PX509_REQ):Integer; cdecl
  function  f_d2i_RSAPrivateKey_bio(bp: PBIO; rsa: PPRSA):PRSA; cdecl
  function  f_i2d_RSAPrivateKey_bio(bp: PBIO; rsa: PRSA):Integer; cdecl
  function  f_d2i_RSAPublicKey_bio(bp: PBIO; rsa: PPRSA):PRSA; cdecl
  function  f_i2d_RSAPublicKey_bio(bp: PBIO; rsa: PRSA):Integer; cdecl
  function  f_d2i_DSAPrivateKey_bio(bp: PBIO; dsa: PPDSA):PDSA; cdecl
  function  f_i2d_DSAPrivateKey_bio(bp: PBIO; dsa: PDSA):Integer; cdecl
  function  f_d2i_PKCS8_bio(bp: PBIO; p8: PPX509_SIG):PX509_SIG; cdecl
  function  f_i2d_PKCS8_bio(bp: PBIO; p8: PX509_SIG):Integer; cdecl
  function  f_d2i_PKCS8_PRIV_KEY_INFO_bio(bp: PBIO; p8inf: PPPKCS8_PRIV_KEY_INFO):PPKCS8_PRIV_KEY_INFO; cdecl
  function  f_i2d_PKCS8_PRIV_KEY_INFO_bio(bp: PBIO; p8inf: PPKCS8_PRIV_KEY_INFO):Integer; cdecl
  function  f_X509_dup(x509: PX509):PX509; cdecl
  function  f_X509_ATTRIBUTE_dup(xa: PX509_ATTRIBUTE):PX509_ATTRIBUTE; cdecl
  function  f_X509_EXTENSION_dup(ex: PX509_EXTENSION):PX509_EXTENSION; cdecl
  function  f_X509_CRL_dup(crl: PX509_CRL):PX509_CRL; cdecl
  function  f_X509_REQ_dup(req: PX509_REQ):PX509_REQ; cdecl
  function  f_X509_ALGOR_dup(xn: PX509_ALGOR):PX509_ALGOR; cdecl
  function  f_X509_NAME_dup(xn: PX509_NAME):PX509_NAME; cdecl
  function  f_X509_NAME_ENTRY_dup(ne: PX509_NAME_ENTRY):PX509_NAME_ENTRY; cdecl
  function  f_RSAPublicKey_dup(rsa: PRSA):PRSA; cdecl
  function  f_RSAPrivateKey_dup(rsa: PRSA):PRSA; cdecl
  function  f_X509_cmp_current_time(s: PASN1_STRING):Integer; cdecl
  function  f_X509_gmtime_adj(s: PASN1_STRING; adj: Longint):PASN1_STRING; cdecl
  function  f_X509_get_default_cert_area:PChar; cdecl
  function  f_X509_get_default_cert_dir:PChar; cdecl
  function  f_X509_get_default_cert_file:PChar; cdecl
  function  f_X509_get_default_cert_dir_env:PChar; cdecl
  function  f_X509_get_default_cert_file_env:PChar; cdecl
  function  f_X509_get_default_private_dir:PChar; cdecl
  function  f_X509_to_X509_REQ(x: PX509; pkey: PEVP_PKEY; md: PEVP_MD):PX509_REQ; cdecl
  function  f_X509_REQ_to_X509(r: PX509_REQ; days: Integer; pkey: PEVP_PKEY):PX509; cdecl
  procedure f_ERR_load_X509_strings; cdecl;
  function  f_X509_ALGOR_new:PX509_ALGOR; cdecl
  procedure f_X509_ALGOR_free(a: PX509_ALGOR); cdecl;
  function  f_i2d_X509_ALGOR(a: PX509_ALGOR; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_ALGOR(a: PPX509_ALGOR; pp: PPChar; length: Longint):PX509_ALGOR; cdecl
  function  f_X509_VAL_new:PX509_VAL; cdecl
  procedure f_X509_VAL_free(a: PX509_VAL); cdecl;
  function  f_i2d_X509_VAL(a: PX509_VAL; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_VAL(a: PPX509_VAL; pp: PPChar; length: Longint):PX509_VAL; cdecl
  function  f_X509_PUBKEY_new:PX509_PUBKEY; cdecl
  procedure f_X509_PUBKEY_free(a: PX509_PUBKEY); cdecl;
  function  f_i2d_X509_PUBKEY(a: PX509_PUBKEY; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_PUBKEY(a: PPX509_PUBKEY; pp: PPChar; length: Longint):PX509_PUBKEY; cdecl
  function  f_X509_PUBKEY_set(x: PPX509_PUBKEY; pkey: PEVP_PKEY):Integer; cdecl
  function  f_X509_PUBKEY_get(key: PX509_PUBKEY):PEVP_PKEY; cdecl
  function  f_X509_get_pubkey_parameters(pkey: PEVP_PKEY; chain: PSTACK_X509):Integer; cdecl
  function  f_X509_SIG_new:PX509_SIG; cdecl
  procedure f_X509_SIG_free(a: PX509_SIG); cdecl;
  function  f_i2d_X509_SIG(a: PX509_SIG; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_SIG(a: PPX509_SIG; pp: PPChar; length: Longint):PX509_SIG; cdecl
  function  f_X509_REQ_INFO_new:PX509_REQ_INFO; cdecl
  procedure f_X509_REQ_INFO_free(a: PX509_REQ_INFO); cdecl;
  function  f_i2d_X509_REQ_INFO(a: PX509_REQ_INFO; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_REQ_INFO(a: PPX509_REQ_INFO; pp: PPChar; length: Longint):PX509_REQ_INFO; cdecl
  function  f_X509_REQ_new:PX509_REQ; cdecl
  procedure f_X509_REQ_free(a: PX509_REQ); cdecl;
  function  f_i2d_X509_REQ(a: PX509_REQ; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_REQ(a: PPX509_REQ; pp: PPChar; length: Longint):PX509_REQ; cdecl
  function  f_X509_ATTRIBUTE_new:PX509_ATTRIBUTE; cdecl
  procedure f_X509_ATTRIBUTE_free(a: PX509_ATTRIBUTE); cdecl;
  function  f_i2d_X509_ATTRIBUTE(a: PX509_ATTRIBUTE; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_ATTRIBUTE(a: PPX509_ATTRIBUTE; pp: PPChar; length: Longint):PX509_ATTRIBUTE; cdecl
  function  f_X509_ATTRIBUTE_create(nid: Integer; atrtype: Integer; value: Pointer):PX509_ATTRIBUTE; cdecl
  function  f_X509_EXTENSION_new:PX509_EXTENSION; cdecl
  procedure f_X509_EXTENSION_free(a: PX509_EXTENSION); cdecl;
  function  f_i2d_X509_EXTENSION(a: PX509_EXTENSION; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_EXTENSION(a: PPX509_EXTENSION; pp: PPChar; length: Longint):PX509_EXTENSION; cdecl
  function  f_X509_NAME_ENTRY_new:PX509_NAME_ENTRY; cdecl
  procedure f_X509_NAME_ENTRY_free(a: PX509_NAME_ENTRY); cdecl;
  function  f_i2d_X509_NAME_ENTRY(a: PX509_NAME_ENTRY; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_NAME_ENTRY(a: PPX509_NAME_ENTRY; pp: PPChar; length: Longint):PX509_NAME_ENTRY; cdecl
  function  f_X509_NAME_new:PX509_NAME; cdecl
  procedure f_X509_NAME_free(a: PX509_NAME); cdecl;
  function  f_i2d_X509_NAME(a: PX509_NAME; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_NAME(a: PPX509_NAME; pp: PPChar; length: Longint):PX509_NAME; cdecl
  function  f_X509_NAME_set(xn: PPX509_NAME; name: PX509_NAME):Integer; cdecl
  function  f_X509_CINF_new:PX509_CINF; cdecl
  procedure f_X509_CINF_free(a: PX509_CINF); cdecl;
  function  f_i2d_X509_CINF(a: PX509_CINF; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_CINF(a: PPX509_CINF; pp: PPChar; length: Longint):PX509_CINF; cdecl
  function  f_X509_new:PX509; cdecl
  procedure f_X509_free(a: PX509); cdecl;
  function  f_i2d_X509(a: PX509; pp: PPChar):Integer; cdecl
  function  f_d2i_X509(a: PPX509; pp: PPChar; length: Longint):PX509; cdecl
  function  f_X509_REVOKED_new:PX509_REVOKED; cdecl
  procedure f_X509_REVOKED_free(a: PX509_REVOKED); cdecl;
  function  f_i2d_X509_REVOKED(a: PX509_REVOKED; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_REVOKED(a: PPX509_REVOKED; pp: PPChar; length: Longint):PX509_REVOKED; cdecl
  function  f_X509_CRL_INFO_new:PX509_CRL_INFO; cdecl
  procedure f_X509_CRL_INFO_free(a: PX509_CRL_INFO); cdecl;
  function  f_i2d_X509_CRL_INFO(a: PX509_CRL_INFO; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_CRL_INFO(a: PPX509_CRL_INFO; pp: PPChar; length: Longint):PX509_CRL_INFO; cdecl
  function  f_X509_CRL_new:PX509_CRL; cdecl
  procedure f_X509_CRL_free(a: PX509_CRL); cdecl;
  function  f_i2d_X509_CRL(a: PX509_CRL; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_CRL(a: PPX509_CRL; pp: PPChar; length: Longint):PX509_CRL; cdecl
  function  f_X509_PKEY_new:PX509_PKEY; cdecl
  procedure f_X509_PKEY_free(a: PX509_PKEY); cdecl;
  function  f_i2d_X509_PKEY(a: PX509_PKEY; pp: PPChar):Integer; cdecl
  function  f_d2i_X509_PKEY(a: PPX509_PKEY; pp: PPChar; length: Longint):PX509_PKEY; cdecl
  function  f_NETSCAPE_SPKI_new:PNETSCAPE_SPKI; cdecl
  procedure f_NETSCAPE_SPKI_free(a: PNETSCAPE_SPKI); cdecl;
  function  f_i2d_NETSCAPE_SPKI(a: PNETSCAPE_SPKI; pp: PPChar):Integer; cdecl
  function  f_d2i_NETSCAPE_SPKI(a: PPNETSCAPE_SPKI; pp: PPChar; length: Longint):PNETSCAPE_SPKI; cdecl
  function  f_NETSCAPE_SPKAC_new:PNETSCAPE_SPKAC; cdecl
  procedure f_NETSCAPE_SPKAC_free(a: PNETSCAPE_SPKAC); cdecl;
  function  f_i2d_NETSCAPE_SPKAC(a: PNETSCAPE_SPKAC; pp: PPChar):Integer; cdecl
  function  f_d2i_NETSCAPE_SPKAC(a: PPNETSCAPE_SPKAC; pp: PPChar; length: Longint):PNETSCAPE_SPKAC; cdecl
  function  f_i2d_NETSCAPE_CERT_SEQUENCE(a: PNETSCAPE_CERT_SEQUENCE; pp: PPChar):Integer; cdecl
  function  f_NETSCAPE_CERT_SEQUENCE_new:PNETSCAPE_CERT_SEQUENCE; cdecl
  function  f_d2i_NETSCAPE_CERT_SEQUENCE(a: PPNETSCAPE_CERT_SEQUENCE; pp: PPChar; length: Longint):PNETSCAPE_CERT_SEQUENCE; cdecl
  procedure f_NETSCAPE_CERT_SEQUENCE_free(a: PNETSCAPE_CERT_SEQUENCE); cdecl;
  function  f_X509_INFO_new:PX509_INFO; cdecl
  procedure f_X509_INFO_free(a: PX509_INFO); cdecl;
  function  f_X509_NAME_oneline(a: PX509_NAME; buf: PChar; size: Integer):PChar; cdecl
  function  f_ASN1_verify(arg0: PFunction; algor1: PX509_ALGOR; signature: PASN1_STRING; data: PChar; pkey: PEVP_PKEY):Integer; cdecl
  function  f_ASN1_digest(arg0: PFunction; _type: PEVP_MD; data: PChar; md: PChar; len: PUInteger):Integer; cdecl
  function  f_ASN1_sign(arg0: PFunction; algor1: PX509_ALGOR; algor2: PX509_ALGOR; signature: PASN1_STRING; data: PChar; pkey: PEVP_PKEY; const _type: PEVP_MD):Integer; cdecl
  function  f_X509_set_version(x: PX509; version: Longint):Integer; cdecl
  function  f_X509_set_serialNumber(x: PX509; serial: PASN1_STRING):Integer; cdecl
  function  f_X509_get_serialNumber(x: PX509):PASN1_STRING; cdecl
  function  f_X509_set_issuer_name(x: PX509; name: PX509_NAME):Integer; cdecl
  function  f_X509_get_issuer_name(a: PX509):PX509_NAME; cdecl
  function  f_X509_set_subject_name(x: PX509; name: PX509_NAME):Integer; cdecl
  function  f_X509_get_subject_name(a: PX509):PX509_NAME; cdecl
  function  f_X509_set_notBefore(x: PX509; tm: PASN1_STRING):Integer; cdecl
  function  f_X509_set_notAfter(x: PX509; tm: PASN1_STRING):Integer; cdecl
  function  f_X509_set_pubkey(x: PX509; pkey: PEVP_PKEY):Integer; cdecl
  function  f_X509_get_pubkey(x: PX509):PEVP_PKEY; cdecl
  function  f_X509_certificate_type(x: PX509; pubkey: PEVP_PKEY):Integer; cdecl
  function  f_X509_REQ_set_version(x: PX509_REQ; version: Longint):Integer; cdecl
  function  f_X509_REQ_set_subject_name(req: PX509_REQ; name: PX509_NAME):Integer; cdecl
  function  f_X509_REQ_set_pubkey(x: PX509_REQ; pkey: PEVP_PKEY):Integer; cdecl
  function  f_X509_REQ_get_pubkey(req: PX509_REQ):PEVP_PKEY; cdecl
  function  f_X509_check_private_key(x509: PX509; pkey: PEVP_PKEY):Integer; cdecl
  function  f_X509_issuer_and_serial_cmp(a: PX509; b: PX509):Integer; cdecl
  function  f_X509_issuer_and_serial_hash(a: PX509):Cardinal; cdecl
  function  f_X509_issuer_name_cmp(a: PX509; b: PX509):Integer; cdecl
  function  f_X509_issuer_name_hash(a: PX509):Cardinal; cdecl
  function  f_X509_subject_name_cmp(a: PX509; b: PX509):Integer; cdecl
  function  f_X509_subject_name_hash(x: PX509):Cardinal; cdecl
  function  f_X509_NAME_cmp(a: PX509_NAME; b: PX509_NAME):Integer; cdecl
  function  f_X509_NAME_hash(x: PX509_NAME):Cardinal; cdecl
  function  f_X509_CRL_cmp(a: PX509_CRL; b: PX509_CRL):Integer; cdecl
  function  f_X509_print_fp(bp: PFILE; x: PX509):Integer; cdecl
  function  f_X509_CRL_print_fp(bp: PFILE; x: PX509_CRL):Integer; cdecl
  function  f_X509_REQ_print_fp(bp: PFILE; req: PX509_REQ):Integer; cdecl
  function  f_X509_NAME_print(bp: PBIO; name: PX509_NAME; obase: Integer):Integer; cdecl
  function  f_X509_print(bp: PBIO; x: PX509):Integer; cdecl
  function  f_X509_CRL_print(bp: PBIO; x: PX509_CRL):Integer; cdecl
  function  f_X509_REQ_print(bp: PBIO; req: PX509_REQ):Integer; cdecl
  function  f_X509_NAME_entry_count(name: PX509_NAME):Integer; cdecl
  function  f_X509_NAME_get_text_by_NID(name: PX509_NAME; nid: Integer; buf: PChar; len: Integer):Integer; cdecl
  function  f_X509_NAME_get_text_by_OBJ(name: PX509_NAME; obj: PASN1_OBJECT; buf: PChar; len: Integer):Integer; cdecl
  function  f_X509_NAME_get_index_by_NID(name: PX509_NAME; nid: Integer; lastpos: Integer):Integer; cdecl
  function  f_X509_NAME_get_index_by_OBJ(name: PX509_NAME; obj: PASN1_OBJECT; lastpos: Integer):Integer; cdecl
  function  f_X509_NAME_get_entry(name: PX509_NAME; loc: Integer):PX509_NAME_ENTRY; cdecl
  function  f_X509_NAME_delete_entry(name: PX509_NAME; loc: Integer):PX509_NAME_ENTRY; cdecl
  function  f_X509_NAME_add_entry(name: PX509_NAME; ne: PX509_NAME_ENTRY; loc: Integer; _set: Integer):Integer; cdecl
  function  f_X509_NAME_ENTRY_create_by_NID(ne: PPX509_NAME_ENTRY; nid: Integer; _type: Integer; bytes: PChar; len: Integer):PX509_NAME_ENTRY; cdecl
  function  f_X509_NAME_ENTRY_create_by_OBJ(ne: PPX509_NAME_ENTRY; obj: PASN1_OBJECT; _type: Integer; bytes: PChar; len: Integer):PX509_NAME_ENTRY; cdecl
  function  f_X509_NAME_ENTRY_set_object(ne: PX509_NAME_ENTRY; obj: PASN1_OBJECT):Integer; cdecl
  function  f_X509_NAME_ENTRY_set_data(ne: PX509_NAME_ENTRY; _type: Integer; bytes: PChar; len: Integer):Integer; cdecl
  function  f_X509_NAME_ENTRY_get_object(ne: PX509_NAME_ENTRY):PASN1_OBJECT; cdecl
  function  f_X509_NAME_ENTRY_get_data(ne: PX509_NAME_ENTRY):PASN1_STRING; cdecl
  function  f_X509v3_get_ext_count(const x: PSTACK_X509_EXTENSION):Integer; cdecl
  function  f_X509v3_get_ext_by_NID(const x: PSTACK_X509_EXTENSION; nid: Integer; lastpos: Integer):Integer; cdecl
  function  f_X509v3_get_ext_by_OBJ(const x: PSTACK_X509_EXTENSION; obj: PASN1_OBJECT; lastpos: Integer):Integer; cdecl
  function  f_X509v3_get_ext_by_critical(const x: PSTACK_X509_EXTENSION; crit: Integer; lastpos: Integer):Integer; cdecl
  function  f_X509v3_get_ext(const x: PSTACK_X509_EXTENSION; loc: Integer):PX509_EXTENSION; cdecl
  function  f_X509v3_delete_ext(x: PSTACK_X509_EXTENSION; loc: Integer):PX509_EXTENSION; cdecl
  function  f_X509v3_add_ext(x: PPSTACK_X509_EXTENSION; ex: PX509_EXTENSION; loc: Integer):PSTACK_X509_EXTENSION; cdecl
  function  f_X509_get_ext_count(x: PX509):Integer; cdecl
  function  f_X509_get_ext_by_NID(x: PX509; nid: Integer; lastpos: Integer):Integer; cdecl
  function  f_X509_get_ext_by_OBJ(x: PX509; obj: PASN1_OBJECT; lastpos: Integer):Integer; cdecl
  function  f_X509_get_ext_by_critical(x: PX509; crit: Integer; lastpos: Integer):Integer; cdecl
  function  f_X509_get_ext(x: PX509; loc: Integer):PX509_EXTENSION; cdecl
  function  f_X509_delete_ext(x: PX509; loc: Integer):PX509_EXTENSION; cdecl
  function  f_X509_add_ext(x: PX509; ex: PX509_EXTENSION; loc: Integer):Integer; cdecl
  function  f_X509_CRL_get_ext_count(x: PX509_CRL):Integer; cdecl
  function  f_X509_CRL_get_ext_by_NID(x: PX509_CRL; nid: Integer; lastpos: Integer):Integer; cdecl
  function  f_X509_CRL_get_ext_by_OBJ(x: PX509_CRL; obj: PASN1_OBJECT; lastpos: Integer):Integer; cdecl
  function  f_X509_CRL_get_ext_by_critical(x: PX509_CRL; crit: Integer; lastpos: Integer):Integer; cdecl
  function  f_X509_CRL_get_ext(x: PX509_CRL; loc: Integer):PX509_EXTENSION; cdecl
  function  f_X509_CRL_delete_ext(x: PX509_CRL; loc: Integer):PX509_EXTENSION; cdecl
  function  f_X509_CRL_add_ext(x: PX509_CRL; ex: PX509_EXTENSION; loc: Integer):Integer; cdecl
  function  f_X509_REVOKED_get_ext_count(x: PX509_REVOKED):Integer; cdecl
  function  f_X509_REVOKED_get_ext_by_NID(x: PX509_REVOKED; nid: Integer; lastpos: Integer):Integer; cdecl
  function  f_X509_REVOKED_get_ext_by_OBJ(x: PX509_REVOKED; obj: PASN1_OBJECT; lastpos: Integer):Integer; cdecl
  function  f_X509_REVOKED_get_ext_by_critical(x: PX509_REVOKED; crit: Integer; lastpos: Integer):Integer; cdecl
  function  f_X509_REVOKED_get_ext(x: PX509_REVOKED; loc: Integer):PX509_EXTENSION; cdecl
  function  f_X509_REVOKED_delete_ext(x: PX509_REVOKED; loc: Integer):PX509_EXTENSION; cdecl
  function  f_X509_REVOKED_add_ext(x: PX509_REVOKED; ex: PX509_EXTENSION; loc: Integer):Integer; cdecl
  function  f_X509_EXTENSION_create_by_NID(ex: PPX509_EXTENSION; nid: Integer; crit: Integer; data: PASN1_STRING):PX509_EXTENSION; cdecl
  function  f_X509_EXTENSION_create_by_OBJ(ex: PPX509_EXTENSION; obj: PASN1_OBJECT; crit: Integer; data: PASN1_STRING):PX509_EXTENSION; cdecl
  function  f_X509_EXTENSION_set_object(ex: PX509_EXTENSION; obj: PASN1_OBJECT):Integer; cdecl
  function  f_X509_EXTENSION_set_critical(ex: PX509_EXTENSION; crit: Integer):Integer; cdecl
  function  f_X509_EXTENSION_set_data(ex: PX509_EXTENSION; data: PASN1_STRING):Integer; cdecl
  function  f_X509_EXTENSION_get_object(ex: PX509_EXTENSION):PASN1_OBJECT; cdecl
  function  f_X509_EXTENSION_get_data(ne: PX509_EXTENSION):PASN1_STRING; cdecl
  function  f_X509_EXTENSION_get_critical(ex: PX509_EXTENSION):Integer; cdecl
  function  f_X509_verify_cert(ctx: PX509_STORE_CTX):Integer; cdecl
  function  f_X509_find_by_issuer_and_serial(sk: PSTACK_X509; name: PX509_NAME; serial: PASN1_STRING):PX509; cdecl
  function  f_X509_find_by_subject(sk: PSTACK_X509; name: PX509_NAME):PX509; cdecl
  function  f_i2d_PBEPARAM(a: PPBEPARAM; pp: PPChar):Integer; cdecl
  function  f_PBEPARAM_new:PPBEPARAM; cdecl
  function  f_d2i_PBEPARAM(a: PPPBEPARAM; pp: PPChar; length: Longint):PPBEPARAM; cdecl
  procedure f_PBEPARAM_free(a: PPBEPARAM); cdecl;
  function  f_PKCS5_pbe_set(alg: Integer; iter: Integer; salt: PChar; saltlen: Integer):PX509_ALGOR; cdecl
  function  f_PKCS5_pbe2_set(const cipher: PEVP_CIPHER; iter: Integer; salt: PChar; saltlen: Integer):PX509_ALGOR; cdecl
  function  f_i2d_PBKDF2PARAM(a: PPBKDF2PARAM; pp: PPChar):Integer; cdecl
  function  f_PBKDF2PARAM_new:PPBKDF2PARAM; cdecl
  function  f_d2i_PBKDF2PARAM(a: PPPBKDF2PARAM; pp: PPChar; length: Longint):PPBKDF2PARAM; cdecl
  procedure f_PBKDF2PARAM_free(a: PPBKDF2PARAM); cdecl;
  function  f_i2d_PBE2PARAM(a: PPBE2PARAM; pp: PPChar):Integer; cdecl
  function  f_PBE2PARAM_new:PPBE2PARAM; cdecl
  function  f_d2i_PBE2PARAM(a: PPPBE2PARAM; pp: PPChar; length: Longint):PPBE2PARAM; cdecl
  procedure f_PBE2PARAM_free(a: PPBE2PARAM); cdecl;
  function  f_i2d_PKCS8_PRIV_KEY_INFO(a: PPKCS8_PRIV_KEY_INFO; pp: PPChar):Integer; cdecl
  function  f_PKCS8_PRIV_KEY_INFO_new:PPKCS8_PRIV_KEY_INFO; cdecl
  function  f_d2i_PKCS8_PRIV_KEY_INFO(a: PPPKCS8_PRIV_KEY_INFO; pp: PPChar; length: Longint):PPKCS8_PRIV_KEY_INFO; cdecl
  procedure f_PKCS8_PRIV_KEY_INFO_free(a: PPKCS8_PRIV_KEY_INFO); cdecl;
  function  f_EVP_PKCS82PKEY(p8: PPKCS8_PRIV_KEY_INFO):PEVP_PKEY; cdecl
  function  f_EVP_PKEY2PKCS8(pkey: PEVP_PKEY):PPKCS8_PRIV_KEY_INFO; cdecl
  function  f_PKCS8_set_broken(p8: PPKCS8_PRIV_KEY_INFO; broken: Integer):PPKCS8_PRIV_KEY_INFO; cdecl
  procedure f_ERR_load_PEM_strings; cdecl;
  function  f_PEM_get_EVP_CIPHER_INFO(header: PChar; cipher: PEVP_CIPHER_INFO):Integer; cdecl
  function  f_PEM_do_header(cipher: PEVP_CIPHER_INFO; data: PChar; len: PLong; callback: Ppem_password_cb; u: Pointer):Integer; cdecl
  function  f_PEM_read_bio(bp: PBIO; name: PPChar; header: PPChar; data: PPChar; len: PLong):Integer; cdecl
  function  f_PEM_write_bio(bp: PBIO; const name: PChar; hdr: PChar; data: PChar; len: Longint):Integer; cdecl
  function  f_PEM_ASN1_read_bio(arg0: PFunction; const name: PChar; bp: PBIO; x: PPChar; cb: Ppem_password_cb; u: Pointer):PChar; cdecl
  function  f_PEM_ASN1_write_bio(arg0: PFunction; const name: PChar; bp: PBIO; x: PChar; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; cdecl
  function  f_PEM_X509_INFO_read_bio(bp: PBIO; sk: PSTACK_X509_INFO; cb: Ppem_password_cb; u: Pointer):PSTACK_X509_INFO; cdecl
  function  f_PEM_X509_INFO_write_bio(bp: PBIO; xi: PX509_INFO; enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cd: Ppem_password_cb; u: Pointer):Integer; cdecl
  function  f_PEM_read(fp: PFILE; name: PPChar; header: PPChar; data: PPChar; len: PLong):Integer; cdecl
  function  f_PEM_write(fp: PFILE; name: PChar; hdr: PChar; data: PChar; len: Longint):Integer; cdecl
  function  f_PEM_ASN1_read(arg0: PFunction; const name: PChar; fp: PFILE; x: PPChar; cb: Ppem_password_cb; u: Pointer):PChar; cdecl
  function  f_PEM_ASN1_write(arg0: PFunction; const name: PChar; fp: PFILE; x: PChar; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; callback: Ppem_password_cb; u: Pointer):Integer; cdecl
  function  f_PEM_X509_INFO_read(fp: PFILE; sk: PSTACK_X509_INFO; cb: Ppem_password_cb; u: Pointer):PSTACK_X509_INFO; cdecl
  function  f_PEM_SealInit(ctx: PPEM_ENCODE_SEAL_CTX; _type: PEVP_CIPHER; md_type: PEVP_MD; ek: PPChar; ekl: PInteger; iv: PChar; pubk: PPEVP_PKEY; npubk: Integer):Integer; cdecl
  procedure f_PEM_SealUpdate(ctx: PPEM_ENCODE_SEAL_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer); cdecl;
  function  f_PEM_SealFinal(ctx: PPEM_ENCODE_SEAL_CTX; sig: PChar; sigl: PInteger; _out: PChar; outl: PInteger; priv: PEVP_PKEY):Integer; cdecl
  procedure f_PEM_SignInit(ctx: PEVP_MD_CTX; _type: PEVP_MD); cdecl;
  procedure f_PEM_SignUpdate(ctx: PEVP_MD_CTX; d: PChar; cnt: UInteger); cdecl;
  function  f_PEM_SignFinal(ctx: PEVP_MD_CTX; sigret: PChar; siglen: PUInteger; pkey: PEVP_PKEY):Integer; cdecl
  procedure f_PEM_proc_type(buf: PChar; _type: Integer); cdecl;
  procedure f_PEM_dek_info(buf: PChar; const _type: PChar; len: Integer; str: PChar); cdecl;
  function  f_PEM_read_bio_X509(bp: PBIO; x: PPX509; cb: Ppem_password_cb; u: Pointer):PX509; cdecl
  function  f_PEM_read_X509(fp: PFILE; x: PPX509; cb: Ppem_password_cb; u: Pointer):PX509; cdecl
  function  f_PEM_write_bio_X509(bp: PBIO; x: PX509):Integer; cdecl
  function  f_PEM_write_X509(fp: PFILE; x: PX509):Integer; cdecl
  function  f_PEM_read_bio_X509_REQ(bp: PBIO; x: PPX509_REQ; cb: Ppem_password_cb; u: Pointer):PX509_REQ; cdecl
  function  f_PEM_read_X509_REQ(fp: PFILE; x: PPX509_REQ; cb: Ppem_password_cb; u: Pointer):PX509_REQ; cdecl
  function  f_PEM_write_bio_X509_REQ(bp: PBIO; x: PX509_REQ):Integer; cdecl
  function  f_PEM_write_X509_REQ(fp: PFILE; x: PX509_REQ):Integer; cdecl
  function  f_PEM_read_bio_X509_CRL(bp: PBIO; x: PPX509_CRL; cb: Ppem_password_cb; u: Pointer):PX509_CRL; cdecl
  function  f_PEM_read_X509_CRL(fp: PFILE; x: PPX509_CRL; cb: Ppem_password_cb; u: Pointer):PX509_CRL; cdecl
  function  f_PEM_write_bio_X509_CRL(bp: PBIO; x: PX509_CRL):Integer; cdecl
  function  f_PEM_write_X509_CRL(fp: PFILE; x: PX509_CRL):Integer; cdecl
  function  f_PEM_read_bio_PKCS7(bp: PBIO; x: PPPKCS7; cb: Ppem_password_cb; u: Pointer):PPKCS7; cdecl
  function  f_PEM_read_PKCS7(fp: PFILE; x: PPPKCS7; cb: Ppem_password_cb; u: Pointer):PPKCS7; cdecl
  function  f_PEM_write_bio_PKCS7(bp: PBIO; x: PPKCS7):Integer; cdecl
  function  f_PEM_write_PKCS7(fp: PFILE; x: PPKCS7):Integer; cdecl
  function  f_PEM_read_bio_NETSCAPE_CERT_SEQUENCE(bp: PBIO; x: PPNETSCAPE_CERT_SEQUENCE; cb: Ppem_password_cb; u: Pointer):PNETSCAPE_CERT_SEQUENCE; cdecl
  function  f_PEM_read_NETSCAPE_CERT_SEQUENCE(fp: PFILE; x: PPNETSCAPE_CERT_SEQUENCE; cb: Ppem_password_cb; u: Pointer):PNETSCAPE_CERT_SEQUENCE; cdecl
  function  f_PEM_write_bio_NETSCAPE_CERT_SEQUENCE(bp: PBIO; x: PNETSCAPE_CERT_SEQUENCE):Integer; cdecl
  function  f_PEM_write_NETSCAPE_CERT_SEQUENCE(fp: PFILE; x: PNETSCAPE_CERT_SEQUENCE):Integer; cdecl
  function  f_PEM_read_bio_PKCS8(bp: PBIO; x: PPX509_SIG; cb: Ppem_password_cb; u: Pointer):PX509_SIG; cdecl
  function  f_PEM_read_PKCS8(fp: PFILE; x: PPX509_SIG; cb: Ppem_password_cb; u: Pointer):PX509_SIG; cdecl
  function  f_PEM_write_bio_PKCS8(bp: PBIO; x: PX509_SIG):Integer; cdecl
  function  f_PEM_write_PKCS8(fp: PFILE; x: PX509_SIG):Integer; cdecl
  function  f_PEM_read_bio_PKCS8_PRIV_KEY_INFO(bp: PBIO; x: PPPKCS8_PRIV_KEY_INFO; cb: Ppem_password_cb; u: Pointer):PPKCS8_PRIV_KEY_INFO; cdecl
  function  f_PEM_read_PKCS8_PRIV_KEY_INFO(fp: PFILE; x: PPPKCS8_PRIV_KEY_INFO; cb: Ppem_password_cb; u: Pointer):PPKCS8_PRIV_KEY_INFO; cdecl
  function  f_PEM_write_bio_PKCS8_PRIV_KEY_INFO(bp: PBIO; x: PPKCS8_PRIV_KEY_INFO):Integer; cdecl
  function  f_PEM_write_PKCS8_PRIV_KEY_INFO(fp: PFILE; x: PPKCS8_PRIV_KEY_INFO):Integer; cdecl
  function  f_PEM_read_bio_RSAPrivateKey(bp: PBIO; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA; cdecl
  function  f_PEM_read_RSAPrivateKey(fp: PFILE; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA; cdecl
  function  f_PEM_write_bio_RSAPrivateKey(bp: PBIO; x: PRSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; cdecl
  function  f_PEM_write_RSAPrivateKey(fp: PFILE; x: PRSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; cdecl
  function  f_PEM_read_bio_RSAPublicKey(bp: PBIO; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA; cdecl
  function  f_PEM_read_RSAPublicKey(fp: PFILE; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA; cdecl
  function  f_PEM_write_bio_RSAPublicKey(bp: PBIO; x: PRSA):Integer; cdecl
  function  f_PEM_write_RSAPublicKey(fp: PFILE; x: PRSA):Integer; cdecl
  function  f_PEM_read_bio_DSAPrivateKey(bp: PBIO; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA; cdecl
  function  f_PEM_read_DSAPrivateKey(fp: PFILE; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA; cdecl
  function  f_PEM_write_bio_DSAPrivateKey(bp: PBIO; x: PDSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; cdecl
  function  f_PEM_write_DSAPrivateKey(fp: PFILE; x: PDSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; cdecl
  function  f_PEM_read_bio_DSAparams(bp: PBIO; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA; cdecl
  function  f_PEM_read_DSAparams(fp: PFILE; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA; cdecl
  function  f_PEM_write_bio_DSAparams(bp: PBIO; x: PDSA):Integer; cdecl
  function  f_PEM_write_DSAparams(fp: PFILE; x: PDSA):Integer; cdecl
  function  f_PEM_read_bio_DHparams(bp: PBIO; x: PPDH; cb: Ppem_password_cb; u: Pointer):PDH; cdecl
  function  f_PEM_read_DHparams(fp: PFILE; x: PPDH; cb: Ppem_password_cb; u: Pointer):PDH; cdecl
  function  f_PEM_write_bio_DHparams(bp: PBIO; x: PDH):Integer; cdecl
  function  f_PEM_write_DHparams(fp: PFILE; x: PDH):Integer; cdecl
  function  f_PEM_read_bio_PrivateKey(bp: PBIO; x: PPEVP_PKEY; cb: Ppem_password_cb; u: Pointer):PEVP_PKEY; cdecl
  function  f_PEM_read_PrivateKey(fp: PFILE; x: PPEVP_PKEY; cb: Ppem_password_cb; u: Pointer):PEVP_PKEY; cdecl
  function  f_PEM_write_bio_PrivateKey(bp: PBIO; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; cdecl
  function  f_PEM_write_PrivateKey(fp: PFILE; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; cdecl
  function  f_PEM_write_bio_PKCS8PrivateKey(arg0: PBIO; arg1: PEVP_PKEY; const arg2: PEVP_CIPHER; arg3: PChar; arg4: Integer; arg5: Ppem_password_cb; arg6: Pointer):Integer; cdecl
  function  f_PEM_write_PKCS8PrivateKey(fp: PFILE; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cd: Ppem_password_cb; u: Pointer):Integer; cdecl
  function  f_sk_SSL_CIPHER_new(arg0: PFunction):PSTACK_SSL_CIPHER; cdecl
  function  f_sk_SSL_CIPHER_new_null:PSTACK_SSL_CIPHER; cdecl
  procedure f_sk_SSL_CIPHER_free(sk: PSTACK_SSL_CIPHER); cdecl;
  function  f_sk_SSL_CIPHER_num(const sk: PSTACK_SSL_CIPHER):Integer; cdecl
  function  f_sk_SSL_CIPHER_value(const sk: PSTACK_SSL_CIPHER; n: Integer):PSSL_CIPHER; cdecl
  function  f_sk_SSL_CIPHER_set(sk: PSTACK_SSL_CIPHER; n: Integer; v: PSSL_CIPHER):PSSL_CIPHER; cdecl
  procedure f_sk_SSL_CIPHER_zero(sk: PSTACK_SSL_CIPHER); cdecl;
  function  f_sk_SSL_CIPHER_push(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER):Integer; cdecl
  function  f_sk_SSL_CIPHER_unshift(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER):Integer; cdecl
  function  f_sk_SSL_CIPHER_find(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER):Integer; cdecl
  function  f_sk_SSL_CIPHER_delete(sk: PSTACK_SSL_CIPHER; n: Integer):PSSL_CIPHER; cdecl
  procedure f_sk_SSL_CIPHER_delete_ptr(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER); cdecl;
  function  f_sk_SSL_CIPHER_insert(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER; n: Integer):Integer; cdecl
  function  f_sk_SSL_CIPHER_dup(sk: PSTACK_SSL_CIPHER):PSTACK_SSL_CIPHER; cdecl
  procedure f_sk_SSL_CIPHER_pop_free(sk: PSTACK_SSL_CIPHER; arg1: PFunction); cdecl;
  function  f_sk_SSL_CIPHER_shift(sk: PSTACK_SSL_CIPHER):PSSL_CIPHER; cdecl
  function  f_sk_SSL_CIPHER_pop(sk: PSTACK_SSL_CIPHER):PSSL_CIPHER; cdecl
  procedure f_sk_SSL_CIPHER_sort(sk: PSTACK_SSL_CIPHER); cdecl;
  function  f_sk_SSL_COMP_new(arg0: PFunction):PSTACK_SSL_COMP; cdecl
  function  f_sk_SSL_COMP_new_null:PSTACK_SSL_COMP; cdecl
  procedure f_sk_SSL_COMP_free(sk: PSTACK_SSL_COMP); cdecl;
  function  f_sk_SSL_COMP_num(const sk: PSTACK_SSL_COMP):Integer; cdecl
  function  f_sk_SSL_COMP_value(const sk: PSTACK_SSL_COMP; n: Integer):PSSL_COMP; cdecl
  function  f_sk_SSL_COMP_set(sk: PSTACK_SSL_COMP; n: Integer; v: PSSL_COMP):PSSL_COMP; cdecl
  procedure f_sk_SSL_COMP_zero(sk: PSTACK_SSL_COMP); cdecl;
  function  f_sk_SSL_COMP_push(sk: PSTACK_SSL_COMP; v: PSSL_COMP):Integer; cdecl
  function  f_sk_SSL_COMP_unshift(sk: PSTACK_SSL_COMP; v: PSSL_COMP):Integer; cdecl
  function  f_sk_SSL_COMP_find(sk: PSTACK_SSL_COMP; v: PSSL_COMP):Integer; cdecl
  function  f_sk_SSL_COMP_delete(sk: PSTACK_SSL_COMP; n: Integer):PSSL_COMP; cdecl
  procedure f_sk_SSL_COMP_delete_ptr(sk: PSTACK_SSL_COMP; v: PSSL_COMP); cdecl;
  function  f_sk_SSL_COMP_insert(sk: PSTACK_SSL_COMP; v: PSSL_COMP; n: Integer):Integer; cdecl
  function  f_sk_SSL_COMP_dup(sk: PSTACK_SSL_COMP):PSTACK_SSL_COMP; cdecl
  procedure f_sk_SSL_COMP_pop_free(sk: PSTACK_SSL_COMP; arg1: PFunction); cdecl;
  function  f_sk_SSL_COMP_shift(sk: PSTACK_SSL_COMP):PSSL_COMP; cdecl
  function  f_sk_SSL_COMP_pop(sk: PSTACK_SSL_COMP):PSSL_COMP; cdecl
  procedure f_sk_SSL_COMP_sort(sk: PSTACK_SSL_COMP); cdecl;
  function  f_BIO_f_ssl:PBIO_METHOD; cdecl
  function  f_BIO_new_ssl(ctx: PSSL_CTX; client: Integer):PBIO; cdecl
  function  f_BIO_new_ssl_connect(ctx: PSSL_CTX):PBIO; cdecl
  function  f_BIO_new_buffer_ssl_connect(ctx: PSSL_CTX):PBIO; cdecl
  function  f_BIO_ssl_copy_session_id(_to: PBIO; from: PBIO):Integer; cdecl
  procedure f_BIO_ssl_shutdown(ssl_bio: PBIO); cdecl;
  function  f_SSL_CTX_set_cipher_list(arg0: PSSL_CTX; str: PChar):Integer; cdecl
  function  f_SSL_CTX_new(meth: PSSL_METHOD):PSSL_CTX; cdecl
  procedure f_SSL_CTX_free(arg0: PSSL_CTX); cdecl;
  function  f_SSL_CTX_set_timeout(ctx: PSSL_CTX; t: Longint):Longint; cdecl
  function  f_SSL_CTX_get_timeout(ctx: PSSL_CTX):Longint; cdecl
  function  f_SSL_CTX_get_cert_store(arg0: PSSL_CTX):PX509_STORE; cdecl
  procedure f_SSL_CTX_set_cert_store(arg0: PSSL_CTX; arg1: PX509_STORE); cdecl;
  function  f_SSL_want(s: PSSL):Integer; cdecl
  function  f_SSL_clear(s: PSSL):Integer; cdecl
  procedure f_SSL_CTX_flush_sessions(ctx: PSSL_CTX; tm: Longint); cdecl;
  function  f_SSL_get_current_cipher(s: PSSL):PSSL_CIPHER; cdecl
  function  f_SSL_CIPHER_get_bits(c: PSSL_CIPHER; alg_bits: PInteger):Integer; cdecl
  function  f_SSL_CIPHER_get_version(c: PSSL_CIPHER):PChar; cdecl
  function  f_SSL_CIPHER_get_name(c: PSSL_CIPHER):PChar; cdecl
  function  f_SSL_get_fd(s: PSSL):Integer; cdecl
  function  f_SSL_get_cipher_list(s: PSSL; n: Integer):PChar; cdecl
  function  f_SSL_get_shared_ciphers(s: PSSL; buf: PChar; len: Integer):PChar; cdecl
  function  f_SSL_get_read_ahead(s: PSSL):Integer; cdecl
  function  f_SSL_pending(s: PSSL):Integer; cdecl
  function  f_SSL_set_fd(s: PSSL; fd: Integer):Integer; cdecl
  function  f_SSL_set_rfd(s: PSSL; fd: Integer):Integer; cdecl
  function  f_SSL_set_wfd(s: PSSL; fd: Integer):Integer; cdecl
  procedure f_SSL_set_bio(s: PSSL; rbio: PBIO; wbio: PBIO); cdecl;
  function  f_SSL_get_rbio(s: PSSL):PBIO; cdecl
  function  f_SSL_get_wbio(s: PSSL):PBIO; cdecl
  function  f_SSL_set_cipher_list(s: PSSL; str: PChar):Integer; cdecl
  procedure f_SSL_set_read_ahead(s: PSSL; yes: Integer); cdecl;
  function  f_SSL_get_verify_mode(s: PSSL):Integer; cdecl
  function  f_SSL_get_verify_depth(s: PSSL):Integer; cdecl
  procedure f_SSL_set_verify(s: PSSL; mode: Integer; arg2: PFunction); cdecl;
  procedure f_SSL_set_verify_depth(s: PSSL; depth: Integer); cdecl;
  function  f_SSL_use_RSAPrivateKey(ssl: PSSL; rsa: PRSA):Integer; cdecl
  function  f_SSL_use_RSAPrivateKey_ASN1(ssl: PSSL; d: PChar; len: Longint):Integer; cdecl
  function  f_SSL_use_PrivateKey(ssl: PSSL; pkey: PEVP_PKEY):Integer; cdecl
  function  f_SSL_use_PrivateKey_ASN1(pk: Integer; ssl: PSSL; d: PChar; len: Longint):Integer; cdecl
  function  f_SSL_use_certificate(ssl: PSSL; x: PX509):Integer; cdecl
  function  f_SSL_use_certificate_ASN1(ssl: PSSL; d: PChar; len: Integer):Integer; cdecl
  function  f_SSL_use_RSAPrivateKey_file(ssl: PSSL; const _file: PChar; _type: Integer):Integer; cdecl
  function  f_SSL_use_PrivateKey_file(ssl: PSSL; const _file: PChar; _type: Integer):Integer; cdecl
  function  f_SSL_use_certificate_file(ssl: PSSL; const _file: PChar; _type: Integer):Integer; cdecl
  function  f_SSL_CTX_use_RSAPrivateKey_file(ctx: PSSL_CTX; const _file: PChar; _type: Integer):Integer; cdecl
  function  f_SSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const _file: PChar; _type: Integer):Integer; cdecl
  function  f_SSL_CTX_use_certificate_file(ctx: PSSL_CTX; const _file: PChar; _type: Integer):Integer; cdecl
  function  f_SSL_CTX_use_certificate_chain_file(ctx: PSSL_CTX; const _file: PChar):Integer; cdecl
  function  f_SSL_load_client_CA_file(const _file: PChar):PSTACK_X509_NAME; cdecl
  function  f_SSL_add_file_cert_subjects_to_stack(stackCAs: PSTACK_X509_NAME; const _file: PChar):Integer; cdecl
  procedure f_ERR_load_SSL_strings; cdecl;
  procedure f_SSL_load_error_strings; cdecl;
  function  f_SSL_state_string(s: PSSL):PChar; cdecl
  function  f_SSL_rstate_string(s: PSSL):PChar; cdecl
  function  f_SSL_state_string_long(s: PSSL):PChar; cdecl
  function  f_SSL_rstate_string_long(s: PSSL):PChar; cdecl
  function  f_SSL_SESSION_get_time(s: PSSL_SESSION):Longint; cdecl
  function  f_SSL_SESSION_set_time(s: PSSL_SESSION; t: Longint):Longint; cdecl
  function  f_SSL_SESSION_get_timeout(s: PSSL_SESSION):Longint; cdecl
  function  f_SSL_SESSION_set_timeout(s: PSSL_SESSION; t: Longint):Longint; cdecl
  procedure f_SSL_copy_session_id(_to: PSSL; from: PSSL); cdecl;
  function  f_SSL_SESSION_new:PSSL_SESSION; cdecl
  function  f_SSL_SESSION_hash(a: PSSL_SESSION):Cardinal; cdecl
  function  f_SSL_SESSION_cmp(a: PSSL_SESSION; b: PSSL_SESSION):Integer; cdecl
  function  f_SSL_SESSION_print_fp(fp: PFILE; ses: PSSL_SESSION):Integer; cdecl
  function  f_SSL_SESSION_print(fp: PBIO; ses: PSSL_SESSION):Integer; cdecl
  procedure f_SSL_SESSION_free(ses: PSSL_SESSION); cdecl;
  function  f_i2d_SSL_SESSION(_in: PSSL_SESSION; pp: PPChar):Integer; cdecl
  function  f_SSL_set_session(_to: PSSL; session: PSSL_SESSION):Integer; cdecl
  function  f_SSL_CTX_add_session(s: PSSL_CTX; c: PSSL_SESSION):Integer; cdecl
  function  f_SSL_CTX_remove_session(arg0: PSSL_CTX; c: PSSL_SESSION):Integer; cdecl
  function  f_d2i_SSL_SESSION(a: PPSSL_SESSION; pp: PPChar; length: Longint):PSSL_SESSION; cdecl
  function  f_SSL_get_peer_certificate(s: PSSL):PX509; cdecl
  function  f_SSL_get_peer_cert_chain(s: PSSL):PSTACK_X509; cdecl
  function  f_SSL_CTX_get_verify_mode(ctx: PSSL_CTX):Integer; cdecl
  function  f_SSL_CTX_get_verify_depth(ctx: PSSL_CTX):Integer; cdecl
  procedure f_SSL_CTX_set_verify(ctx: PSSL_CTX; mode: Integer; arg2: PFunction); cdecl;
  procedure f_SSL_CTX_set_verify_depth(ctx: PSSL_CTX; depth: Integer); cdecl;
  procedure f_SSL_CTX_set_cert_verify_callback(ctx: PSSL_CTX; arg1: PFunction; arg: PChar); cdecl;
  function  f_SSL_CTX_use_RSAPrivateKey(ctx: PSSL_CTX; rsa: PRSA):Integer; cdecl
  function  f_SSL_CTX_use_RSAPrivateKey_ASN1(ctx: PSSL_CTX; d: PChar; len: Longint):Integer; cdecl
  function  f_SSL_CTX_use_PrivateKey(ctx: PSSL_CTX; pkey: PEVP_PKEY):Integer; cdecl
  function  f_SSL_CTX_use_PrivateKey_ASN1(pk: Integer; ctx: PSSL_CTX; d: PChar; len: Longint):Integer; cdecl
  function  f_SSL_CTX_use_certificate(ctx: PSSL_CTX; x: PX509):Integer; cdecl
  function  f_SSL_CTX_use_certificate_ASN1(ctx: PSSL_CTX; len: Integer; d: PChar):Integer; cdecl
  procedure f_SSL_CTX_set_default_passwd_cb(ctx: PSSL_CTX; cb: Ppem_password_cb); cdecl;
  procedure f_SSL_CTX_set_default_passwd_cb_userdata(ctx: PSSL_CTX; u: Pointer); cdecl;
  function  f_SSL_CTX_check_private_key(ctx: PSSL_CTX):Integer; cdecl
  function  f_SSL_check_private_key(ctx: PSSL):Integer; cdecl
  function  f_SSL_CTX_set_session_id_context(ctx: PSSL_CTX; const sid_ctx: PChar; sid_ctx_len: UInteger):Integer; cdecl
  function  f_SSL_new(ctx: PSSL_CTX):PSSL; cdecl
  function  f_SSL_set_session_id_context(ssl: PSSL; const sid_ctx: PChar; sid_ctx_len: UInteger):Integer; cdecl
  procedure f_SSL_free(ssl: PSSL); cdecl;
  function  f_SSL_accept(ssl: PSSL):Integer; cdecl
  function  f_SSL_connect(ssl: PSSL):Integer; cdecl
  function  f_SSL_read(ssl: PSSL; buf: PChar; num: Integer):Integer; cdecl
  function  f_SSL_peek(ssl: PSSL; buf: PChar; num: Integer):Integer; cdecl
  function  f_SSL_write(ssl: PSSL; const buf: PChar; num: Integer):Integer; cdecl
  function  f_SSL_ctrl(ssl: PSSL; cmd: Integer; larg: Longint; parg: PChar):Longint; cdecl
  function  f_SSL_CTX_ctrl(ctx: PSSL_CTX; cmd: Integer; larg: Longint; parg: PChar):Longint; cdecl
  function  f_SSL_get_error(s: PSSL; ret_code: Integer):Integer; cdecl
  function  f_SSL_get_version(s: PSSL):PChar; cdecl
  function  f_SSL_CTX_set_ssl_version(ctx: PSSL_CTX; meth: PSSL_METHOD):Integer; cdecl
  function  f_SSLv2_method:PSSL_METHOD; cdecl
  function  f_SSLv2_server_method:PSSL_METHOD; cdecl
  function  f_SSLv2_client_method:PSSL_METHOD; cdecl
  function  f_SSLv3_method:PSSL_METHOD; cdecl
  function  f_SSLv3_server_method:PSSL_METHOD; cdecl
  function  f_SSLv3_client_method:PSSL_METHOD; cdecl
  function  f_SSLv23_method:PSSL_METHOD; cdecl
  function  f_SSLv23_server_method:PSSL_METHOD; cdecl
  function  f_SSLv23_client_method:PSSL_METHOD; cdecl
  function  f_TLSv1_method:PSSL_METHOD; cdecl
  function  f_TLSv1_server_method:PSSL_METHOD; cdecl
  function  f_TLSv1_client_method:PSSL_METHOD; cdecl
  function  f_SSL_get_ciphers(s: PSSL):PSTACK_SSL_CIPHER; cdecl
  function  f_SSL_do_handshake(s: PSSL):Integer; cdecl
  function  f_SSL_renegotiate(s: PSSL):Integer; cdecl
  function  f_SSL_shutdown(s: PSSL):Integer; cdecl
  function  f_SSL_get_ssl_method(s: PSSL):PSSL_METHOD; cdecl
  function  f_SSL_set_ssl_method(s: PSSL; method: PSSL_METHOD):Integer; cdecl
  function  f_SSL_alert_type_string_long(value: Integer):PChar; cdecl
  function  f_SSL_alert_type_string(value: Integer):PChar; cdecl
  function  f_SSL_alert_desc_string_long(value: Integer):PChar; cdecl
  function  f_SSL_alert_desc_string(value: Integer):PChar; cdecl
  procedure f_SSL_set_client_CA_list(s: PSSL; list: PSTACK_X509_NAME); cdecl;
  procedure f_SSL_CTX_set_client_CA_list(ctx: PSSL_CTX; list: PSTACK_X509_NAME); cdecl;
  function  f_SSL_get_client_CA_list(s: PSSL):PSTACK_X509_NAME; cdecl
  function  f_SSL_CTX_get_client_CA_list(s: PSSL_CTX):PSTACK_X509_NAME; cdecl
  function  f_SSL_add_client_CA(ssl: PSSL; x: PX509):Integer; cdecl
  function  f_SSL_CTX_add_client_CA(ctx: PSSL_CTX; x: PX509):Integer; cdecl
  procedure f_SSL_set_connect_state(s: PSSL); cdecl;
  procedure f_SSL_set_accept_state(s: PSSL); cdecl;
  function  f_SSL_get_default_timeout(s: PSSL):Longint; cdecl
  function  f_SSL_library_init:Integer; cdecl
  function  f_SSL_CIPHER_description(arg0: PSSL_CIPHER; buf: PChar; size: Integer):PChar; cdecl
  function  f_SSL_dup_CA_list(sk: PSTACK_X509_NAME):PSTACK_X509_NAME; cdecl
  function  f_SSL_dup(ssl: PSSL):PSSL; cdecl
  function  f_SSL_get_certificate(ssl: PSSL):PX509; cdecl
  function  f_SSL_get_privatekey(ssl: PSSL):Pevp_pkey_st; cdecl
  procedure f_SSL_CTX_set_quiet_shutdown(ctx: PSSL_CTX; mode: Integer); cdecl;
  function  f_SSL_CTX_get_quiet_shutdown(ctx: PSSL_CTX):Integer; cdecl
  procedure f_SSL_set_quiet_shutdown(ssl: PSSL; mode: Integer); cdecl;
  function  f_SSL_get_quiet_shutdown(ssl: PSSL):Integer; cdecl
  procedure f_SSL_set_shutdown(ssl: PSSL; mode: Integer); cdecl;
  function  f_SSL_get_shutdown(ssl: PSSL):Integer; cdecl
  function  f_SSL_version(ssl: PSSL):Integer; cdecl
  function  f_SSL_CTX_set_default_verify_paths(ctx: PSSL_CTX):Integer; cdecl
  function  f_SSL_CTX_load_verify_locations(ctx: PSSL_CTX; const CAfile: PChar; const CApath: PChar):Integer; cdecl
  function  f_SSL_get_session(ssl: PSSL):PSSL_SESSION; cdecl
  function  f_SSL_get_SSL_CTX(ssl: PSSL):PSSL_CTX; cdecl
  procedure f_SSL_set_info_callback(ssl: PSSL; arg1: PFunction); cdecl;
  function  f_SSL_state(ssl: PSSL):Integer; cdecl
  procedure f_SSL_set_verify_result(ssl: PSSL; v: Longint); cdecl;
  function  f_SSL_get_verify_result(ssl: PSSL):Longint; cdecl
  function  f_SSL_set_ex_data(ssl: PSSL; idx: Integer; data: Pointer):Integer; cdecl
  function  f_SSL_get_ex_data(ssl: PSSL; idx: Integer):Pointer; cdecl
  function  f_SSL_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; cdecl
  function  f_SSL_SESSION_set_ex_data(ss: PSSL_SESSION; idx: Integer; data: Pointer):Integer; cdecl
  function  f_SSL_SESSION_get_ex_data(ss: PSSL_SESSION; idx: Integer):Pointer; cdecl
  function  f_SSL_SESSION_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; cdecl
  function  f_SSL_CTX_set_ex_data(ssl: PSSL_CTX; idx: Integer; data: Pointer):Integer; cdecl
  function  f_SSL_CTX_get_ex_data(ssl: PSSL_CTX; idx: Integer):Pointer; cdecl
  function  f_SSL_CTX_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; cdecl
  function  f_SSL_get_ex_data_X509_STORE_CTX_idx:Integer; cdecl
  procedure f_SSL_CTX_set_tmp_rsa_callback(ctx: PSSL_CTX; arg1: PFunction); cdecl;
  procedure f_SSL_set_tmp_rsa_callback(ssl: PSSL; arg1: PFunction); cdecl;
  procedure f_SSL_CTX_set_tmp_dh_callback(ctx: PSSL_CTX; arg1: PFunction); cdecl;
  procedure f_SSL_set_tmp_dh_callback(ssl: PSSL; arg1: PFunction); cdecl;
  function  f_SSL_COMP_add_compression_method(id: Integer; cm: PChar):Integer; cdecl
  function  f_SSLeay_add_ssl_algorithms:Integer; cdecl
  function  f_SSL_set_app_data(s: PSSL; arg: Pointer):Integer; cdecl
  function  f_SSL_get_app_data(s: PSSL):Pointer; cdecl
  procedure f_SSL_CTX_set_info_callback(ctx: PSSL_CTX; cb: PFunction); cdecl;
  function  f_SSL_CTX_set_options(ctx: PSSL_CTX; op: Longint):Longint; cdecl
  function  f_SSL_is_init_finished(s: PSSL):Integer; cdecl
  function  f_SSL_in_init(s: PSSL):Integer; cdecl
  function  f_SSL_in_before(s: PSSL):Integer; cdecl
  function  f_SSL_in_connect_init(s: PSSL):Integer; cdecl
  function  f_SSL_in_accept_init(s: PSSL):Integer; cdecl
  function  f_X509_STORE_CTX_get_app_data(ctx: PX509_STORE_CTX):Pointer; cdecl
  function  f_X509_get_notBefore(x509: PX509):PASN1_UTCTIME; cdecl
  function  f_X509_get_notAfter(x509: PX509):PASN1_UTCTIME; cdecl
  function  f_UCTTimeDecode(UCTtime: PASN1_UTCTIME; year: PUShort; month: PUShort; day: PUShort; hour: PUShort; min: PUShort; sec: PUShort; tz_hour: PInteger; tz_min: PInteger):Integer; cdecl
  function  f_SSL_CTX_get_version(ctx: PSSL_CTX):Integer; cdecl
  function  f_SSL_SESSION_get_id(s: PSSL_SESSION; id: PPChar; length: PInteger):Integer; cdecl
  function  f_SSL_SESSION_get_id_ctx(s: PSSL_SESSION; id: PPChar; length: PInteger):Integer; cdecl
  function  f_fopen(const path: PChar; mode: PChar):PFILE; cdecl
  function  f_fclose(stream: PFILE):Integer; cdecl

{$ELSE}
Const
  f_sk_num : function(arg0: PSTACK):Integer cdecl = nil;
  f_sk_value : function(arg0: PSTACK; arg1: Integer):PChar cdecl = nil;
  f_sk_set : function(arg0: PSTACK; arg1: Integer; arg2: PChar):PChar cdecl = nil;
  f_sk_new : function(arg0: PFunction):PSTACK cdecl = nil;
  f_sk_free : procedure(arg0: PSTACK) cdecl = nil;
  f_sk_pop_free : procedure(st: PSTACK; arg1: PFunction) cdecl = nil;
  f_sk_insert : function(sk: PSTACK; data: PChar; where: Integer):Integer cdecl = nil;
  f_sk_delete : function(st: PSTACK; loc: Integer):PChar cdecl = nil;
  f_sk_delete_ptr : function(st: PSTACK; p: PChar):PChar cdecl = nil;
  f_sk_find : function(st: PSTACK; data: PChar):Integer cdecl = nil;
  f_sk_push : function(st: PSTACK; data: PChar):Integer cdecl = nil;
  f_sk_unshift : function(st: PSTACK; data: PChar):Integer cdecl = nil;
  f_sk_shift : function(st: PSTACK):PChar cdecl = nil;
  f_sk_pop : function(st: PSTACK):PChar cdecl = nil;
  f_sk_zero : procedure(st: PSTACK) cdecl = nil;
  f_sk_dup : function(st: PSTACK):PSTACK cdecl = nil;
  f_sk_sort : procedure(st: PSTACK) cdecl = nil;
  f_SSLeay_version : function(_type: Integer):PChar cdecl = nil;
  f_SSLeay : function:Cardinal cdecl = nil;
  f_CRYPTO_get_ex_new_index : function(idx: Integer; sk: PPSTACK; argl: Longint; argp: PChar; arg4: PFunction; arg5: PFunction; arg6: PFunction):Integer cdecl = nil;
  f_CRYPTO_set_ex_data : function(ad: PCRYPTO_EX_DATA; idx: Integer; val: PChar):Integer cdecl = nil;
  f_CRYPTO_get_ex_data : function(ad: PCRYPTO_EX_DATA; idx: Integer):PChar cdecl = nil;
  f_CRYPTO_dup_ex_data : function(meth: PSTACK; from: PCRYPTO_EX_DATA; _to: PCRYPTO_EX_DATA):Integer cdecl = nil;
  f_CRYPTO_free_ex_data : procedure(meth: PSTACK; obj: PChar; ad: PCRYPTO_EX_DATA) cdecl = nil;
  f_CRYPTO_new_ex_data : procedure(meth: PSTACK; obj: PChar; ad: PCRYPTO_EX_DATA) cdecl = nil;
  f_CRYPTO_mem_ctrl : function(mode: Integer):Integer cdecl = nil;
  f_CRYPTO_get_new_lockid : function(name: PChar):Integer cdecl = nil;
  f_CRYPTO_num_locks : function:Integer cdecl = nil;
  f_CRYPTO_lock : procedure(mode: Integer; _type: Integer; const _file: PChar; line: Integer) cdecl = nil;
  f_CRYPTO_set_locking_callback : procedure(arg0: PFunction) cdecl = nil;
  f_CRYPTO_set_add_lock_callback : procedure(arg0: PFunction) cdecl = nil;
  f_CRYPTO_set_id_callback : procedure(arg0: PFunction) cdecl = nil;
  f_CRYPTO_thread_id : function:Cardinal cdecl = nil;
  f_CRYPTO_get_lock_name : function(_type: Integer):PChar cdecl = nil;
  f_CRYPTO_add_lock : function(pointer: PInteger; amount: Integer; _type: Integer; const _file: PChar; line: Integer):Integer cdecl = nil;
  f_CRYPTO_set_mem_functions : procedure(arg0: PFunction; arg1: PFunction; arg2: PFunction) cdecl = nil;
  f_CRYPTO_get_mem_functions : procedure(arg0: PFunction; arg1: PFunction; arg2: PFunction) cdecl = nil;
  f_CRYPTO_set_locked_mem_functions : procedure(arg0: PFunction; arg1: PFunction) cdecl = nil;
  f_CRYPTO_get_locked_mem_functions : procedure(arg0: PFunction; arg1: PFunction) cdecl = nil;
  f_CRYPTO_malloc_locked : function(num: Integer):Pointer cdecl = nil;
  f_CRYPTO_free_locked : procedure(arg0: Pointer) cdecl = nil;
  f_CRYPTO_malloc : function(num: Integer):Pointer cdecl = nil;
  f_CRYPTO_free : procedure(arg0: Pointer) cdecl = nil;
  f_CRYPTO_realloc : function(addr: Pointer; num: Integer):Pointer cdecl = nil;
  f_CRYPTO_remalloc : function(addr: Pointer; num: Integer):Pointer cdecl = nil;
  f_CRYPTO_dbg_malloc : function(num: Integer; const _file: PChar; line: Integer):Pointer cdecl = nil;
  f_CRYPTO_dbg_realloc : function(addr: Pointer; num: Integer; const _file: PChar; line: Integer):Pointer cdecl = nil;
  f_CRYPTO_dbg_free : procedure(arg0: Pointer) cdecl = nil;
  f_CRYPTO_dbg_remalloc : function(addr: Pointer; num: Integer; const _file: PChar; line: Integer):Pointer cdecl = nil;
  f_CRYPTO_mem_leaks_fp : procedure(arg0: PFILE) cdecl = nil;
  f_CRYPTO_mem_leaks : procedure(bio: Pbio_st) cdecl = nil;
  f_CRYPTO_mem_leaks_cb : procedure(arg0: PFunction) cdecl = nil;
  f_ERR_load_CRYPTO_strings : procedure cdecl = nil;
  f_lh_new : function(arg0: PFunction; arg1: PFunction):PLHASH cdecl = nil;
  f_lh_free : procedure(lh: PLHASH) cdecl = nil;
  f_lh_insert : function(lh: PLHASH; data: PChar):PChar cdecl = nil;
  f_lh_delete : function(lh: PLHASH; data: PChar):PChar cdecl = nil;
  f_lh_retrieve : function(lh: PLHASH; data: PChar):PChar cdecl = nil;
  f_lh_doall : procedure(lh: PLHASH; arg1: PFunction) cdecl = nil;
  f_lh_doall_arg : procedure(lh: PLHASH; arg1: PFunction; arg: PChar) cdecl = nil;
  f_lh_strhash : function(const c: PChar):Cardinal cdecl = nil;
  f_lh_stats : procedure(lh: PLHASH; _out: PFILE) cdecl = nil;
  f_lh_node_stats : procedure(lh: PLHASH; _out: PFILE) cdecl = nil;
  f_lh_node_usage_stats : procedure(lh: PLHASH; _out: PFILE) cdecl = nil;
  f_BUF_MEM_new : function:PBUF_MEM cdecl = nil;
  f_BUF_MEM_free : procedure(a: PBUF_MEM) cdecl = nil;
  f_BUF_MEM_grow : function(str: PBUF_MEM; len: Integer):Integer cdecl = nil;
  f_BUF_strdup : function(const str: PChar):PChar cdecl = nil;
  f_ERR_load_BUF_strings : procedure cdecl = nil;
  f_BIO_ctrl_pending : function(b: PBIO):size_t cdecl = nil;
  f_BIO_ctrl_wpending : function(b: PBIO):size_t cdecl = nil;
  f_BIO_ctrl_get_write_guarantee : function(b: PBIO):size_t cdecl = nil;
  f_BIO_ctrl_get_read_request : function(b: PBIO):size_t cdecl = nil;
  f_BIO_set_ex_data : function(bio: PBIO; idx: Integer; data: PChar):Integer cdecl = nil;
  f_BIO_get_ex_data : function(bio: PBIO; idx: Integer):PChar cdecl = nil;
  f_BIO_get_ex_new_index : function(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer cdecl = nil;
  f_BIO_s_file : function:PBIO_METHOD cdecl = nil;
  f_BIO_new_file : function(const filename: PChar; const mode: PChar):PBIO cdecl = nil;
  f_BIO_new_fp : function(stream: PFILE; close_flag: Integer):PBIO cdecl = nil;
  f_BIO_new : function(_type: PBIO_METHOD):PBIO cdecl = nil;
  f_BIO_set : function(a: PBIO; _type: PBIO_METHOD):Integer cdecl = nil;
  f_BIO_free : function(a: PBIO):Integer cdecl = nil;
  f_BIO_read : function(b: PBIO; data: Pointer; len: Integer):Integer cdecl = nil;
  f_BIO_gets : function(bp: PBIO; buf: PChar; size: Integer):Integer cdecl = nil;
  f_BIO_write : function(b: PBIO; const data: PChar; len: Integer):Integer cdecl = nil;
  f_BIO_puts : function(bp: PBIO; const buf: PChar):Integer cdecl = nil;
  f_BIO_ctrl : function(bp: PBIO; cmd: Integer; larg: Longint; parg: Pointer):Longint cdecl = nil;
  f_BIO_ptr_ctrl : function(bp: PBIO; cmd: Integer; larg: Longint):PChar cdecl = nil;
  f_BIO_int_ctrl : function(bp: PBIO; cmd: Integer; larg: Longint; iarg: Integer):Longint cdecl = nil;
  f_BIO_push : function(b: PBIO; append: PBIO):PBIO cdecl = nil;
  f_BIO_pop : function(b: PBIO):PBIO cdecl = nil;
  f_BIO_free_all : procedure(a: PBIO) cdecl = nil;
  f_BIO_find_type : function(b: PBIO; bio_type: Integer):PBIO cdecl = nil;
  f_BIO_get_retry_BIO : function(bio: PBIO; reason: PInteger):PBIO cdecl = nil;
  f_BIO_get_retry_reason : function(bio: PBIO):Integer cdecl = nil;
  f_BIO_dup_chain : function(_in: PBIO):PBIO cdecl = nil;
  f_BIO_debug_callback : function(bio: PBIO; cmd: Integer; const argp: PChar; argi: Integer; argl: Longint; ret: Longint):Longint cdecl = nil;
  f_BIO_s_mem : function:PBIO_METHOD cdecl = nil;
  f_BIO_s_socket : function:PBIO_METHOD cdecl = nil;
  f_BIO_s_connect : function:PBIO_METHOD cdecl = nil;
  f_BIO_s_accept : function:PBIO_METHOD cdecl = nil;
  f_BIO_s_fd : function:PBIO_METHOD cdecl = nil;
  f_BIO_s_bio : function:PBIO_METHOD cdecl = nil;
  f_BIO_s_null : function:PBIO_METHOD cdecl = nil;
  f_BIO_f_null : function:PBIO_METHOD cdecl = nil;
  f_BIO_f_buffer : function:PBIO_METHOD cdecl = nil;
  f_BIO_f_nbio_test : function:PBIO_METHOD cdecl = nil;
  f_BIO_sock_should_retry : function(i: Integer):Integer cdecl = nil;
  f_BIO_sock_non_fatal_error : function(error: Integer):Integer cdecl = nil;
  f_BIO_fd_should_retry : function(i: Integer):Integer cdecl = nil;
  f_BIO_fd_non_fatal_error : function(error: Integer):Integer cdecl = nil;
  f_BIO_dump : function(b: PBIO; const bytes: PChar; len: Integer):Integer cdecl = nil;
  f_BIO_gethostbyname : function(const name: PChar):Phostent2 cdecl = nil;
  f_BIO_sock_error : function(sock: Integer):Integer cdecl = nil;
  f_BIO_socket_ioctl : function(fd: Integer; _type: Longint; arg: PULong):Integer cdecl = nil;
  f_BIO_socket_nbio : function(fd: Integer; mode: Integer):Integer cdecl = nil;
  f_BIO_get_port : function(const str: PChar; port_ptr: PUShort):Integer cdecl = nil;
  f_BIO_get_host_ip : function(const str: PChar; ip: PChar):Integer cdecl = nil;
  f_BIO_get_accept_socket : function(host_port: PChar; mode: Integer):Integer cdecl = nil;
  f_BIO_accept : function(sock: Integer; ip_port: PPChar):Integer cdecl = nil;
  f_BIO_sock_init : function:Integer cdecl = nil;
  f_BIO_sock_cleanup : procedure cdecl = nil;
  f_BIO_set_tcp_ndelay : function(sock: Integer; turn_on: Integer):Integer cdecl = nil;
  f_ERR_load_BIO_strings : procedure cdecl = nil;
  f_BIO_new_socket : function(sock: Integer; close_flag: Integer):PBIO cdecl = nil;
  f_BIO_new_fd : function(fd: Integer; close_flag: Integer):PBIO cdecl = nil;
  f_BIO_new_connect : function(host_port: PChar):PBIO cdecl = nil;
  f_BIO_new_accept : function(host_port: PChar):PBIO cdecl = nil;
  f_BIO_new_bio_pair : function(bio1: PPBIO; writebuf1: size_t; bio2: PPBIO; writebuf2: size_t):Integer cdecl = nil;
  f_BIO_copy_next_retry : procedure(b: PBIO) cdecl = nil;
  f_BIO_ghbn_ctrl : function(cmd: Integer; iarg: Integer; parg: PChar):Longint cdecl = nil;
  f_MD2_options : function:PChar cdecl = nil;
  f_MD2_Init : procedure(c: PMD2_CTX) cdecl = nil;
  f_MD2_Update : procedure(c: PMD2_CTX; data: PChar; len: Cardinal) cdecl = nil;
  f_MD2_Final : procedure(md: PChar; c: PMD2_CTX) cdecl = nil;
  f_MD2 : function(d: PChar; n: Cardinal; md: PChar):PChar cdecl = nil;
  f_MD5_Init : procedure(c: PMD5_CTX) cdecl = nil;
  f_MD5_Update : procedure(c: PMD5_CTX; const data: PChar; len: Cardinal) cdecl = nil;
  f_MD5_Final : procedure(md: PChar; c: PMD5_CTX) cdecl = nil;
  f_MD5 : function(d: PChar; n: Cardinal; md: PChar):PChar cdecl = nil;
  f_MD5_Transform : procedure(c: PMD5_CTX; const b: PChar) cdecl = nil;
  f_SHA_Init : procedure(c: PSHA_CTX) cdecl = nil;
  f_SHA_Update : procedure(c: PSHA_CTX; const data: PChar; len: Cardinal) cdecl = nil;
  f_SHA_Final : procedure(md: PChar; c: PSHA_CTX) cdecl = nil;
  f_SHA : function(const d: PChar; n: Cardinal; md: PChar):PChar cdecl = nil;
  f_SHA_Transform : procedure(c: PSHA_CTX; data: PChar) cdecl = nil;
  f_SHA1_Init : procedure(c: PSHA_CTX) cdecl = nil;
  f_SHA1_Update : procedure(c: PSHA_CTX; const data: PChar; len: Cardinal) cdecl = nil;
  f_SHA1_Final : procedure(md: PChar; c: PSHA_CTX) cdecl = nil;
  f_SHA1 : function(const d: PChar; n: Cardinal; md: PChar):PChar cdecl = nil;
  f_SHA1_Transform : procedure(c: PSHA_CTX; data: PChar) cdecl = nil;
  f_RIPEMD160_Init : procedure(c: PRIPEMD160_CTX) cdecl = nil;
  f_RIPEMD160_Update : procedure(c: PRIPEMD160_CTX; data: PChar; len: Cardinal) cdecl = nil;
  f_RIPEMD160_Final : procedure(md: PChar; c: PRIPEMD160_CTX) cdecl = nil;
  f_RIPEMD160 : function(d: PChar; n: Cardinal; md: PChar):PChar cdecl = nil;
  f_RIPEMD160_Transform : procedure(c: PRIPEMD160_CTX; b: PChar) cdecl = nil;
  f_des_options : function:PChar cdecl = nil;
  f_des_ecb3_encrypt : procedure(const input: P_des_cblock; output: Pdes_cblock; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; enc: Integer) cdecl = nil;
  f_des_cbc_cksum : function(const input: PChar; output: Pdes_cblock; length: Longint; schedule: des_key_schedule; const ivec: P_des_cblock):Cardinal cdecl = nil;
  f_des_cbc_encrypt : procedure(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer) cdecl = nil;
  f_des_ncbc_encrypt : procedure(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer) cdecl = nil;
  f_des_xcbc_encrypt : procedure(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; const inw: P_des_cblock; const outw: P_des_cblock; enc: Integer) cdecl = nil;
  f_des_cfb_encrypt : procedure(const _in: PChar; _out: PChar; numbits: Integer; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer) cdecl = nil;
  f_des_ecb_encrypt : procedure(const input: P_des_cblock; output: Pdes_cblock; ks: des_key_schedule; enc: Integer) cdecl = nil;
  f_des_encrypt : procedure(data: PULong; ks: des_key_schedule; enc: Integer) cdecl = nil;
  f_des_encrypt2 : procedure(data: PULong; ks: des_key_schedule; enc: Integer) cdecl = nil;
  f_des_encrypt3 : procedure(data: PULong; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule) cdecl = nil;
  f_des_decrypt3 : procedure(data: PULong; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule) cdecl = nil;
  f_des_ede3_cbc_encrypt : procedure(const input: PChar; output: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec: Pdes_cblock; enc: Integer) cdecl = nil;
  f_des_ede3_cbcm_encrypt : procedure(const _in: PChar; _out: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec1: Pdes_cblock; ivec2: Pdes_cblock; enc: Integer) cdecl = nil;
  f_des_ede3_cfb64_encrypt : procedure(const _in: PChar; _out: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec: Pdes_cblock; num: PInteger; enc: Integer) cdecl = nil;
  f_des_ede3_ofb64_encrypt : procedure(const _in: PChar; _out: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec: Pdes_cblock; num: PInteger) cdecl = nil;
  f_des_xwhite_in2out : procedure(const des_key: P_des_cblock; const in_white: P_des_cblock; out_white: Pdes_cblock) cdecl = nil;
  f_des_enc_read : function(fd: Integer; buf: Pointer; len: Integer; sched: des_key_schedule; iv: Pdes_cblock):Integer cdecl = nil;
  f_des_enc_write : function(fd: Integer; const buf: Pointer; len: Integer; sched: des_key_schedule; iv: Pdes_cblock):Integer cdecl = nil;
  f_des_fcrypt : function(const buf: PChar; const salt: PChar; ret: PChar):PChar cdecl = nil;
  f_crypt : function(const buf: PChar; const salt: PChar):PChar cdecl = nil;
  f_des_ofb_encrypt : procedure(const _in: PChar; _out: PChar; numbits: Integer; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock) cdecl = nil;
  f_des_pcbc_encrypt : procedure(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer) cdecl = nil;
  f_des_quad_cksum : function(const input: PChar; output: des_cblock; length: Longint; out_count: Integer; seed: Pdes_cblock):Cardinal cdecl = nil;
  f_des_random_seed : procedure(key: Pdes_cblock) cdecl = nil;
  f_des_random_key : procedure(ret: Pdes_cblock) cdecl = nil;
  f_des_read_password : function(key: Pdes_cblock; const prompt: PChar; verify: Integer):Integer cdecl = nil;
  f_des_read_2passwords : function(key1: Pdes_cblock; key2: Pdes_cblock; const prompt: PChar; verify: Integer):Integer cdecl = nil;
  f_des_read_pw_string : function(buf: PChar; length: Integer; const prompt: PChar; verify: Integer):Integer cdecl = nil;
  f_des_set_odd_parity : procedure(key: Pdes_cblock) cdecl = nil;
  f_des_is_weak_key : function(const key: P_des_cblock):Integer cdecl = nil;
  f_des_set_key : function(const key: P_des_cblock; schedule: des_key_schedule):Integer cdecl = nil;
  f_des_key_sched : function(const key: P_des_cblock; schedule: des_key_schedule):Integer cdecl = nil;
  f_des_string_to_key : procedure(const str: PChar; key: Pdes_cblock) cdecl = nil;
  f_des_string_to_2keys : procedure(const str: PChar; key1: Pdes_cblock; key2: Pdes_cblock) cdecl = nil;
  f_des_cfb64_encrypt : procedure(const _in: PChar; _out: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; num: PInteger; enc: Integer) cdecl = nil;
  f_des_ofb64_encrypt : procedure(const _in: PChar; _out: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; num: PInteger) cdecl = nil;
  f_des_read_pw : function(buf: PChar; buff: PChar; size: Integer; const prompt: PChar; verify: Integer):Integer cdecl = nil;
  f_des_cblock_print_file : procedure(const cb: P_des_cblock; fp: PFILE) cdecl = nil;
  f_RC4_options : function:PChar cdecl = nil;
  f_RC4_set_key : procedure(key: PRC4_KEY; len: Integer; data: PChar) cdecl = nil;
  f_RC4 : procedure(key: PRC4_KEY; len: Cardinal; indata: PChar; outdata: PChar) cdecl = nil;
  f_RC2_set_key : procedure(key: PRC2_KEY; len: Integer; data: PChar; bits: Integer) cdecl = nil;
  f_RC2_ecb_encrypt : procedure(_in: PChar; _out: PChar; key: PRC2_KEY; enc: Integer) cdecl = nil;
  f_RC2_encrypt : procedure(data: PULong; key: PRC2_KEY) cdecl = nil;
  f_RC2_decrypt : procedure(data: PULong; key: PRC2_KEY) cdecl = nil;
  f_RC2_cbc_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; ks: PRC2_KEY; iv: PChar; enc: Integer) cdecl = nil;
  f_RC2_cfb64_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; schedule: PRC2_KEY; ivec: PChar; num: PInteger; enc: Integer) cdecl = nil;
  f_RC2_ofb64_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; schedule: PRC2_KEY; ivec: PChar; num: PInteger) cdecl = nil;
  f_RC5_32_set_key : procedure(key: PRC5_32_KEY; len: Integer; data: PChar; rounds: Integer) cdecl = nil;
  f_RC5_32_ecb_encrypt : procedure(_in: PChar; _out: PChar; key: PRC5_32_KEY; enc: Integer) cdecl = nil;
  f_RC5_32_encrypt : procedure(data: PULong; key: PRC5_32_KEY) cdecl = nil;
  f_RC5_32_decrypt : procedure(data: PULong; key: PRC5_32_KEY) cdecl = nil;
  f_RC5_32_cbc_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; ks: PRC5_32_KEY; iv: PChar; enc: Integer) cdecl = nil;
  f_RC5_32_cfb64_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; schedule: PRC5_32_KEY; ivec: PChar; num: PInteger; enc: Integer) cdecl = nil;
  f_RC5_32_ofb64_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; schedule: PRC5_32_KEY; ivec: PChar; num: PInteger) cdecl = nil;
  f_BF_set_key : procedure(key: PBF_KEY; len: Integer; data: PChar) cdecl = nil;
  f_BF_ecb_encrypt : procedure(_in: PChar; _out: PChar; key: PBF_KEY; enc: Integer) cdecl = nil;
  f_BF_encrypt : procedure(data: PUInteger; key: PBF_KEY) cdecl = nil;
  f_BF_decrypt : procedure(data: PUInteger; key: PBF_KEY) cdecl = nil;
  f_BF_cbc_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; ks: PBF_KEY; iv: PChar; enc: Integer) cdecl = nil;
  f_BF_cfb64_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; schedule: PBF_KEY; ivec: PChar; num: PInteger; enc: Integer) cdecl = nil;
  f_BF_ofb64_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; schedule: PBF_KEY; ivec: PChar; num: PInteger) cdecl = nil;
  f_BF_options : function:PChar cdecl = nil;
  f_CAST_set_key : procedure(key: PCAST_KEY; len: Integer; data: PChar) cdecl = nil;
  f_CAST_ecb_encrypt : procedure(const _in: PChar; _out: PChar; key: PCAST_KEY; enc: Integer) cdecl = nil;
  f_CAST_encrypt : procedure(data: PULong; key: PCAST_KEY) cdecl = nil;
  f_CAST_decrypt : procedure(data: PULong; key: PCAST_KEY) cdecl = nil;
  f_CAST_cbc_encrypt : procedure(const _in: PChar; _out: PChar; length: Longint; ks: PCAST_KEY; iv: PChar; enc: Integer) cdecl = nil;
  f_CAST_cfb64_encrypt : procedure(const _in: PChar; _out: PChar; length: Longint; schedule: PCAST_KEY; ivec: PChar; num: PInteger; enc: Integer) cdecl = nil;
  f_CAST_ofb64_encrypt : procedure(const _in: PChar; _out: PChar; length: Longint; schedule: PCAST_KEY; ivec: PChar; num: PInteger) cdecl = nil;
  f_idea_options : function:PChar cdecl = nil;
  f_idea_ecb_encrypt : procedure(_in: PChar; _out: PChar; ks: PIDEA_KEY_SCHEDULE) cdecl = nil;
  f_idea_set_encrypt_key : procedure(key: PChar; ks: PIDEA_KEY_SCHEDULE) cdecl = nil;
  f_idea_set_decrypt_key : procedure(ek: PIDEA_KEY_SCHEDULE; dk: PIDEA_KEY_SCHEDULE) cdecl = nil;
  f_idea_cbc_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; ks: PIDEA_KEY_SCHEDULE; iv: PChar; enc: Integer) cdecl = nil;
  f_idea_cfb64_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; ks: PIDEA_KEY_SCHEDULE; iv: PChar; num: PInteger; enc: Integer) cdecl = nil;
  f_idea_ofb64_encrypt : procedure(_in: PChar; _out: PChar; length: Longint; ks: PIDEA_KEY_SCHEDULE; iv: PChar; num: PInteger) cdecl = nil;
  f_idea_encrypt : procedure(_in: PULong; ks: PIDEA_KEY_SCHEDULE) cdecl = nil;
  f_MDC2_Init : procedure(c: PMDC2_CTX) cdecl = nil;
  f_MDC2_Update : procedure(c: PMDC2_CTX; data: PChar; len: Cardinal) cdecl = nil;
  f_MDC2_Final : procedure(md: PChar; c: PMDC2_CTX) cdecl = nil;
  f_MDC2 : function(d: PChar; n: Cardinal; md: PChar):PChar cdecl = nil;
  f_BN_value_one : function:PBIGNUM cdecl = nil;
  f_BN_options : function:PChar cdecl = nil;
  f_BN_CTX_new : function:PBN_CTX cdecl = nil;
  f_BN_CTX_init : procedure(c: PBN_CTX) cdecl = nil;
  f_BN_CTX_free : procedure(c: PBN_CTX) cdecl = nil;
  f_BN_rand : function(rnd: PBIGNUM; bits: Integer; top: Integer; bottom: Integer):Integer cdecl = nil;
  f_BN_num_bits : function(const a: PBIGNUM):Integer cdecl = nil;
  f_BN_num_bits_word : function(arg0: Cardinal):Integer cdecl = nil;
  f_BN_new : function:PBIGNUM cdecl = nil;
  f_BN_init : procedure(arg0: PBIGNUM) cdecl = nil;
  f_BN_clear_free : procedure(a: PBIGNUM) cdecl = nil;
  f_BN_copy : function(a: PBIGNUM; const b: PBIGNUM):PBIGNUM cdecl = nil;
  f_BN_bin2bn : function(const s: PChar; len: Integer; ret: PBIGNUM):PBIGNUM cdecl = nil;
  f_BN_bn2bin : function(const a: PBIGNUM; _to: PChar):Integer cdecl = nil;
  f_BN_mpi2bn : function(s: PChar; len: Integer; ret: PBIGNUM):PBIGNUM cdecl = nil;
  f_BN_bn2mpi : function(const a: PBIGNUM; _to: PChar):Integer cdecl = nil;
  f_BN_sub : function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM):Integer cdecl = nil;
  f_BN_usub : function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM):Integer cdecl = nil;
  f_BN_uadd : function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM):Integer cdecl = nil;
  f_BN_add : function(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM):Integer cdecl = nil;
  f_BN_mod : function(rem: PBIGNUM; const m: PBIGNUM; const d: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_div : function(dv: PBIGNUM; rem: PBIGNUM; const m: PBIGNUM; const d: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_mul : function(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_sqr : function(r: PBIGNUM; a: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_mod_word : function(a: PBIGNUM; w: Cardinal):Cardinal cdecl = nil;
  f_BN_div_word : function(a: PBIGNUM; w: Cardinal):Cardinal cdecl = nil;
  f_BN_mul_word : function(a: PBIGNUM; w: Cardinal):Integer cdecl = nil;
  f_BN_add_word : function(a: PBIGNUM; w: Cardinal):Integer cdecl = nil;
  f_BN_sub_word : function(a: PBIGNUM; w: Cardinal):Integer cdecl = nil;
  f_BN_set_word : function(a: PBIGNUM; w: Cardinal):Integer cdecl = nil;
  f_BN_get_word : function(a: PBIGNUM):Cardinal cdecl = nil;
  f_BN_cmp : function(const a: PBIGNUM; const b: PBIGNUM):Integer cdecl = nil;
  f_BN_free : procedure(a: PBIGNUM) cdecl = nil;
  f_BN_is_bit_set : function(const a: PBIGNUM; n: Integer):Integer cdecl = nil;
  f_BN_lshift : function(r: PBIGNUM; const a: PBIGNUM; n: Integer):Integer cdecl = nil;
  f_BN_lshift1 : function(r: PBIGNUM; a: PBIGNUM):Integer cdecl = nil;
  f_BN_exp : function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_mod_exp : function(r: PBIGNUM; a: PBIGNUM; const p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_mod_exp_mont : function(r: PBIGNUM; a: PBIGNUM; const p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX):Integer cdecl = nil;
  f_BN_mod_exp2_mont : function(r: PBIGNUM; a1: PBIGNUM; p1: PBIGNUM; a2: PBIGNUM; p2: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX):Integer cdecl = nil;
  f_BN_mod_exp_simple : function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_mask_bits : function(a: PBIGNUM; n: Integer):Integer cdecl = nil;
  f_BN_mod_mul : function(ret: PBIGNUM; a: PBIGNUM; b: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_print_fp : function(fp: PFILE; a: PBIGNUM):Integer cdecl = nil;
  f_BN_print : function(fp: PBIO; const a: PBIGNUM):Integer cdecl = nil;
  f_BN_reciprocal : function(r: PBIGNUM; m: PBIGNUM; len: Integer; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_rshift : function(r: PBIGNUM; a: PBIGNUM; n: Integer):Integer cdecl = nil;
  f_BN_rshift1 : function(r: PBIGNUM; a: PBIGNUM):Integer cdecl = nil;
  f_BN_clear : procedure(a: PBIGNUM) cdecl = nil;
  f_bn_expand2 : function(b: PBIGNUM; bits: Integer):PBIGNUM cdecl = nil;
  f_BN_dup : function(const a: PBIGNUM):PBIGNUM cdecl = nil;
  f_BN_ucmp : function(const a: PBIGNUM; const b: PBIGNUM):Integer cdecl = nil;
  f_BN_set_bit : function(a: PBIGNUM; n: Integer):Integer cdecl = nil;
  f_BN_clear_bit : function(a: PBIGNUM; n: Integer):Integer cdecl = nil;
  f_BN_bn2hex : function(const a: PBIGNUM):PChar cdecl = nil;
  f_BN_bn2dec : function(const a: PBIGNUM):PChar cdecl = nil;
  f_BN_hex2bn : function(a: PPBIGNUM; const str: PChar):Integer cdecl = nil;
  f_BN_dec2bn : function(a: PPBIGNUM; const str: PChar):Integer cdecl = nil;
  f_BN_gcd : function(r: PBIGNUM; in_a: PBIGNUM; in_b: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_mod_inverse : function(ret: PBIGNUM; a: PBIGNUM; const n: PBIGNUM; ctx: PBN_CTX):PBIGNUM cdecl = nil;
  f_BN_generate_prime : function(ret: PBIGNUM; bits: Integer; strong: Integer; add: PBIGNUM; rem: PBIGNUM; arg5: PFunction; cb_arg: Pointer):PBIGNUM cdecl = nil;
  f_BN_is_prime : function(p: PBIGNUM; nchecks: Integer; arg2: PFunction; ctx: PBN_CTX; cb_arg: Pointer):Integer cdecl = nil;
  f_ERR_load_BN_strings : procedure cdecl = nil;
  f_bn_mul_add_words : function(rp: PULong; ap: PULong; num: Integer; w: Cardinal):Cardinal cdecl = nil;
  f_bn_mul_words : function(rp: PULong; ap: PULong; num: Integer; w: Cardinal):Cardinal cdecl = nil;
  f_bn_sqr_words : procedure(rp: PULong; ap: PULong; num: Integer) cdecl = nil;
  f_bn_div_words : function(h: Cardinal; l: Cardinal; d: Cardinal):Cardinal cdecl = nil;
  f_bn_add_words : function(rp: PULong; ap: PULong; bp: PULong; num: Integer):Cardinal cdecl = nil;
  f_bn_sub_words : function(rp: PULong; ap: PULong; bp: PULong; num: Integer):Cardinal cdecl = nil;
  f_BN_MONT_CTX_new : function:PBN_MONT_CTX cdecl = nil;
  f_BN_MONT_CTX_init : procedure(ctx: PBN_MONT_CTX) cdecl = nil;
  f_BN_mod_mul_montgomery : function(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_from_montgomery : function(r: PBIGNUM; a: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_MONT_CTX_free : procedure(mont: PBN_MONT_CTX) cdecl = nil;
  f_BN_MONT_CTX_set : function(mont: PBN_MONT_CTX; const modulus: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_MONT_CTX_copy : function(_to: PBN_MONT_CTX; from: PBN_MONT_CTX):PBN_MONT_CTX cdecl = nil;
  f_BN_BLINDING_new : function(A: PBIGNUM; Ai: PBIGNUM; _mod: PBIGNUM):PBN_BLINDING cdecl = nil;
  f_BN_BLINDING_free : procedure(b: PBN_BLINDING) cdecl = nil;
  f_BN_BLINDING_update : function(b: PBN_BLINDING; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_BLINDING_convert : function(n: PBIGNUM; r: PBN_BLINDING; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_BLINDING_invert : function(n: PBIGNUM; b: PBN_BLINDING; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_set_params : procedure(mul: Integer; high: Integer; low: Integer; mont: Integer) cdecl = nil;
  f_BN_get_params : function(which: Integer):Integer cdecl = nil;
  f_BN_RECP_CTX_init : procedure(recp: PBN_RECP_CTX) cdecl = nil;
  f_BN_RECP_CTX_new : function:PBN_RECP_CTX cdecl = nil;
  f_BN_RECP_CTX_free : procedure(recp: PBN_RECP_CTX) cdecl = nil;
  f_BN_RECP_CTX_set : function(recp: PBN_RECP_CTX; const rdiv: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_mod_mul_reciprocal : function(r: PBIGNUM; x: PBIGNUM; y: PBIGNUM; recp: PBN_RECP_CTX; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_mod_exp_recp : function(r: PBIGNUM; const a: PBIGNUM; const p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX):Integer cdecl = nil;
  f_BN_div_recp : function(dv: PBIGNUM; rem: PBIGNUM; m: PBIGNUM; recp: PBN_RECP_CTX; ctx: PBN_CTX):Integer cdecl = nil;
  f_RSA_new : function:PRSA cdecl = nil;
  f_RSA_new_method : function(method: PRSA_METHOD):PRSA cdecl = nil;
  f_RSA_size : function(arg0: PRSA):Integer cdecl = nil;
  f_RSA_generate_key : function(bits: Integer; e: Cardinal; arg2: PFunction; cb_arg: Pointer):PRSA cdecl = nil;
  f_RSA_check_key : function(arg0: PRSA):Integer cdecl = nil;
  f_RSA_public_encrypt : function(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer cdecl = nil;
  f_RSA_private_encrypt : function(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer cdecl = nil;
  f_RSA_public_decrypt : function(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer cdecl = nil;
  f_RSA_private_decrypt : function(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer cdecl = nil;
  f_RSA_free : procedure(r: PRSA) cdecl = nil;
  f_RSA_flags : function(r: PRSA):Integer cdecl = nil;
  f_RSA_set_default_method : procedure(meth: PRSA_METHOD) cdecl = nil;
  f_RSA_get_default_method : function:PRSA_METHOD cdecl = nil;
  f_RSA_get_method : function(rsa: PRSA):PRSA_METHOD cdecl = nil;
  f_RSA_set_method : function(rsa: PRSA; meth: PRSA_METHOD):PRSA_METHOD cdecl = nil;
  f_RSA_memory_lock : function(r: PRSA):Integer cdecl = nil;
  f_RSA_PKCS1_SSLeay : function:PRSA_METHOD cdecl = nil;
  f_ERR_load_RSA_strings : procedure cdecl = nil;
  f_d2i_RSAPublicKey : function(a: PPRSA; pp: PPChar; length: Longint):PRSA cdecl = nil;
  f_i2d_RSAPublicKey : function(a: PRSA; pp: PPChar):Integer cdecl = nil;
  f_d2i_RSAPrivateKey : function(a: PPRSA; pp: PPChar; length: Longint):PRSA cdecl = nil;
  f_i2d_RSAPrivateKey : function(a: PRSA; pp: PPChar):Integer cdecl = nil;
  f_RSA_print_fp : function(fp: PFILE; r: PRSA; offset: Integer):Integer cdecl = nil;
  f_RSA_print : function(bp: PBIO; r: PRSA; offset: Integer):Integer cdecl = nil;
  f_i2d_Netscape_RSA : function(a: PRSA; pp: PPChar; arg2: PFunction):Integer cdecl = nil;
  f_d2i_Netscape_RSA : function(a: PPRSA; pp: PPChar; length: Longint; arg3: PFunction):PRSA cdecl = nil;
  f_d2i_Netscape_RSA_2 : function(a: PPRSA; pp: PPChar; length: Longint; arg3: PFunction):PRSA cdecl = nil;
  f_RSA_sign : function(_type: Integer; m: PChar; m_len: UInteger; sigret: PChar; siglen: PUInteger; rsa: PRSA):Integer cdecl = nil;
  f_RSA_verify : function(_type: Integer; m: PChar; m_len: UInteger; sigbuf: PChar; siglen: UInteger; rsa: PRSA):Integer cdecl = nil;
  f_RSA_sign_ASN1_OCTET_STRING : function(_type: Integer; m: PChar; m_len: UInteger; sigret: PChar; siglen: PUInteger; rsa: PRSA):Integer cdecl = nil;
  f_RSA_verify_ASN1_OCTET_STRING : function(_type: Integer; m: PChar; m_len: UInteger; sigbuf: PChar; siglen: UInteger; rsa: PRSA):Integer cdecl = nil;
  f_RSA_blinding_on : function(rsa: PRSA; ctx: PBN_CTX):Integer cdecl = nil;
  f_RSA_blinding_off : procedure(rsa: PRSA) cdecl = nil;
  f_RSA_padding_add_PKCS1_type_1 : function(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer cdecl = nil;
  f_RSA_padding_check_PKCS1_type_1 : function(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer cdecl = nil;
  f_RSA_padding_add_PKCS1_type_2 : function(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer cdecl = nil;
  f_RSA_padding_check_PKCS1_type_2 : function(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer cdecl = nil;
  f_RSA_padding_add_PKCS1_OAEP : function(_to: PChar; tlen: Integer; f: PChar; fl: Integer; p: PChar; pl: Integer):Integer cdecl = nil;
  f_RSA_padding_check_PKCS1_OAEP : function(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer; p: PChar; pl: Integer):Integer cdecl = nil;
  f_RSA_padding_add_SSLv23 : function(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer cdecl = nil;
  f_RSA_padding_check_SSLv23 : function(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer cdecl = nil;
  f_RSA_padding_add_none : function(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer cdecl = nil;
  f_RSA_padding_check_none : function(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer cdecl = nil;
  f_RSA_get_ex_new_index : function(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer cdecl = nil;
  f_RSA_set_ex_data : function(r: PRSA; idx: Integer; arg: PChar):Integer cdecl = nil;
  f_RSA_get_ex_data : function(r: PRSA; idx: Integer):PChar cdecl = nil;
  f_DH_new : function:PDH cdecl = nil;
  f_DH_free : procedure(dh: PDH) cdecl = nil;
  f_DH_size : function(dh: PDH):Integer cdecl = nil;
  f_DH_generate_parameters : function(prime_len: Integer; generator: Integer; arg2: PFunction; cb_arg: Pointer):PDH cdecl = nil;
  f_DH_check : function(dh: PDH; codes: PInteger):Integer cdecl = nil;
  f_DH_generate_key : function(dh: PDH):Integer cdecl = nil;
  f_DH_compute_key : function(key: PChar; pub_key: PBIGNUM; dh: PDH):Integer cdecl = nil;
  f_d2i_DHparams : function(a: PPDH; pp: PPChar; length: Longint):PDH cdecl = nil;
  f_i2d_DHparams : function(a: PDH; pp: PPChar):Integer cdecl = nil;
  f_DHparams_print_fp : function(fp: PFILE; x: PDH):Integer cdecl = nil;
  f_DHparams_print : function(bp: PBIO; x: PDH):Integer cdecl = nil;
  f_ERR_load_DH_strings : procedure cdecl = nil;
  f_DSA_SIG_new : function:PDSA_SIG cdecl = nil;
  f_DSA_SIG_free : procedure(a: PDSA_SIG) cdecl = nil;
  f_i2d_DSA_SIG : function(a: PDSA_SIG; pp: PPChar):Integer cdecl = nil;
  f_d2i_DSA_SIG : function(v: PPDSA_SIG; pp: PPChar; length: Longint):PDSA_SIG cdecl = nil;
  f_DSA_do_sign : function(const dgst: PChar; dlen: Integer; dsa: PDSA):PDSA_SIG cdecl = nil;
  f_DSA_do_verify : function(const dgst: PChar; dgst_len: Integer; sig: PDSA_SIG; dsa: PDSA):Integer cdecl = nil;
  f_DSA_new : function:PDSA cdecl = nil;
  f_DSA_size : function(arg0: PDSA):Integer cdecl = nil;
  f_DSA_sign_setup : function(dsa: PDSA; ctx_in: PBN_CTX; kinvp: PPBIGNUM; rp: PPBIGNUM):Integer cdecl = nil;
  f_DSA_sign : function(_type: Integer; const dgst: PChar; dlen: Integer; sig: PChar; siglen: PUInteger; dsa: PDSA):Integer cdecl = nil;
  f_DSA_verify : function(_type: Integer; const dgst: PChar; dgst_len: Integer; sigbuf: PChar; siglen: Integer; dsa: PDSA):Integer cdecl = nil;
  f_DSA_free : procedure(r: PDSA) cdecl = nil;
  f_ERR_load_DSA_strings : procedure cdecl = nil;
  f_d2i_DSAPublicKey : function(a: PPDSA; pp: PPChar; length: Longint):PDSA cdecl = nil;
  f_d2i_DSAPrivateKey : function(a: PPDSA; pp: PPChar; length: Longint):PDSA cdecl = nil;
  f_d2i_DSAparams : function(a: PPDSA; pp: PPChar; length: Longint):PDSA cdecl = nil;
  f_DSA_generate_parameters : function(bits: Integer; seed: PChar; seed_len: Integer; counter_ret: PInteger; h_ret: PULong; arg5: PFunction; cb_arg: PChar):PDSA cdecl = nil;
  f_DSA_generate_key : function(a: PDSA):Integer cdecl = nil;
  f_i2d_DSAPublicKey : function(a: PDSA; pp: PPChar):Integer cdecl = nil;
  f_i2d_DSAPrivateKey : function(a: PDSA; pp: PPChar):Integer cdecl = nil;
  f_i2d_DSAparams : function(a: PDSA; pp: PPChar):Integer cdecl = nil;
  f_DSAparams_print : function(bp: PBIO; x: PDSA):Integer cdecl = nil;
  f_DSA_print : function(bp: PBIO; x: PDSA; off: Integer):Integer cdecl = nil;
  f_DSAparams_print_fp : function(fp: PFILE; x: PDSA):Integer cdecl = nil;
  f_DSA_print_fp : function(bp: PFILE; x: PDSA; off: Integer):Integer cdecl = nil;
  f_DSA_is_prime : function(q: PBIGNUM; arg1: PFunction; cb_arg: PChar):Integer cdecl = nil;
  f_DSA_dup_DH : function(r: PDSA):PDH cdecl = nil;
  f_sk_ASN1_TYPE_new : function(arg0: PFunction):PSTACK_ASN1_TYPE cdecl = nil;
  f_sk_ASN1_TYPE_new_null : function:PSTACK_ASN1_TYPE cdecl = nil;
  f_sk_ASN1_TYPE_free : procedure(sk: PSTACK_ASN1_TYPE) cdecl = nil;
  f_sk_ASN1_TYPE_num : function(const sk: PSTACK_ASN1_TYPE):Integer cdecl = nil;
  f_sk_ASN1_TYPE_value : function(const sk: PSTACK_ASN1_TYPE; n: Integer):PASN1_TYPE cdecl = nil;
  f_sk_ASN1_TYPE_set : function(sk: PSTACK_ASN1_TYPE; n: Integer; v: PASN1_TYPE):PASN1_TYPE cdecl = nil;
  f_sk_ASN1_TYPE_zero : procedure(sk: PSTACK_ASN1_TYPE) cdecl = nil;
  f_sk_ASN1_TYPE_push : function(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE):Integer cdecl = nil;
  f_sk_ASN1_TYPE_unshift : function(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE):Integer cdecl = nil;
  f_sk_ASN1_TYPE_find : function(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE):Integer cdecl = nil;
  f_sk_ASN1_TYPE_delete : function(sk: PSTACK_ASN1_TYPE; n: Integer):PASN1_TYPE cdecl = nil;
  f_sk_ASN1_TYPE_delete_ptr : procedure(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE) cdecl = nil;
  f_sk_ASN1_TYPE_insert : function(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE; n: Integer):Integer cdecl = nil;
  f_sk_ASN1_TYPE_dup : function(sk: PSTACK_ASN1_TYPE):PSTACK_ASN1_TYPE cdecl = nil;
  f_sk_ASN1_TYPE_pop_free : procedure(sk: PSTACK_ASN1_TYPE; arg1: PFunction) cdecl = nil;
  f_sk_ASN1_TYPE_shift : function(sk: PSTACK_ASN1_TYPE):PASN1_TYPE cdecl = nil;
  f_sk_ASN1_TYPE_pop : function(sk: PSTACK_ASN1_TYPE):PASN1_TYPE cdecl = nil;
  f_sk_ASN1_TYPE_sort : procedure(sk: PSTACK_ASN1_TYPE) cdecl = nil;
  f_i2d_ASN1_SET_OF_ASN1_TYPE : function(a: PSTACK_ASN1_TYPE; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET_OF_ASN1_TYPE : function(a: PPSTACK_ASN1_TYPE; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_ASN1_TYPE cdecl = nil;
  f_ASN1_TYPE_new : function:PASN1_TYPE cdecl = nil;
  f_ASN1_TYPE_free : procedure(a: PASN1_TYPE) cdecl = nil;
  f_i2d_ASN1_TYPE : function(a: PASN1_TYPE; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_TYPE : function(a: PPASN1_TYPE; pp: PPChar; length: Longint):PASN1_TYPE cdecl = nil;
  f_ASN1_TYPE_get : function(a: PASN1_TYPE):Integer cdecl = nil;
  f_ASN1_TYPE_set : procedure(a: PASN1_TYPE; _type: Integer; value: Pointer) cdecl = nil;
  f_ASN1_OBJECT_new : function:PASN1_OBJECT cdecl = nil;
  f_ASN1_OBJECT_free : procedure(a: PASN1_OBJECT) cdecl = nil;
  f_i2d_ASN1_OBJECT : function(a: PASN1_OBJECT; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_OBJECT : function(a: PPASN1_OBJECT; pp: PPChar; length: Longint):PASN1_OBJECT cdecl = nil;
  f_sk_ASN1_OBJECT_new : function(arg0: PFunction):PSTACK_ASN1_OBJECT cdecl = nil;
  f_sk_ASN1_OBJECT_new_null : function:PSTACK_ASN1_OBJECT cdecl = nil;
  f_sk_ASN1_OBJECT_free : procedure(sk: PSTACK_ASN1_OBJECT) cdecl = nil;
  f_sk_ASN1_OBJECT_num : function(const sk: PSTACK_ASN1_OBJECT):Integer cdecl = nil;
  f_sk_ASN1_OBJECT_value : function(const sk: PSTACK_ASN1_OBJECT; n: Integer):PASN1_OBJECT cdecl = nil;
  f_sk_ASN1_OBJECT_set : function(sk: PSTACK_ASN1_OBJECT; n: Integer; v: PASN1_OBJECT):PASN1_OBJECT cdecl = nil;
  f_sk_ASN1_OBJECT_zero : procedure(sk: PSTACK_ASN1_OBJECT) cdecl = nil;
  f_sk_ASN1_OBJECT_push : function(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT):Integer cdecl = nil;
  f_sk_ASN1_OBJECT_unshift : function(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT):Integer cdecl = nil;
  f_sk_ASN1_OBJECT_find : function(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT):Integer cdecl = nil;
  f_sk_ASN1_OBJECT_delete : function(sk: PSTACK_ASN1_OBJECT; n: Integer):PASN1_OBJECT cdecl = nil;
  f_sk_ASN1_OBJECT_delete_ptr : procedure(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT) cdecl = nil;
  f_sk_ASN1_OBJECT_insert : function(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT; n: Integer):Integer cdecl = nil;
  f_sk_ASN1_OBJECT_dup : function(sk: PSTACK_ASN1_OBJECT):PSTACK_ASN1_OBJECT cdecl = nil;
  f_sk_ASN1_OBJECT_pop_free : procedure(sk: PSTACK_ASN1_OBJECT; arg1: PFunction) cdecl = nil;
  f_sk_ASN1_OBJECT_shift : function(sk: PSTACK_ASN1_OBJECT):PASN1_OBJECT cdecl = nil;
  f_sk_ASN1_OBJECT_pop : function(sk: PSTACK_ASN1_OBJECT):PASN1_OBJECT cdecl = nil;
  f_sk_ASN1_OBJECT_sort : procedure(sk: PSTACK_ASN1_OBJECT) cdecl = nil;
  f_i2d_ASN1_SET_OF_ASN1_OBJECT : function(a: PSTACK_ASN1_OBJECT; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET_OF_ASN1_OBJECT : function(a: PPSTACK_ASN1_OBJECT; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_ASN1_OBJECT cdecl = nil;
  f_ASN1_STRING_new : function:PASN1_STRING cdecl = nil;
  f_ASN1_STRING_free : procedure(a: PASN1_STRING) cdecl = nil;
  f_ASN1_STRING_dup : function(a: PASN1_STRING):PASN1_STRING cdecl = nil;
  f_ASN1_STRING_type_new : function(_type: Integer):PASN1_STRING cdecl = nil;
  f_ASN1_STRING_cmp : function(a: PASN1_STRING; b: PASN1_STRING):Integer cdecl = nil;
  f_ASN1_STRING_set : function(str: PASN1_STRING; const data: Pointer; len: Integer):Integer cdecl = nil;
  f_i2d_ASN1_BIT_STRING : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_BIT_STRING : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_ASN1_BIT_STRING_set_bit : function(a: PASN1_STRING; n: Integer; value: Integer):Integer cdecl = nil;
  f_ASN1_BIT_STRING_get_bit : function(a: PASN1_STRING; n: Integer):Integer cdecl = nil;
  f_i2d_ASN1_BOOLEAN : function(a: Integer; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_BOOLEAN : function(a: PInteger; pp: PPChar; length: Longint):Integer cdecl = nil;
  f_i2d_ASN1_INTEGER : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_INTEGER : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_d2i_ASN1_UINTEGER : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_i2d_ASN1_ENUMERATED : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_ENUMERATED : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_ASN1_UTCTIME_check : function(a: PASN1_STRING):Integer cdecl = nil;
  f_ASN1_UTCTIME_set : function(s: PASN1_STRING; t: time_t):PASN1_STRING cdecl = nil;
  f_ASN1_UTCTIME_set_string : function(s: PASN1_STRING; str: PChar):Integer cdecl = nil;
  f_ASN1_GENERALIZEDTIME_check : function(a: PASN1_STRING):Integer cdecl = nil;
  f_ASN1_GENERALIZEDTIME_set : function(s: PASN1_STRING; t: time_t):PASN1_STRING cdecl = nil;
  f_ASN1_GENERALIZEDTIME_set_string : function(s: PASN1_STRING; str: PChar):Integer cdecl = nil;
  f_i2d_ASN1_OCTET_STRING : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_OCTET_STRING : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_i2d_ASN1_VISIBLESTRING : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_VISIBLESTRING : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_i2d_ASN1_UTF8STRING : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_UTF8STRING : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_i2d_ASN1_BMPSTRING : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_BMPSTRING : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_i2d_ASN1_PRINTABLE : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_PRINTABLE : function(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING cdecl = nil;
  f_d2i_ASN1_PRINTABLESTRING : function(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING cdecl = nil;
  f_i2d_DIRECTORYSTRING : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_DIRECTORYSTRING : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_i2d_DISPLAYTEXT : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_DISPLAYTEXT : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_d2i_ASN1_T61STRING : function(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING cdecl = nil;
  f_i2d_ASN1_IA5STRING : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_IA5STRING : function(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING cdecl = nil;
  f_i2d_ASN1_UTCTIME : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_UTCTIME : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_i2d_ASN1_GENERALIZEDTIME : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_GENERALIZEDTIME : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_i2d_ASN1_TIME : function(a: PASN1_STRING; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_TIME : function(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING cdecl = nil;
  f_ASN1_TIME_set : function(s: PASN1_STRING; t: time_t):PASN1_STRING cdecl = nil;
  f_i2d_ASN1_SET : function(a: PSTACK; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET : function(a: PPSTACK; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK cdecl = nil;
  f_i2a_ASN1_INTEGER : function(bp: PBIO; a: PASN1_STRING):Integer cdecl = nil;
  f_a2i_ASN1_INTEGER : function(bp: PBIO; bs: PASN1_STRING; buf: PChar; size: Integer):Integer cdecl = nil;
  f_i2a_ASN1_ENUMERATED : function(bp: PBIO; a: PASN1_STRING):Integer cdecl = nil;
  f_a2i_ASN1_ENUMERATED : function(bp: PBIO; bs: PASN1_STRING; buf: PChar; size: Integer):Integer cdecl = nil;
  f_i2a_ASN1_OBJECT : function(bp: PBIO; a: PASN1_OBJECT):Integer cdecl = nil;
  f_a2i_ASN1_STRING : function(bp: PBIO; bs: PASN1_STRING; buf: PChar; size: Integer):Integer cdecl = nil;
  f_i2a_ASN1_STRING : function(bp: PBIO; a: PASN1_STRING; _type: Integer):Integer cdecl = nil;
  f_i2t_ASN1_OBJECT : function(buf: PChar; buf_len: Integer; a: PASN1_OBJECT):Integer cdecl = nil;
  f_a2d_ASN1_OBJECT : function(_out: PChar; olen: Integer; const buf: PChar; num: Integer):Integer cdecl = nil;
  f_ASN1_OBJECT_create : function(nid: Integer; data: PChar; len: Integer; sn: PChar; ln: PChar):PASN1_OBJECT cdecl = nil;
  f_ASN1_INTEGER_set : function(a: PASN1_STRING; v: Longint):Integer cdecl = nil;
  f_ASN1_INTEGER_get : function(a: PASN1_STRING):Longint cdecl = nil;
  f_BN_to_ASN1_INTEGER : function(bn: PBIGNUM; ai: PASN1_STRING):PASN1_STRING cdecl = nil;
  f_ASN1_INTEGER_to_BN : function(ai: PASN1_STRING; bn: PBIGNUM):PBIGNUM cdecl = nil;
  f_ASN1_ENUMERATED_set : function(a: PASN1_STRING; v: Longint):Integer cdecl = nil;
  f_ASN1_ENUMERATED_get : function(a: PASN1_STRING):Longint cdecl = nil;
  f_BN_to_ASN1_ENUMERATED : function(bn: PBIGNUM; ai: PASN1_STRING):PASN1_STRING cdecl = nil;
  f_ASN1_ENUMERATED_to_BN : function(ai: PASN1_STRING; bn: PBIGNUM):PBIGNUM cdecl = nil;
  f_ASN1_PRINTABLE_type : function(s: PChar; max: Integer):Integer cdecl = nil;
  f_i2d_ASN1_bytes : function(a: PASN1_STRING; pp: PPChar; tag: Integer; xclass: Integer):Integer cdecl = nil;
  f_d2i_ASN1_bytes : function(a: PPASN1_STRING; pp: PPChar; length: Longint; Ptag: Integer; Pclass: Integer):PASN1_STRING cdecl = nil;
  f_d2i_ASN1_type_bytes : function(a: PPASN1_STRING; pp: PPChar; length: Longint; _type: Integer):PASN1_STRING cdecl = nil;
  f_asn1_Finish : function(c: PASN1_CTX):Integer cdecl = nil;
  f_ASN1_get_object : function(pp: PPChar; plength: PLong; ptag: PInteger; pclass: PInteger; omax: Longint):Integer cdecl = nil;
  f_ASN1_check_infinite_end : function(p: PPChar; len: Longint):Integer cdecl = nil;
  f_ASN1_put_object : procedure(pp: PPChar; constructed: Integer; length: Integer; tag: Integer; xclass: Integer) cdecl = nil;
  f_ASN1_object_size : function(constructed: Integer; length: Integer; tag: Integer):Integer cdecl = nil;
  f_ASN1_dup : function(arg0: PFunction; arg1: PFunction; x: PChar):PChar cdecl = nil;
  f_ASN1_d2i_fp : function(arg0: PFunction; arg1: PFunction; fp: PFILE; x: PPChar):PChar cdecl = nil;
  f_ASN1_i2d_fp : function(arg0: PFunction; _out: PFILE; x: PChar):Integer cdecl = nil;
  f_ASN1_d2i_bio : function(arg0: PFunction; arg1: PFunction; bp: PBIO; x: PPChar):PChar cdecl = nil;
  f_ASN1_i2d_bio : function(arg0: PFunction; _out: PBIO; x: PChar):Integer cdecl = nil;
  f_ASN1_UTCTIME_print : function(fp: PBIO; a: PASN1_STRING):Integer cdecl = nil;
  f_ASN1_GENERALIZEDTIME_print : function(fp: PBIO; a: PASN1_STRING):Integer cdecl = nil;
  f_ASN1_TIME_print : function(fp: PBIO; a: PASN1_STRING):Integer cdecl = nil;
  f_ASN1_STRING_print : function(bp: PBIO; v: PASN1_STRING):Integer cdecl = nil;
  f_ASN1_parse : function(bp: PBIO; pp: PChar; len: Longint; indent: Integer):Integer cdecl = nil;
  f_i2d_ASN1_HEADER : function(a: PASN1_HEADER; pp: PPChar):Integer cdecl = nil;
  f_d2i_ASN1_HEADER : function(a: PPASN1_HEADER; pp: PPChar; length: Longint):PASN1_HEADER cdecl = nil;
  f_ASN1_HEADER_new : function:PASN1_HEADER cdecl = nil;
  f_ASN1_HEADER_free : procedure(a: PASN1_HEADER) cdecl = nil;
  f_ASN1_UNIVERSALSTRING_to_string : function(s: PASN1_STRING):Integer cdecl = nil;
  f_ERR_load_ASN1_strings : procedure cdecl = nil;
  f_X509_asn1_meth : function:PASN1_METHOD cdecl = nil;
  f_RSAPrivateKey_asn1_meth : function:PASN1_METHOD cdecl = nil;
  f_ASN1_IA5STRING_asn1_meth : function:PASN1_METHOD cdecl = nil;
  f_ASN1_BIT_STRING_asn1_meth : function:PASN1_METHOD cdecl = nil;
  f_ASN1_TYPE_set_octetstring : function(a: PASN1_TYPE; data: PChar; len: Integer):Integer cdecl = nil;
  f_ASN1_TYPE_get_octetstring : function(a: PASN1_TYPE; data: PChar; max_len: Integer):Integer cdecl = nil;
  f_ASN1_TYPE_set_int_octetstring : function(a: PASN1_TYPE; num: Longint; data: PChar; len: Integer):Integer cdecl = nil;
  f_ASN1_TYPE_get_int_octetstring : function(a: PASN1_TYPE; num: PLong; data: PChar; max_len: Integer):Integer cdecl = nil;
  f_ASN1_seq_unpack : function(buf: PChar; len: Integer; arg2: PFunction; arg3: PFunction):PSTACK cdecl = nil;
  f_ASN1_seq_pack : function(safes: PSTACK; arg1: PFunction; buf: PPChar; len: PInteger):PChar cdecl = nil;
  f_ASN1_unpack_string : function(oct: PASN1_STRING; arg1: PFunction):Pointer cdecl = nil;
  f_ASN1_pack_string : function(obj: Pointer; arg1: PFunction; oct: PPASN1_STRING):PASN1_STRING cdecl = nil;
  f_OBJ_NAME_init : function:Integer cdecl = nil;
  f_OBJ_NAME_new_index : function(arg0: PFunction; arg1: PFunction; arg2: PFunction):Integer cdecl = nil;
  f_OBJ_NAME_get : function(const name: PChar; _type: Integer):PChar cdecl = nil;
  f_OBJ_NAME_add : function(const name: PChar; _type: Integer; const data: PChar):Integer cdecl = nil;
  f_OBJ_NAME_remove : function(const name: PChar; _type: Integer):Integer cdecl = nil;
  f_OBJ_NAME_cleanup : procedure(_type: Integer) cdecl = nil;
  f_OBJ_dup : function(o: PASN1_OBJECT):PASN1_OBJECT cdecl = nil;
  f_OBJ_nid2obj : function(n: Integer):PASN1_OBJECT cdecl = nil;
  f_OBJ_nid2ln : function(n: Integer):PChar cdecl = nil;
  f_OBJ_nid2sn : function(n: Integer):PChar cdecl = nil;
  f_OBJ_obj2nid : function(o: PASN1_OBJECT):Integer cdecl = nil;
  f_OBJ_txt2obj : function(const s: PChar; no_name: Integer):PASN1_OBJECT cdecl = nil;
  f_OBJ_obj2txt : function(buf: PChar; buf_len: Integer; a: PASN1_OBJECT; no_name: Integer):Integer cdecl = nil;
  f_OBJ_txt2nid : function(s: PChar):Integer cdecl = nil;
  f_OBJ_ln2nid : function(const s: PChar):Integer cdecl = nil;
  f_OBJ_sn2nid : function(const s: PChar):Integer cdecl = nil;
  f_OBJ_cmp : function(a: PASN1_OBJECT; b: PASN1_OBJECT):Integer cdecl = nil;
  f_OBJ_bsearch : function(key: PChar; base: PChar; num: Integer; size: Integer; arg4: PFunction):PChar cdecl = nil;
  f_ERR_load_OBJ_strings : procedure cdecl = nil;
  f_OBJ_new_nid : function(num: Integer):Integer cdecl = nil;
  f_OBJ_add_object : function(obj: PASN1_OBJECT):Integer cdecl = nil;
  f_OBJ_create : function(oid: PChar; sn: PChar; ln: PChar):Integer cdecl = nil;
  f_OBJ_cleanup : procedure cdecl = nil;
  f_OBJ_create_objects : function(_in: PBIO):Integer cdecl = nil;
  f_EVP_MD_CTX_copy : function(_out: PEVP_MD_CTX; _in: PEVP_MD_CTX):Integer cdecl = nil;
  f_EVP_DigestInit : procedure(ctx: PEVP_MD_CTX; const _type: PEVP_MD) cdecl = nil;
  f_EVP_DigestUpdate : procedure(ctx: PEVP_MD_CTX; const d: Pointer; cnt: UInteger) cdecl = nil;
  f_EVP_DigestFinal : procedure(ctx: PEVP_MD_CTX; md: PChar; s: PUInteger) cdecl = nil;
  f_EVP_read_pw_string : function(buf: PChar; length: Integer; const prompt: PChar; verify: Integer):Integer cdecl = nil;
  f_EVP_set_pw_prompt : procedure(prompt: PChar) cdecl = nil;
  f_EVP_get_pw_prompt : function:PChar cdecl = nil;
  f_EVP_BytesToKey : function(const _type: PEVP_CIPHER; md: PEVP_MD; salt: PChar; data: PChar; datal: Integer; count: Integer; key: PChar; iv: PChar):Integer cdecl = nil;
  f_EVP_EncryptInit : procedure(ctx: PEVP_CIPHER_CTX; const _type: PEVP_CIPHER; key: PChar; iv: PChar) cdecl = nil;
  f_EVP_EncryptUpdate : procedure(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer) cdecl = nil;
  f_EVP_EncryptFinal : procedure(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger) cdecl = nil;
  f_EVP_DecryptInit : procedure(ctx: PEVP_CIPHER_CTX; const _type: PEVP_CIPHER; key: PChar; iv: PChar) cdecl = nil;
  f_EVP_DecryptUpdate : procedure(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer) cdecl = nil;
  f_EVP_DecryptFinal : function(ctx: PEVP_CIPHER_CTX; outm: PChar; outl: PInteger):Integer cdecl = nil;
  f_EVP_CipherInit : procedure(ctx: PEVP_CIPHER_CTX; const _type: PEVP_CIPHER; key: PChar; iv: PChar; enc: Integer) cdecl = nil;
  f_EVP_CipherUpdate : procedure(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer) cdecl = nil;
  f_EVP_CipherFinal : function(ctx: PEVP_CIPHER_CTX; outm: PChar; outl: PInteger):Integer cdecl = nil;
  f_EVP_SignFinal : function(ctx: PEVP_MD_CTX; md: PChar; s: PUInteger; pkey: PEVP_PKEY):Integer cdecl = nil;
  f_EVP_VerifyFinal : function(ctx: PEVP_MD_CTX; sigbuf: PChar; siglen: UInteger; pkey: PEVP_PKEY):Integer cdecl = nil;
  f_EVP_OpenInit : function(ctx: PEVP_CIPHER_CTX; _type: PEVP_CIPHER; ek: PChar; ekl: Integer; iv: PChar; priv: PEVP_PKEY):Integer cdecl = nil;
  f_EVP_OpenFinal : function(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger):Integer cdecl = nil;
  f_EVP_SealInit : function(ctx: PEVP_CIPHER_CTX; _type: PEVP_CIPHER; ek: PPChar; ekl: PInteger; iv: PChar; pubk: PPEVP_PKEY; npubk: Integer):Integer cdecl = nil;
  f_EVP_SealFinal : procedure(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger) cdecl = nil;
  f_EVP_EncodeInit : procedure(ctx: PEVP_ENCODE_CTX) cdecl = nil;
  f_EVP_EncodeUpdate : procedure(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer) cdecl = nil;
  f_EVP_EncodeFinal : procedure(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger) cdecl = nil;
  f_EVP_EncodeBlock : function(t: PChar; f: PChar; n: Integer):Integer cdecl = nil;
  f_EVP_DecodeInit : procedure(ctx: PEVP_ENCODE_CTX) cdecl = nil;
  f_EVP_DecodeUpdate : function(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer):Integer cdecl = nil;
  f_EVP_DecodeFinal : function(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger):Integer cdecl = nil;
  f_EVP_DecodeBlock : function(t: PChar; f: PChar; n: Integer):Integer cdecl = nil;
  f_ERR_load_EVP_strings : procedure cdecl = nil;
  f_EVP_CIPHER_CTX_init : procedure(a: PEVP_CIPHER_CTX) cdecl = nil;
  f_EVP_CIPHER_CTX_cleanup : procedure(a: PEVP_CIPHER_CTX) cdecl = nil;
  f_BIO_f_md : function:PBIO_METHOD cdecl = nil;
  f_BIO_f_base64 : function:PBIO_METHOD cdecl = nil;
  f_BIO_f_cipher : function:PBIO_METHOD cdecl = nil;
  f_BIO_f_reliable : function:PBIO_METHOD cdecl = nil;
  f_BIO_set_cipher : procedure(b: PBIO; const c: PEVP_CIPHER; k: PChar; i: PChar; enc: Integer) cdecl = nil;
  f_EVP_md_null : function:PEVP_MD cdecl = nil;
  f_EVP_md2 : function:PEVP_MD cdecl = nil;
  f_EVP_md5 : function:PEVP_MD cdecl = nil;
  f_EVP_sha : function:PEVP_MD cdecl = nil;
  f_EVP_sha1 : function:PEVP_MD cdecl = nil;
  f_EVP_dss : function:PEVP_MD cdecl = nil;
  f_EVP_dss1 : function:PEVP_MD cdecl = nil;
  f_EVP_mdc2 : function:PEVP_MD cdecl = nil;
  f_EVP_ripemd160 : function:PEVP_MD cdecl = nil;
  f_EVP_enc_null : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_ecb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_ede : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_ede3 : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_cfb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_ede_cfb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_ede3_cfb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_ofb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_ede_ofb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_ede3_ofb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_cbc : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_ede_cbc : function:PEVP_CIPHER cdecl = nil;
  f_EVP_des_ede3_cbc : function:PEVP_CIPHER cdecl = nil;
  f_EVP_desx_cbc : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc4 : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc4_40 : function:PEVP_CIPHER cdecl = nil;
  f_EVP_idea_ecb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_idea_cfb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_idea_ofb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_idea_cbc : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc2_ecb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc2_cbc : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc2_40_cbc : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc2_64_cbc : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc2_cfb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc2_ofb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_bf_ecb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_bf_cbc : function:PEVP_CIPHER cdecl = nil;
  f_EVP_bf_cfb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_bf_ofb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_cast5_ecb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_cast5_cbc : function:PEVP_CIPHER cdecl = nil;
  f_EVP_cast5_cfb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_cast5_ofb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc5_32_12_16_cbc : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc5_32_12_16_ecb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc5_32_12_16_cfb : function:PEVP_CIPHER cdecl = nil;
  f_EVP_rc5_32_12_16_ofb : function:PEVP_CIPHER cdecl = nil;
  f_SSLeay_add_all_algorithms : procedure cdecl = nil;
  f_SSLeay_add_all_ciphers : procedure cdecl = nil;
  f_SSLeay_add_all_digests : procedure cdecl = nil;
  f_EVP_add_cipher : function(cipher: PEVP_CIPHER):Integer cdecl = nil;
  f_EVP_add_digest : function(digest: PEVP_MD):Integer cdecl = nil;
  f_EVP_get_cipherbyname : function(const name: PChar):PEVP_CIPHER cdecl = nil;
  f_EVP_get_digestbyname : function(const name: PChar):PEVP_MD cdecl = nil;
  f_EVP_cleanup : procedure cdecl = nil;
  f_EVP_PKEY_decrypt : function(dec_key: PChar; enc_key: PChar; enc_key_len: Integer; private_key: PEVP_PKEY):Integer cdecl = nil;
  f_EVP_PKEY_encrypt : function(enc_key: PChar; key: PChar; key_len: Integer; pub_key: PEVP_PKEY):Integer cdecl = nil;
  f_EVP_PKEY_type : function(_type: Integer):Integer cdecl = nil;
  f_EVP_PKEY_bits : function(pkey: PEVP_PKEY):Integer cdecl = nil;
  f_EVP_PKEY_size : function(pkey: PEVP_PKEY):Integer cdecl = nil;
  f_EVP_PKEY_assign : function(pkey: PEVP_PKEY; _type: Integer; key: PChar):Integer cdecl = nil;
  f_EVP_PKEY_new : function:PEVP_PKEY cdecl = nil;
  f_EVP_PKEY_free : procedure(pkey: PEVP_PKEY) cdecl = nil;
  f_d2i_PublicKey : function(_type: Integer; a: PPEVP_PKEY; pp: PPChar; length: Longint):PEVP_PKEY cdecl = nil;
  f_i2d_PublicKey : function(a: PEVP_PKEY; pp: PPChar):Integer cdecl = nil;
  f_d2i_PrivateKey : function(_type: Integer; a: PPEVP_PKEY; pp: PPChar; length: Longint):PEVP_PKEY cdecl = nil;
  f_i2d_PrivateKey : function(a: PEVP_PKEY; pp: PPChar):Integer cdecl = nil;
  f_EVP_PKEY_copy_parameters : function(_to: PEVP_PKEY; from: PEVP_PKEY):Integer cdecl = nil;
  f_EVP_PKEY_missing_parameters : function(pkey: PEVP_PKEY):Integer cdecl = nil;
  f_EVP_PKEY_save_parameters : function(pkey: PEVP_PKEY; mode: Integer):Integer cdecl = nil;
  f_EVP_PKEY_cmp_parameters : function(a: PEVP_PKEY; b: PEVP_PKEY):Integer cdecl = nil;
  f_EVP_CIPHER_type : function(const ctx: PEVP_CIPHER):Integer cdecl = nil;
  f_EVP_CIPHER_param_to_asn1 : function(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer cdecl = nil;
  f_EVP_CIPHER_asn1_to_param : function(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer cdecl = nil;
  f_EVP_CIPHER_set_asn1_iv : function(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer cdecl = nil;
  f_EVP_CIPHER_get_asn1_iv : function(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer cdecl = nil;
  f_PKCS5_PBE_keyivgen : function(ctx: PEVP_CIPHER_CTX; const pass: PChar; passlen: Integer; param: PASN1_TYPE; cipher: PEVP_CIPHER; md: PEVP_MD; en_de: Integer):Integer cdecl = nil;
  f_PKCS5_PBKDF2_HMAC_SHA1 : function(const pass: PChar; passlen: Integer; salt: PChar; saltlen: Integer; iter: Integer; keylen: Integer; _out: PChar):Integer cdecl = nil;
  f_PKCS5_v2_PBE_keyivgen : function(ctx: PEVP_CIPHER_CTX; const pass: PChar; passlen: Integer; param: PASN1_TYPE; cipher: PEVP_CIPHER; md: PEVP_MD; en_de: Integer):Integer cdecl = nil;
  f_PKCS5_PBE_add : procedure cdecl = nil;
  f_EVP_PBE_CipherInit : function(pbe_obj: PASN1_OBJECT; const pass: PChar; passlen: Integer; param: PASN1_TYPE; ctx: PEVP_CIPHER_CTX; en_de: Integer):Integer cdecl = nil;
  f_EVP_PBE_alg_add : function(nid: Integer; cipher: PEVP_CIPHER; md: PEVP_MD; keygen: PEVP_PBE_KEYGEN):Integer cdecl = nil;
  f_EVP_PBE_cleanup : procedure cdecl = nil;
  f_sk_X509_ALGOR_new : function(arg0: PFunction):PSTACK_X509_ALGOR cdecl = nil;
  f_sk_X509_ALGOR_new_null : function:PSTACK_X509_ALGOR cdecl = nil;
  f_sk_X509_ALGOR_free : procedure(sk: PSTACK_X509_ALGOR) cdecl = nil;
  f_sk_X509_ALGOR_num : function(const sk: PSTACK_X509_ALGOR):Integer cdecl = nil;
  f_sk_X509_ALGOR_value : function(const sk: PSTACK_X509_ALGOR; n: Integer):PX509_ALGOR cdecl = nil;
  f_sk_X509_ALGOR_set : function(sk: PSTACK_X509_ALGOR; n: Integer; v: PX509_ALGOR):PX509_ALGOR cdecl = nil;
  f_sk_X509_ALGOR_zero : procedure(sk: PSTACK_X509_ALGOR) cdecl = nil;
  f_sk_X509_ALGOR_push : function(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR):Integer cdecl = nil;
  f_sk_X509_ALGOR_unshift : function(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR):Integer cdecl = nil;
  f_sk_X509_ALGOR_find : function(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR):Integer cdecl = nil;
  f_sk_X509_ALGOR_delete : function(sk: PSTACK_X509_ALGOR; n: Integer):PX509_ALGOR cdecl = nil;
  f_sk_X509_ALGOR_delete_ptr : procedure(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR) cdecl = nil;
  f_sk_X509_ALGOR_insert : function(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR; n: Integer):Integer cdecl = nil;
  f_sk_X509_ALGOR_dup : function(sk: PSTACK_X509_ALGOR):PSTACK_X509_ALGOR cdecl = nil;
  f_sk_X509_ALGOR_pop_free : procedure(sk: PSTACK_X509_ALGOR; arg1: PFunction) cdecl = nil;
  f_sk_X509_ALGOR_shift : function(sk: PSTACK_X509_ALGOR):PX509_ALGOR cdecl = nil;
  f_sk_X509_ALGOR_pop : function(sk: PSTACK_X509_ALGOR):PX509_ALGOR cdecl = nil;
  f_sk_X509_ALGOR_sort : procedure(sk: PSTACK_X509_ALGOR) cdecl = nil;
  f_i2d_ASN1_SET_OF_X509_ALGOR : function(a: PSTACK_X509_ALGOR; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET_OF_X509_ALGOR : function(a: PPSTACK_X509_ALGOR; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_ALGOR cdecl = nil;
  f_sk_X509_NAME_ENTRY_new : function(arg0: PFunction):PSTACK_X509_NAME_ENTRY cdecl = nil;
  f_sk_X509_NAME_ENTRY_new_null : function:PSTACK_X509_NAME_ENTRY cdecl = nil;
  f_sk_X509_NAME_ENTRY_free : procedure(sk: PSTACK_X509_NAME_ENTRY) cdecl = nil;
  f_sk_X509_NAME_ENTRY_num : function(const sk: PSTACK_X509_NAME_ENTRY):Integer cdecl = nil;
  f_sk_X509_NAME_ENTRY_value : function(const sk: PSTACK_X509_NAME_ENTRY; n: Integer):PX509_NAME_ENTRY cdecl = nil;
  f_sk_X509_NAME_ENTRY_set : function(sk: PSTACK_X509_NAME_ENTRY; n: Integer; v: PX509_NAME_ENTRY):PX509_NAME_ENTRY cdecl = nil;
  f_sk_X509_NAME_ENTRY_zero : procedure(sk: PSTACK_X509_NAME_ENTRY) cdecl = nil;
  f_sk_X509_NAME_ENTRY_push : function(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY):Integer cdecl = nil;
  f_sk_X509_NAME_ENTRY_unshift : function(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY):Integer cdecl = nil;
  f_sk_X509_NAME_ENTRY_find : function(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY):Integer cdecl = nil;
  f_sk_X509_NAME_ENTRY_delete : function(sk: PSTACK_X509_NAME_ENTRY; n: Integer):PX509_NAME_ENTRY cdecl = nil;
  f_sk_X509_NAME_ENTRY_delete_ptr : procedure(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY) cdecl = nil;
  f_sk_X509_NAME_ENTRY_insert : function(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY; n: Integer):Integer cdecl = nil;
  f_sk_X509_NAME_ENTRY_dup : function(sk: PSTACK_X509_NAME_ENTRY):PSTACK_X509_NAME_ENTRY cdecl = nil;
  f_sk_X509_NAME_ENTRY_pop_free : procedure(sk: PSTACK_X509_NAME_ENTRY; arg1: PFunction) cdecl = nil;
  f_sk_X509_NAME_ENTRY_shift : function(sk: PSTACK_X509_NAME_ENTRY):PX509_NAME_ENTRY cdecl = nil;
  f_sk_X509_NAME_ENTRY_pop : function(sk: PSTACK_X509_NAME_ENTRY):PX509_NAME_ENTRY cdecl = nil;
  f_sk_X509_NAME_ENTRY_sort : procedure(sk: PSTACK_X509_NAME_ENTRY) cdecl = nil;
  f_i2d_ASN1_SET_OF_X509_NAME_ENTRY : function(a: PSTACK_X509_NAME_ENTRY; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET_OF_X509_NAME_ENTRY : function(a: PPSTACK_X509_NAME_ENTRY; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_NAME_ENTRY cdecl = nil;
  f_sk_X509_NAME_new : function(arg0: PFunction):PSTACK_X509_NAME cdecl = nil;
  f_sk_X509_NAME_new_null : function:PSTACK_X509_NAME cdecl = nil;
  f_sk_X509_NAME_free : procedure(sk: PSTACK_X509_NAME) cdecl = nil;
  f_sk_X509_NAME_num : function(const sk: PSTACK_X509_NAME):Integer cdecl = nil;
  f_sk_X509_NAME_value : function(const sk: PSTACK_X509_NAME; n: Integer):PX509_NAME cdecl = nil;
  f_sk_X509_NAME_set : function(sk: PSTACK_X509_NAME; n: Integer; v: PX509_NAME):PX509_NAME cdecl = nil;
  f_sk_X509_NAME_zero : procedure(sk: PSTACK_X509_NAME) cdecl = nil;
  f_sk_X509_NAME_push : function(sk: PSTACK_X509_NAME; v: PX509_NAME):Integer cdecl = nil;
  f_sk_X509_NAME_unshift : function(sk: PSTACK_X509_NAME; v: PX509_NAME):Integer cdecl = nil;
  f_sk_X509_NAME_find : function(sk: PSTACK_X509_NAME; v: PX509_NAME):Integer cdecl = nil;
  f_sk_X509_NAME_delete : function(sk: PSTACK_X509_NAME; n: Integer):PX509_NAME cdecl = nil;
  f_sk_X509_NAME_delete_ptr : procedure(sk: PSTACK_X509_NAME; v: PX509_NAME) cdecl = nil;
  f_sk_X509_NAME_insert : function(sk: PSTACK_X509_NAME; v: PX509_NAME; n: Integer):Integer cdecl = nil;
  f_sk_X509_NAME_dup : function(sk: PSTACK_X509_NAME):PSTACK_X509_NAME cdecl = nil;
  f_sk_X509_NAME_pop_free : procedure(sk: PSTACK_X509_NAME; arg1: PFunction) cdecl = nil;
  f_sk_X509_NAME_shift : function(sk: PSTACK_X509_NAME):PX509_NAME cdecl = nil;
  f_sk_X509_NAME_pop : function(sk: PSTACK_X509_NAME):PX509_NAME cdecl = nil;
  f_sk_X509_NAME_sort : procedure(sk: PSTACK_X509_NAME) cdecl = nil;
  f_sk_X509_EXTENSION_new : function(arg0: PFunction):PSTACK_X509_EXTENSION cdecl = nil;
  f_sk_X509_EXTENSION_new_null : function:PSTACK_X509_EXTENSION cdecl = nil;
  f_sk_X509_EXTENSION_free : procedure(sk: PSTACK_X509_EXTENSION) cdecl = nil;
  f_sk_X509_EXTENSION_num : function(const sk: PSTACK_X509_EXTENSION):Integer cdecl = nil;
  f_sk_X509_EXTENSION_value : function(const sk: PSTACK_X509_EXTENSION; n: Integer):PX509_EXTENSION cdecl = nil;
  f_sk_X509_EXTENSION_set : function(sk: PSTACK_X509_EXTENSION; n: Integer; v: PX509_EXTENSION):PX509_EXTENSION cdecl = nil;
  f_sk_X509_EXTENSION_zero : procedure(sk: PSTACK_X509_EXTENSION) cdecl = nil;
  f_sk_X509_EXTENSION_push : function(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION):Integer cdecl = nil;
  f_sk_X509_EXTENSION_unshift : function(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION):Integer cdecl = nil;
  f_sk_X509_EXTENSION_find : function(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION):Integer cdecl = nil;
  f_sk_X509_EXTENSION_delete : function(sk: PSTACK_X509_EXTENSION; n: Integer):PX509_EXTENSION cdecl = nil;
  f_sk_X509_EXTENSION_delete_ptr : procedure(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION) cdecl = nil;
  f_sk_X509_EXTENSION_insert : function(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION; n: Integer):Integer cdecl = nil;
  f_sk_X509_EXTENSION_dup : function(sk: PSTACK_X509_EXTENSION):PSTACK_X509_EXTENSION cdecl = nil;
  f_sk_X509_EXTENSION_pop_free : procedure(sk: PSTACK_X509_EXTENSION; arg1: PFunction) cdecl = nil;
  f_sk_X509_EXTENSION_shift : function(sk: PSTACK_X509_EXTENSION):PX509_EXTENSION cdecl = nil;
  f_sk_X509_EXTENSION_pop : function(sk: PSTACK_X509_EXTENSION):PX509_EXTENSION cdecl = nil;
  f_sk_X509_EXTENSION_sort : procedure(sk: PSTACK_X509_EXTENSION) cdecl = nil;
  f_i2d_ASN1_SET_OF_X509_EXTENSION : function(a: PSTACK_X509_EXTENSION; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET_OF_X509_EXTENSION : function(a: PPSTACK_X509_EXTENSION; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_EXTENSION cdecl = nil;
  f_sk_X509_ATTRIBUTE_new : function(arg0: PFunction):PSTACK_X509_ATTRIBUTE cdecl = nil;
  f_sk_X509_ATTRIBUTE_new_null : function:PSTACK_X509_ATTRIBUTE cdecl = nil;
  f_sk_X509_ATTRIBUTE_free : procedure(sk: PSTACK_X509_ATTRIBUTE) cdecl = nil;
  f_sk_X509_ATTRIBUTE_num : function(const sk: PSTACK_X509_ATTRIBUTE):Integer cdecl = nil;
  f_sk_X509_ATTRIBUTE_value : function(const sk: PSTACK_X509_ATTRIBUTE; n: Integer):PX509_ATTRIBUTE cdecl = nil;
  f_sk_X509_ATTRIBUTE_set : function(sk: PSTACK_X509_ATTRIBUTE; n: Integer; v: PX509_ATTRIBUTE):PX509_ATTRIBUTE cdecl = nil;
  f_sk_X509_ATTRIBUTE_zero : procedure(sk: PSTACK_X509_ATTRIBUTE) cdecl = nil;
  f_sk_X509_ATTRIBUTE_push : function(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE):Integer cdecl = nil;
  f_sk_X509_ATTRIBUTE_unshift : function(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE):Integer cdecl = nil;
  f_sk_X509_ATTRIBUTE_find : function(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE):Integer cdecl = nil;
  f_sk_X509_ATTRIBUTE_delete : function(sk: PSTACK_X509_ATTRIBUTE; n: Integer):PX509_ATTRIBUTE cdecl = nil;
  f_sk_X509_ATTRIBUTE_delete_ptr : procedure(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE) cdecl = nil;
  f_sk_X509_ATTRIBUTE_insert : function(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE; n: Integer):Integer cdecl = nil;
  f_sk_X509_ATTRIBUTE_dup : function(sk: PSTACK_X509_ATTRIBUTE):PSTACK_X509_ATTRIBUTE cdecl = nil;
  f_sk_X509_ATTRIBUTE_pop_free : procedure(sk: PSTACK_X509_ATTRIBUTE; arg1: PFunction) cdecl = nil;
  f_sk_X509_ATTRIBUTE_shift : function(sk: PSTACK_X509_ATTRIBUTE):PX509_ATTRIBUTE cdecl = nil;
  f_sk_X509_ATTRIBUTE_pop : function(sk: PSTACK_X509_ATTRIBUTE):PX509_ATTRIBUTE cdecl = nil;
  f_sk_X509_ATTRIBUTE_sort : procedure(sk: PSTACK_X509_ATTRIBUTE) cdecl = nil;
  f_i2d_ASN1_SET_OF_X509_ATTRIBUTE : function(a: PSTACK_X509_ATTRIBUTE; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET_OF_X509_ATTRIBUTE : function(a: PPSTACK_X509_ATTRIBUTE; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_ATTRIBUTE cdecl = nil;
  f_sk_X509_new : function(arg0: PFunction):PSTACK_X509 cdecl = nil;
  f_sk_X509_new_null : function:PSTACK_X509 cdecl = nil;
  f_sk_X509_free : procedure(sk: PSTACK_X509) cdecl = nil;
  f_sk_X509_num : function(const sk: PSTACK_X509):Integer cdecl = nil;
  f_sk_X509_value : function(const sk: PSTACK_X509; n: Integer):PX509 cdecl = nil;
  f_sk_X509_set : function(sk: PSTACK_X509; n: Integer; v: PX509):PX509 cdecl = nil;
  f_sk_X509_zero : procedure(sk: PSTACK_X509) cdecl = nil;
  f_sk_X509_push : function(sk: PSTACK_X509; v: PX509):Integer cdecl = nil;
  f_sk_X509_unshift : function(sk: PSTACK_X509; v: PX509):Integer cdecl = nil;
  f_sk_X509_find : function(sk: PSTACK_X509; v: PX509):Integer cdecl = nil;
  f_sk_X509_delete : function(sk: PSTACK_X509; n: Integer):PX509 cdecl = nil;
  f_sk_X509_delete_ptr : procedure(sk: PSTACK_X509; v: PX509) cdecl = nil;
  f_sk_X509_insert : function(sk: PSTACK_X509; v: PX509; n: Integer):Integer cdecl = nil;
  f_sk_X509_dup : function(sk: PSTACK_X509):PSTACK_X509 cdecl = nil;
  f_sk_X509_pop_free : procedure(sk: PSTACK_X509; arg1: PFunction) cdecl = nil;
  f_sk_X509_shift : function(sk: PSTACK_X509):PX509 cdecl = nil;
  f_sk_X509_pop : function(sk: PSTACK_X509):PX509 cdecl = nil;
  f_sk_X509_sort : procedure(sk: PSTACK_X509) cdecl = nil;
  f_i2d_ASN1_SET_OF_X509 : function(a: PSTACK_X509; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET_OF_X509 : function(a: PPSTACK_X509; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509 cdecl = nil;
  f_sk_X509_REVOKED_new : function(arg0: PFunction):PSTACK_X509_REVOKED cdecl = nil;
  f_sk_X509_REVOKED_new_null : function:PSTACK_X509_REVOKED cdecl = nil;
  f_sk_X509_REVOKED_free : procedure(sk: PSTACK_X509_REVOKED) cdecl = nil;
  f_sk_X509_REVOKED_num : function(const sk: PSTACK_X509_REVOKED):Integer cdecl = nil;
  f_sk_X509_REVOKED_value : function(const sk: PSTACK_X509_REVOKED; n: Integer):PX509_REVOKED cdecl = nil;
  f_sk_X509_REVOKED_set : function(sk: PSTACK_X509_REVOKED; n: Integer; v: PX509_REVOKED):PX509_REVOKED cdecl = nil;
  f_sk_X509_REVOKED_zero : procedure(sk: PSTACK_X509_REVOKED) cdecl = nil;
  f_sk_X509_REVOKED_push : function(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED):Integer cdecl = nil;
  f_sk_X509_REVOKED_unshift : function(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED):Integer cdecl = nil;
  f_sk_X509_REVOKED_find : function(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED):Integer cdecl = nil;
  f_sk_X509_REVOKED_delete : function(sk: PSTACK_X509_REVOKED; n: Integer):PX509_REVOKED cdecl = nil;
  f_sk_X509_REVOKED_delete_ptr : procedure(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED) cdecl = nil;
  f_sk_X509_REVOKED_insert : function(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED; n: Integer):Integer cdecl = nil;
  f_sk_X509_REVOKED_dup : function(sk: PSTACK_X509_REVOKED):PSTACK_X509_REVOKED cdecl = nil;
  f_sk_X509_REVOKED_pop_free : procedure(sk: PSTACK_X509_REVOKED; arg1: PFunction) cdecl = nil;
  f_sk_X509_REVOKED_shift : function(sk: PSTACK_X509_REVOKED):PX509_REVOKED cdecl = nil;
  f_sk_X509_REVOKED_pop : function(sk: PSTACK_X509_REVOKED):PX509_REVOKED cdecl = nil;
  f_sk_X509_REVOKED_sort : procedure(sk: PSTACK_X509_REVOKED) cdecl = nil;
  f_i2d_ASN1_SET_OF_X509_REVOKED : function(a: PSTACK_X509_REVOKED; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET_OF_X509_REVOKED : function(a: PPSTACK_X509_REVOKED; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_REVOKED cdecl = nil;
  f_sk_X509_CRL_new : function(arg0: PFunction):PSTACK_X509_CRL cdecl = nil;
  f_sk_X509_CRL_new_null : function:PSTACK_X509_CRL cdecl = nil;
  f_sk_X509_CRL_free : procedure(sk: PSTACK_X509_CRL) cdecl = nil;
  f_sk_X509_CRL_num : function(const sk: PSTACK_X509_CRL):Integer cdecl = nil;
  f_sk_X509_CRL_value : function(const sk: PSTACK_X509_CRL; n: Integer):PX509_CRL cdecl = nil;
  f_sk_X509_CRL_set : function(sk: PSTACK_X509_CRL; n: Integer; v: PX509_CRL):PX509_CRL cdecl = nil;
  f_sk_X509_CRL_zero : procedure(sk: PSTACK_X509_CRL) cdecl = nil;
  f_sk_X509_CRL_push : function(sk: PSTACK_X509_CRL; v: PX509_CRL):Integer cdecl = nil;
  f_sk_X509_CRL_unshift : function(sk: PSTACK_X509_CRL; v: PX509_CRL):Integer cdecl = nil;
  f_sk_X509_CRL_find : function(sk: PSTACK_X509_CRL; v: PX509_CRL):Integer cdecl = nil;
  f_sk_X509_CRL_delete : function(sk: PSTACK_X509_CRL; n: Integer):PX509_CRL cdecl = nil;
  f_sk_X509_CRL_delete_ptr : procedure(sk: PSTACK_X509_CRL; v: PX509_CRL) cdecl = nil;
  f_sk_X509_CRL_insert : function(sk: PSTACK_X509_CRL; v: PX509_CRL; n: Integer):Integer cdecl = nil;
  f_sk_X509_CRL_dup : function(sk: PSTACK_X509_CRL):PSTACK_X509_CRL cdecl = nil;
  f_sk_X509_CRL_pop_free : procedure(sk: PSTACK_X509_CRL; arg1: PFunction) cdecl = nil;
  f_sk_X509_CRL_shift : function(sk: PSTACK_X509_CRL):PX509_CRL cdecl = nil;
  f_sk_X509_CRL_pop : function(sk: PSTACK_X509_CRL):PX509_CRL cdecl = nil;
  f_sk_X509_CRL_sort : procedure(sk: PSTACK_X509_CRL) cdecl = nil;
  f_i2d_ASN1_SET_OF_X509_CRL : function(a: PSTACK_X509_CRL; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET_OF_X509_CRL : function(a: PPSTACK_X509_CRL; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_CRL cdecl = nil;
  f_sk_X509_INFO_new : function(arg0: PFunction):PSTACK_X509_INFO cdecl = nil;
  f_sk_X509_INFO_new_null : function:PSTACK_X509_INFO cdecl = nil;
  f_sk_X509_INFO_free : procedure(sk: PSTACK_X509_INFO) cdecl = nil;
  f_sk_X509_INFO_num : function(const sk: PSTACK_X509_INFO):Integer cdecl = nil;
  f_sk_X509_INFO_value : function(const sk: PSTACK_X509_INFO; n: Integer):PX509_INFO cdecl = nil;
  f_sk_X509_INFO_set : function(sk: PSTACK_X509_INFO; n: Integer; v: PX509_INFO):PX509_INFO cdecl = nil;
  f_sk_X509_INFO_zero : procedure(sk: PSTACK_X509_INFO) cdecl = nil;
  f_sk_X509_INFO_push : function(sk: PSTACK_X509_INFO; v: PX509_INFO):Integer cdecl = nil;
  f_sk_X509_INFO_unshift : function(sk: PSTACK_X509_INFO; v: PX509_INFO):Integer cdecl = nil;
  f_sk_X509_INFO_find : function(sk: PSTACK_X509_INFO; v: PX509_INFO):Integer cdecl = nil;
  f_sk_X509_INFO_delete : function(sk: PSTACK_X509_INFO; n: Integer):PX509_INFO cdecl = nil;
  f_sk_X509_INFO_delete_ptr : procedure(sk: PSTACK_X509_INFO; v: PX509_INFO) cdecl = nil;
  f_sk_X509_INFO_insert : function(sk: PSTACK_X509_INFO; v: PX509_INFO; n: Integer):Integer cdecl = nil;
  f_sk_X509_INFO_dup : function(sk: PSTACK_X509_INFO):PSTACK_X509_INFO cdecl = nil;
  f_sk_X509_INFO_pop_free : procedure(sk: PSTACK_X509_INFO; arg1: PFunction) cdecl = nil;
  f_sk_X509_INFO_shift : function(sk: PSTACK_X509_INFO):PX509_INFO cdecl = nil;
  f_sk_X509_INFO_pop : function(sk: PSTACK_X509_INFO):PX509_INFO cdecl = nil;
  f_sk_X509_INFO_sort : procedure(sk: PSTACK_X509_INFO) cdecl = nil;
  f_sk_X509_LOOKUP_new : function(arg0: PFunction):PSTACK_X509_LOOKUP cdecl = nil;
  f_sk_X509_LOOKUP_new_null : function:PSTACK_X509_LOOKUP cdecl = nil;
  f_sk_X509_LOOKUP_free : procedure(sk: PSTACK_X509_LOOKUP) cdecl = nil;
  f_sk_X509_LOOKUP_num : function(const sk: PSTACK_X509_LOOKUP):Integer cdecl = nil;
  f_sk_X509_LOOKUP_value : function(const sk: PSTACK_X509_LOOKUP; n: Integer):PX509_LOOKUP cdecl = nil;
  f_sk_X509_LOOKUP_set : function(sk: PSTACK_X509_LOOKUP; n: Integer; v: PX509_LOOKUP):PX509_LOOKUP cdecl = nil;
  f_sk_X509_LOOKUP_zero : procedure(sk: PSTACK_X509_LOOKUP) cdecl = nil;
  f_sk_X509_LOOKUP_push : function(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP):Integer cdecl = nil;
  f_sk_X509_LOOKUP_unshift : function(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP):Integer cdecl = nil;
  f_sk_X509_LOOKUP_find : function(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP):Integer cdecl = nil;
  f_sk_X509_LOOKUP_delete : function(sk: PSTACK_X509_LOOKUP; n: Integer):PX509_LOOKUP cdecl = nil;
  f_sk_X509_LOOKUP_delete_ptr : procedure(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP) cdecl = nil;
  f_sk_X509_LOOKUP_insert : function(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP; n: Integer):Integer cdecl = nil;
  f_sk_X509_LOOKUP_dup : function(sk: PSTACK_X509_LOOKUP):PSTACK_X509_LOOKUP cdecl = nil;
  f_sk_X509_LOOKUP_pop_free : procedure(sk: PSTACK_X509_LOOKUP; arg1: PFunction) cdecl = nil;
  f_sk_X509_LOOKUP_shift : function(sk: PSTACK_X509_LOOKUP):PX509_LOOKUP cdecl = nil;
  f_sk_X509_LOOKUP_pop : function(sk: PSTACK_X509_LOOKUP):PX509_LOOKUP cdecl = nil;
  f_sk_X509_LOOKUP_sort : procedure(sk: PSTACK_X509_LOOKUP) cdecl = nil;
  f_X509_OBJECT_retrieve_by_subject : function(h: PLHASH; _type: Integer; name: PX509_NAME):PX509_OBJECT cdecl = nil;
  f_X509_OBJECT_up_ref_count : procedure(a: PX509_OBJECT) cdecl = nil;
  f_X509_OBJECT_free_contents : procedure(a: PX509_OBJECT) cdecl = nil;
  f_X509_STORE_new : function:PX509_STORE cdecl = nil;
  f_X509_STORE_free : procedure(v: PX509_STORE) cdecl = nil;
  f_X509_STORE_CTX_init : procedure(ctx: PX509_STORE_CTX; store: PX509_STORE; x509: PX509; chain: PSTACK_X509) cdecl = nil;
  f_X509_STORE_CTX_cleanup : procedure(ctx: PX509_STORE_CTX) cdecl = nil;
  f_X509_STORE_add_lookup : function(v: PX509_STORE; m: PX509_LOOKUP_METHOD):PX509_LOOKUP cdecl = nil;
  f_X509_LOOKUP_hash_dir : function:PX509_LOOKUP_METHOD cdecl = nil;
  f_X509_LOOKUP_file : function:PX509_LOOKUP_METHOD cdecl = nil;
  f_X509_STORE_add_cert : function(ctx: PX509_STORE; x: PX509):Integer cdecl = nil;
  f_X509_STORE_add_crl : function(ctx: PX509_STORE; x: PX509_CRL):Integer cdecl = nil;
  f_X509_STORE_get_by_subject : function(vs: PX509_STORE_CTX; _type: Integer; name: PX509_NAME; ret: PX509_OBJECT):Integer cdecl = nil;
  f_X509_LOOKUP_ctrl : function(ctx: PX509_LOOKUP; cmd: Integer; const argc: PChar; argl: Longint; ret: PPChar):Integer cdecl = nil;
  f_X509_load_cert_file : function(ctx: PX509_LOOKUP; const _file: PChar; _type: Integer):Integer cdecl = nil;
  f_X509_load_crl_file : function(ctx: PX509_LOOKUP; const _file: PChar; _type: Integer):Integer cdecl = nil;
  f_X509_LOOKUP_new : function(method: PX509_LOOKUP_METHOD):PX509_LOOKUP cdecl = nil;
  f_X509_LOOKUP_free : procedure(ctx: PX509_LOOKUP) cdecl = nil;
  f_X509_LOOKUP_init : function(ctx: PX509_LOOKUP):Integer cdecl = nil;
  f_X509_LOOKUP_by_subject : function(ctx: PX509_LOOKUP; _type: Integer; name: PX509_NAME; ret: PX509_OBJECT):Integer cdecl = nil;
  f_X509_LOOKUP_by_issuer_serial : function(ctx: PX509_LOOKUP; _type: Integer; name: PX509_NAME; serial: PASN1_STRING; ret: PX509_OBJECT):Integer cdecl = nil;
  f_X509_LOOKUP_by_fingerprint : function(ctx: PX509_LOOKUP; _type: Integer; bytes: PChar; len: Integer; ret: PX509_OBJECT):Integer cdecl = nil;
  f_X509_LOOKUP_by_alias : function(ctx: PX509_LOOKUP; _type: Integer; str: PChar; len: Integer; ret: PX509_OBJECT):Integer cdecl = nil;
  f_X509_LOOKUP_shutdown : function(ctx: PX509_LOOKUP):Integer cdecl = nil;
  f_X509_STORE_load_locations : function(ctx: PX509_STORE; const _file: PChar; const dir: PChar):Integer cdecl = nil;
  f_X509_STORE_set_default_paths : function(ctx: PX509_STORE):Integer cdecl = nil;
  f_X509_STORE_CTX_get_ex_new_index : function(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer cdecl = nil;
  f_X509_STORE_CTX_set_ex_data : function(ctx: PX509_STORE_CTX; idx: Integer; data: Pointer):Integer cdecl = nil;
  f_X509_STORE_CTX_get_ex_data : function(ctx: PX509_STORE_CTX; idx: Integer):Pointer cdecl = nil;
  f_X509_STORE_CTX_get_error : function(ctx: PX509_STORE_CTX):Integer cdecl = nil;
  f_X509_STORE_CTX_set_error : procedure(ctx: PX509_STORE_CTX; s: Integer) cdecl = nil;
  f_X509_STORE_CTX_get_error_depth : function(ctx: PX509_STORE_CTX):Integer cdecl = nil;
  f_X509_STORE_CTX_get_current_cert : function(ctx: PX509_STORE_CTX):PX509 cdecl = nil;
  f_X509_STORE_CTX_get_chain : function(ctx: PX509_STORE_CTX):PSTACK_X509 cdecl = nil;
  f_X509_STORE_CTX_set_cert : procedure(c: PX509_STORE_CTX; x: PX509) cdecl = nil;
  f_X509_STORE_CTX_set_chain : procedure(c: PX509_STORE_CTX; sk: PSTACK_X509) cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_new : function(arg0: PFunction):PSTACK_PKCS7_SIGNER_INFO cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_new_null : function:PSTACK_PKCS7_SIGNER_INFO cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_free : procedure(sk: PSTACK_PKCS7_SIGNER_INFO) cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_num : function(const sk: PSTACK_PKCS7_SIGNER_INFO):Integer cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_value : function(const sk: PSTACK_PKCS7_SIGNER_INFO; n: Integer):PPKCS7_SIGNER_INFO cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_set : function(sk: PSTACK_PKCS7_SIGNER_INFO; n: Integer; v: PPKCS7_SIGNER_INFO):PPKCS7_SIGNER_INFO cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_zero : procedure(sk: PSTACK_PKCS7_SIGNER_INFO) cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_push : function(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO):Integer cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_unshift : function(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO):Integer cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_find : function(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO):Integer cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_delete : function(sk: PSTACK_PKCS7_SIGNER_INFO; n: Integer):PPKCS7_SIGNER_INFO cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_delete_ptr : procedure(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO) cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_insert : function(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO; n: Integer):Integer cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_dup : function(sk: PSTACK_PKCS7_SIGNER_INFO):PSTACK_PKCS7_SIGNER_INFO cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_pop_free : procedure(sk: PSTACK_PKCS7_SIGNER_INFO; arg1: PFunction) cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_shift : function(sk: PSTACK_PKCS7_SIGNER_INFO):PPKCS7_SIGNER_INFO cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_pop : function(sk: PSTACK_PKCS7_SIGNER_INFO):PPKCS7_SIGNER_INFO cdecl = nil;
  f_sk_PKCS7_SIGNER_INFO_sort : procedure(sk: PSTACK_PKCS7_SIGNER_INFO) cdecl = nil;
  f_i2d_ASN1_SET_OF_PKCS7_SIGNER_INFO : function(a: PSTACK_PKCS7_SIGNER_INFO; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET_OF_PKCS7_SIGNER_INFO : function(a: PPSTACK_PKCS7_SIGNER_INFO; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_PKCS7_SIGNER_INFO cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_new : function(arg0: PFunction):PSTACK_PKCS7_RECIP_INFO cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_new_null : function:PSTACK_PKCS7_RECIP_INFO cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_free : procedure(sk: PSTACK_PKCS7_RECIP_INFO) cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_num : function(const sk: PSTACK_PKCS7_RECIP_INFO):Integer cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_value : function(const sk: PSTACK_PKCS7_RECIP_INFO; n: Integer):PPKCS7_RECIP_INFO cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_set : function(sk: PSTACK_PKCS7_RECIP_INFO; n: Integer; v: PPKCS7_RECIP_INFO):PPKCS7_RECIP_INFO cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_zero : procedure(sk: PSTACK_PKCS7_RECIP_INFO) cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_push : function(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO):Integer cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_unshift : function(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO):Integer cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_find : function(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO):Integer cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_delete : function(sk: PSTACK_PKCS7_RECIP_INFO; n: Integer):PPKCS7_RECIP_INFO cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_delete_ptr : procedure(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO) cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_insert : function(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO; n: Integer):Integer cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_dup : function(sk: PSTACK_PKCS7_RECIP_INFO):PSTACK_PKCS7_RECIP_INFO cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_pop_free : procedure(sk: PSTACK_PKCS7_RECIP_INFO; arg1: PFunction) cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_shift : function(sk: PSTACK_PKCS7_RECIP_INFO):PPKCS7_RECIP_INFO cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_pop : function(sk: PSTACK_PKCS7_RECIP_INFO):PPKCS7_RECIP_INFO cdecl = nil;
  f_sk_PKCS7_RECIP_INFO_sort : procedure(sk: PSTACK_PKCS7_RECIP_INFO) cdecl = nil;
  f_i2d_ASN1_SET_OF_PKCS7_RECIP_INFO : function(a: PSTACK_PKCS7_RECIP_INFO; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer cdecl = nil;
  f_d2i_ASN1_SET_OF_PKCS7_RECIP_INFO : function(a: PPSTACK_PKCS7_RECIP_INFO; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_PKCS7_RECIP_INFO cdecl = nil;
  f_PKCS7_ISSUER_AND_SERIAL_new : function:PPKCS7_ISSUER_AND_SERIAL cdecl = nil;
  f_PKCS7_ISSUER_AND_SERIAL_free : procedure(a: PPKCS7_ISSUER_AND_SERIAL) cdecl = nil;
  f_i2d_PKCS7_ISSUER_AND_SERIAL : function(a: PPKCS7_ISSUER_AND_SERIAL; pp: PPChar):Integer cdecl = nil;
  f_d2i_PKCS7_ISSUER_AND_SERIAL : function(a: PPPKCS7_ISSUER_AND_SERIAL; pp: PPChar; length: Longint):PPKCS7_ISSUER_AND_SERIAL cdecl = nil;
  f_PKCS7_ISSUER_AND_SERIAL_digest : function(data: PPKCS7_ISSUER_AND_SERIAL; _type: PEVP_MD; md: PChar; len: PUInteger):Integer cdecl = nil;
  f_d2i_PKCS7_fp : function(fp: PFILE; p7: PPPKCS7):PPKCS7 cdecl = nil;
  f_i2d_PKCS7_fp : function(fp: PFILE; p7: PPKCS7):Integer cdecl = nil;
  f_PKCS7_dup : function(p7: PPKCS7):PPKCS7 cdecl = nil;
  f_d2i_PKCS7_bio : function(bp: PBIO; p7: PPPKCS7):PPKCS7 cdecl = nil;
  f_i2d_PKCS7_bio : function(bp: PBIO; p7: PPKCS7):Integer cdecl = nil;
  f_PKCS7_SIGNER_INFO_new : function:PPKCS7_SIGNER_INFO cdecl = nil;
  f_PKCS7_SIGNER_INFO_free : procedure(a: PPKCS7_SIGNER_INFO) cdecl = nil;
  f_i2d_PKCS7_SIGNER_INFO : function(a: PPKCS7_SIGNER_INFO; pp: PPChar):Integer cdecl = nil;
  f_d2i_PKCS7_SIGNER_INFO : function(a: PPPKCS7_SIGNER_INFO; pp: PPChar; length: Longint):PPKCS7_SIGNER_INFO cdecl = nil;
  f_PKCS7_RECIP_INFO_new : function:PPKCS7_RECIP_INFO cdecl = nil;
  f_PKCS7_RECIP_INFO_free : procedure(a: PPKCS7_RECIP_INFO) cdecl = nil;
  f_i2d_PKCS7_RECIP_INFO : function(a: PPKCS7_RECIP_INFO; pp: PPChar):Integer cdecl = nil;
  f_d2i_PKCS7_RECIP_INFO : function(a: PPPKCS7_RECIP_INFO; pp: PPChar; length: Longint):PPKCS7_RECIP_INFO cdecl = nil;
  f_PKCS7_SIGNED_new : function:PPKCS7_SIGNED cdecl = nil;
  f_PKCS7_SIGNED_free : procedure(a: PPKCS7_SIGNED) cdecl = nil;
  f_i2d_PKCS7_SIGNED : function(a: PPKCS7_SIGNED; pp: PPChar):Integer cdecl = nil;
  f_d2i_PKCS7_SIGNED : function(a: PPPKCS7_SIGNED; pp: PPChar; length: Longint):PPKCS7_SIGNED cdecl = nil;
  f_PKCS7_ENC_CONTENT_new : function:PPKCS7_ENC_CONTENT cdecl = nil;
  f_PKCS7_ENC_CONTENT_free : procedure(a: PPKCS7_ENC_CONTENT) cdecl = nil;
  f_i2d_PKCS7_ENC_CONTENT : function(a: PPKCS7_ENC_CONTENT; pp: PPChar):Integer cdecl = nil;
  f_d2i_PKCS7_ENC_CONTENT : function(a: PPPKCS7_ENC_CONTENT; pp: PPChar; length: Longint):PPKCS7_ENC_CONTENT cdecl = nil;
  f_PKCS7_ENVELOPE_new : function:PPKCS7_ENVELOPE cdecl = nil;
  f_PKCS7_ENVELOPE_free : procedure(a: PPKCS7_ENVELOPE) cdecl = nil;
  f_i2d_PKCS7_ENVELOPE : function(a: PPKCS7_ENVELOPE; pp: PPChar):Integer cdecl = nil;
  f_d2i_PKCS7_ENVELOPE : function(a: PPPKCS7_ENVELOPE; pp: PPChar; length: Longint):PPKCS7_ENVELOPE cdecl = nil;
  f_PKCS7_SIGN_ENVELOPE_new : function:PPKCS7_SIGN_ENVELOPE cdecl = nil;
  f_PKCS7_SIGN_ENVELOPE_free : procedure(a: PPKCS7_SIGN_ENVELOPE) cdecl = nil;
  f_i2d_PKCS7_SIGN_ENVELOPE : function(a: PPKCS7_SIGN_ENVELOPE; pp: PPChar):Integer cdecl = nil;
  f_d2i_PKCS7_SIGN_ENVELOPE : function(a: PPPKCS7_SIGN_ENVELOPE; pp: PPChar; length: Longint):PPKCS7_SIGN_ENVELOPE cdecl = nil;
  f_PKCS7_DIGEST_new : function:PPKCS7_DIGEST cdecl = nil;
  f_PKCS7_DIGEST_free : procedure(a: PPKCS7_DIGEST) cdecl = nil;
  f_i2d_PKCS7_DIGEST : function(a: PPKCS7_DIGEST; pp: PPChar):Integer cdecl = nil;
  f_d2i_PKCS7_DIGEST : function(a: PPPKCS7_DIGEST; pp: PPChar; length: Longint):PPKCS7_DIGEST cdecl = nil;
  f_PKCS7_ENCRYPT_new : function:PPKCS7_ENCRYPT cdecl = nil;
  f_PKCS7_ENCRYPT_free : procedure(a: PPKCS7_ENCRYPT) cdecl = nil;
  f_i2d_PKCS7_ENCRYPT : function(a: PPKCS7_ENCRYPT; pp: PPChar):Integer cdecl = nil;
  f_d2i_PKCS7_ENCRYPT : function(a: PPPKCS7_ENCRYPT; pp: PPChar; length: Longint):PPKCS7_ENCRYPT cdecl = nil;
  f_PKCS7_new : function:PPKCS7 cdecl = nil;
  f_PKCS7_free : procedure(a: PPKCS7) cdecl = nil;
  f_PKCS7_content_free : procedure(a: PPKCS7) cdecl = nil;
  f_i2d_PKCS7 : function(a: PPKCS7; pp: PPChar):Integer cdecl = nil;
  f_d2i_PKCS7 : function(a: PPPKCS7; pp: PPChar; length: Longint):PPKCS7 cdecl = nil;
  f_ERR_load_PKCS7_strings : procedure cdecl = nil;
  f_PKCS7_ctrl : function(p7: PPKCS7; cmd: Integer; larg: Longint; parg: PChar):Longint cdecl = nil;
  f_PKCS7_set_type : function(p7: PPKCS7; _type: Integer):Integer cdecl = nil;
  f_PKCS7_set_content : function(p7: PPKCS7; p7_data: PPKCS7):Integer cdecl = nil;
  f_PKCS7_SIGNER_INFO_set : function(p7i: PPKCS7_SIGNER_INFO; x509: PX509; pkey: PEVP_PKEY; dgst: PEVP_MD):Integer cdecl = nil;
  f_PKCS7_add_signer : function(p7: PPKCS7; p7i: PPKCS7_SIGNER_INFO):Integer cdecl = nil;
  f_PKCS7_add_certificate : function(p7: PPKCS7; x509: PX509):Integer cdecl = nil;
  f_PKCS7_add_crl : function(p7: PPKCS7; x509: PX509_CRL):Integer cdecl = nil;
  f_PKCS7_content_new : function(p7: PPKCS7; nid: Integer):Integer cdecl = nil;
  f_PKCS7_dataVerify : function(cert_store: PX509_STORE; ctx: PX509_STORE_CTX; bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO):Integer cdecl = nil;
  f_PKCS7_signatureVerify : function(bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO; x509: PX509):Integer cdecl = nil;
  f_PKCS7_dataInit : function(p7: PPKCS7; bio: PBIO):PBIO cdecl = nil;
  f_PKCS7_dataFinal : function(p7: PPKCS7; bio: PBIO):Integer cdecl = nil;
  f_PKCS7_dataDecode : function(p7: PPKCS7; pkey: PEVP_PKEY; in_bio: PBIO; pcert: PX509):PBIO cdecl = nil;
  f_PKCS7_add_signature : function(p7: PPKCS7; x509: PX509; pkey: PEVP_PKEY; dgst: PEVP_MD):PPKCS7_SIGNER_INFO cdecl = nil;
  f_PKCS7_cert_from_signer_info : function(p7: PPKCS7; si: PPKCS7_SIGNER_INFO):PX509 cdecl = nil;
  f_PKCS7_get_signer_info : function(p7: PPKCS7):PSTACK_PKCS7_SIGNER_INFO cdecl = nil;
  f_PKCS7_add_recipient : function(p7: PPKCS7; x509: PX509):PPKCS7_RECIP_INFO cdecl = nil;
  f_PKCS7_add_recipient_info : function(p7: PPKCS7; ri: PPKCS7_RECIP_INFO):Integer cdecl = nil;
  f_PKCS7_RECIP_INFO_set : function(p7i: PPKCS7_RECIP_INFO; x509: PX509):Integer cdecl = nil;
  f_PKCS7_set_cipher : function(p7: PPKCS7; const cipher: PEVP_CIPHER):Integer cdecl = nil;
  f_PKCS7_get_issuer_and_serial : function(p7: PPKCS7; idx: Integer):PPKCS7_ISSUER_AND_SERIAL cdecl = nil;
  f_PKCS7_digest_from_attributes : function(sk: PSTACK_X509_ATTRIBUTE):PASN1_STRING cdecl = nil;
  f_PKCS7_add_signed_attribute : function(p7si: PPKCS7_SIGNER_INFO; nid: Integer; _type: Integer; data: Pointer):Integer cdecl = nil;
  f_PKCS7_add_attribute : function(p7si: PPKCS7_SIGNER_INFO; nid: Integer; atrtype: Integer; value: Pointer):Integer cdecl = nil;
  f_PKCS7_get_attribute : function(si: PPKCS7_SIGNER_INFO; nid: Integer):PASN1_TYPE cdecl = nil;
  f_PKCS7_get_signed_attribute : function(si: PPKCS7_SIGNER_INFO; nid: Integer):PASN1_TYPE cdecl = nil;
  f_PKCS7_set_signed_attributes : function(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_X509_ATTRIBUTE):Integer cdecl = nil;
  f_PKCS7_set_attributes : function(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_X509_ATTRIBUTE):Integer cdecl = nil;
  f_X509_verify_cert_error_string : function(n: Longint):PChar cdecl = nil;
  f_X509_verify : function(a: PX509; r: PEVP_PKEY):Integer cdecl = nil;
  f_X509_REQ_verify : function(a: PX509_REQ; r: PEVP_PKEY):Integer cdecl = nil;
  f_X509_CRL_verify : function(a: PX509_CRL; r: PEVP_PKEY):Integer cdecl = nil;
  f_NETSCAPE_SPKI_verify : function(a: PNETSCAPE_SPKI; r: PEVP_PKEY):Integer cdecl = nil;
  f_X509_sign : function(x: PX509; pkey: PEVP_PKEY; const md: PEVP_MD):Integer cdecl = nil;
  f_X509_REQ_sign : function(x: PX509_REQ; pkey: PEVP_PKEY; const md: PEVP_MD):Integer cdecl = nil;
  f_X509_CRL_sign : function(x: PX509_CRL; pkey: PEVP_PKEY; const md: PEVP_MD):Integer cdecl = nil;
  f_NETSCAPE_SPKI_sign : function(x: PNETSCAPE_SPKI; pkey: PEVP_PKEY; const md: PEVP_MD):Integer cdecl = nil;
  f_X509_digest : function(data: PX509; _type: PEVP_MD; md: PChar; len: PUInteger):Integer cdecl = nil;
  f_X509_NAME_digest : function(data: PX509_NAME; _type: PEVP_MD; md: PChar; len: PUInteger):Integer cdecl = nil;
  f_d2i_X509_fp : function(fp: PFILE; x509: PPX509):PX509 cdecl = nil;
  f_i2d_X509_fp : function(fp: PFILE; x509: PX509):Integer cdecl = nil;
  f_d2i_X509_CRL_fp : function(fp: PFILE; crl: PPX509_CRL):PX509_CRL cdecl = nil;
  f_i2d_X509_CRL_fp : function(fp: PFILE; crl: PX509_CRL):Integer cdecl = nil;
  f_d2i_X509_REQ_fp : function(fp: PFILE; req: PPX509_REQ):PX509_REQ cdecl = nil;
  f_i2d_X509_REQ_fp : function(fp: PFILE; req: PX509_REQ):Integer cdecl = nil;
  f_d2i_RSAPrivateKey_fp : function(fp: PFILE; rsa: PPRSA):PRSA cdecl = nil;
  f_i2d_RSAPrivateKey_fp : function(fp: PFILE; rsa: PRSA):Integer cdecl = nil;
  f_d2i_RSAPublicKey_fp : function(fp: PFILE; rsa: PPRSA):PRSA cdecl = nil;
  f_i2d_RSAPublicKey_fp : function(fp: PFILE; rsa: PRSA):Integer cdecl = nil;
  f_d2i_DSAPrivateKey_fp : function(fp: PFILE; dsa: PPDSA):PDSA cdecl = nil;
  f_i2d_DSAPrivateKey_fp : function(fp: PFILE; dsa: PDSA):Integer cdecl = nil;
  f_d2i_PKCS8_fp : function(fp: PFILE; p8: PPX509_SIG):PX509_SIG cdecl = nil;
  f_i2d_PKCS8_fp : function(fp: PFILE; p8: PX509_SIG):Integer cdecl = nil;
  f_d2i_PKCS8_PRIV_KEY_INFO_fp : function(fp: PFILE; p8inf: PPPKCS8_PRIV_KEY_INFO):PPKCS8_PRIV_KEY_INFO cdecl = nil;
  f_i2d_PKCS8_PRIV_KEY_INFO_fp : function(fp: PFILE; p8inf: PPKCS8_PRIV_KEY_INFO):Integer cdecl = nil;
  f_d2i_X509_bio : function(bp: PBIO; x509: PPX509):PX509 cdecl = nil;
  f_i2d_X509_bio : function(bp: PBIO; x509: PX509):Integer cdecl = nil;
  f_d2i_X509_CRL_bio : function(bp: PBIO; crl: PPX509_CRL):PX509_CRL cdecl = nil;
  f_i2d_X509_CRL_bio : function(bp: PBIO; crl: PX509_CRL):Integer cdecl = nil;
  f_d2i_X509_REQ_bio : function(bp: PBIO; req: PPX509_REQ):PX509_REQ cdecl = nil;
  f_i2d_X509_REQ_bio : function(bp: PBIO; req: PX509_REQ):Integer cdecl = nil;
  f_d2i_RSAPrivateKey_bio : function(bp: PBIO; rsa: PPRSA):PRSA cdecl = nil;
  f_i2d_RSAPrivateKey_bio : function(bp: PBIO; rsa: PRSA):Integer cdecl = nil;
  f_d2i_RSAPublicKey_bio : function(bp: PBIO; rsa: PPRSA):PRSA cdecl = nil;
  f_i2d_RSAPublicKey_bio : function(bp: PBIO; rsa: PRSA):Integer cdecl = nil;
  f_d2i_DSAPrivateKey_bio : function(bp: PBIO; dsa: PPDSA):PDSA cdecl = nil;
  f_i2d_DSAPrivateKey_bio : function(bp: PBIO; dsa: PDSA):Integer cdecl = nil;
  f_d2i_PKCS8_bio : function(bp: PBIO; p8: PPX509_SIG):PX509_SIG cdecl = nil;
  f_i2d_PKCS8_bio : function(bp: PBIO; p8: PX509_SIG):Integer cdecl = nil;
  f_d2i_PKCS8_PRIV_KEY_INFO_bio : function(bp: PBIO; p8inf: PPPKCS8_PRIV_KEY_INFO):PPKCS8_PRIV_KEY_INFO cdecl = nil;
  f_i2d_PKCS8_PRIV_KEY_INFO_bio : function(bp: PBIO; p8inf: PPKCS8_PRIV_KEY_INFO):Integer cdecl = nil;
  f_X509_dup : function(x509: PX509):PX509 cdecl = nil;
  f_X509_ATTRIBUTE_dup : function(xa: PX509_ATTRIBUTE):PX509_ATTRIBUTE cdecl = nil;
  f_X509_EXTENSION_dup : function(ex: PX509_EXTENSION):PX509_EXTENSION cdecl = nil;
  f_X509_CRL_dup : function(crl: PX509_CRL):PX509_CRL cdecl = nil;
  f_X509_REQ_dup : function(req: PX509_REQ):PX509_REQ cdecl = nil;
  f_X509_ALGOR_dup : function(xn: PX509_ALGOR):PX509_ALGOR cdecl = nil;
  f_X509_NAME_dup : function(xn: PX509_NAME):PX509_NAME cdecl = nil;
  f_X509_NAME_ENTRY_dup : function(ne: PX509_NAME_ENTRY):PX509_NAME_ENTRY cdecl = nil;
  f_RSAPublicKey_dup : function(rsa: PRSA):PRSA cdecl = nil;
  f_RSAPrivateKey_dup : function(rsa: PRSA):PRSA cdecl = nil;
  f_X509_cmp_current_time : function(s: PASN1_STRING):Integer cdecl = nil;
  f_X509_gmtime_adj : function(s: PASN1_STRING; adj: Longint):PASN1_STRING cdecl = nil;
  f_X509_get_default_cert_area : function:PChar cdecl = nil;
  f_X509_get_default_cert_dir : function:PChar cdecl = nil;
  f_X509_get_default_cert_file : function:PChar cdecl = nil;
  f_X509_get_default_cert_dir_env : function:PChar cdecl = nil;
  f_X509_get_default_cert_file_env : function:PChar cdecl = nil;
  f_X509_get_default_private_dir : function:PChar cdecl = nil;
  f_X509_to_X509_REQ : function(x: PX509; pkey: PEVP_PKEY; md: PEVP_MD):PX509_REQ cdecl = nil;
  f_X509_REQ_to_X509 : function(r: PX509_REQ; days: Integer; pkey: PEVP_PKEY):PX509 cdecl = nil;
  f_ERR_load_X509_strings : procedure cdecl = nil;
  f_X509_ALGOR_new : function:PX509_ALGOR cdecl = nil;
  f_X509_ALGOR_free : procedure(a: PX509_ALGOR) cdecl = nil;
  f_i2d_X509_ALGOR : function(a: PX509_ALGOR; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_ALGOR : function(a: PPX509_ALGOR; pp: PPChar; length: Longint):PX509_ALGOR cdecl = nil;
  f_X509_VAL_new : function:PX509_VAL cdecl = nil;
  f_X509_VAL_free : procedure(a: PX509_VAL) cdecl = nil;
  f_i2d_X509_VAL : function(a: PX509_VAL; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_VAL : function(a: PPX509_VAL; pp: PPChar; length: Longint):PX509_VAL cdecl = nil;
  f_X509_PUBKEY_new : function:PX509_PUBKEY cdecl = nil;
  f_X509_PUBKEY_free : procedure(a: PX509_PUBKEY) cdecl = nil;
  f_i2d_X509_PUBKEY : function(a: PX509_PUBKEY; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_PUBKEY : function(a: PPX509_PUBKEY; pp: PPChar; length: Longint):PX509_PUBKEY cdecl = nil;
  f_X509_PUBKEY_set : function(x: PPX509_PUBKEY; pkey: PEVP_PKEY):Integer cdecl = nil;
  f_X509_PUBKEY_get : function(key: PX509_PUBKEY):PEVP_PKEY cdecl = nil;
  f_X509_get_pubkey_parameters : function(pkey: PEVP_PKEY; chain: PSTACK_X509):Integer cdecl = nil;
  f_X509_SIG_new : function:PX509_SIG cdecl = nil;
  f_X509_SIG_free : procedure(a: PX509_SIG) cdecl = nil;
  f_i2d_X509_SIG : function(a: PX509_SIG; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_SIG : function(a: PPX509_SIG; pp: PPChar; length: Longint):PX509_SIG cdecl = nil;
  f_X509_REQ_INFO_new : function:PX509_REQ_INFO cdecl = nil;
  f_X509_REQ_INFO_free : procedure(a: PX509_REQ_INFO) cdecl = nil;
  f_i2d_X509_REQ_INFO : function(a: PX509_REQ_INFO; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_REQ_INFO : function(a: PPX509_REQ_INFO; pp: PPChar; length: Longint):PX509_REQ_INFO cdecl = nil;
  f_X509_REQ_new : function:PX509_REQ cdecl = nil;
  f_X509_REQ_free : procedure(a: PX509_REQ) cdecl = nil;
  f_i2d_X509_REQ : function(a: PX509_REQ; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_REQ : function(a: PPX509_REQ; pp: PPChar; length: Longint):PX509_REQ cdecl = nil;
  f_X509_ATTRIBUTE_new : function:PX509_ATTRIBUTE cdecl = nil;
  f_X509_ATTRIBUTE_free : procedure(a: PX509_ATTRIBUTE) cdecl = nil;
  f_i2d_X509_ATTRIBUTE : function(a: PX509_ATTRIBUTE; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_ATTRIBUTE : function(a: PPX509_ATTRIBUTE; pp: PPChar; length: Longint):PX509_ATTRIBUTE cdecl = nil;
  f_X509_ATTRIBUTE_create : function(nid: Integer; atrtype: Integer; value: Pointer):PX509_ATTRIBUTE cdecl = nil;
  f_X509_EXTENSION_new : function:PX509_EXTENSION cdecl = nil;
  f_X509_EXTENSION_free : procedure(a: PX509_EXTENSION) cdecl = nil;
  f_i2d_X509_EXTENSION : function(a: PX509_EXTENSION; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_EXTENSION : function(a: PPX509_EXTENSION; pp: PPChar; length: Longint):PX509_EXTENSION cdecl = nil;
  f_X509_NAME_ENTRY_new : function:PX509_NAME_ENTRY cdecl = nil;
  f_X509_NAME_ENTRY_free : procedure(a: PX509_NAME_ENTRY) cdecl = nil;
  f_i2d_X509_NAME_ENTRY : function(a: PX509_NAME_ENTRY; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_NAME_ENTRY : function(a: PPX509_NAME_ENTRY; pp: PPChar; length: Longint):PX509_NAME_ENTRY cdecl = nil;
  f_X509_NAME_new : function:PX509_NAME cdecl = nil;
  f_X509_NAME_free : procedure(a: PX509_NAME) cdecl = nil;
  f_i2d_X509_NAME : function(a: PX509_NAME; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_NAME : function(a: PPX509_NAME; pp: PPChar; length: Longint):PX509_NAME cdecl = nil;
  f_X509_NAME_set : function(xn: PPX509_NAME; name: PX509_NAME):Integer cdecl = nil;
  f_X509_CINF_new : function:PX509_CINF cdecl = nil;
  f_X509_CINF_free : procedure(a: PX509_CINF) cdecl = nil;
  f_i2d_X509_CINF : function(a: PX509_CINF; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_CINF : function(a: PPX509_CINF; pp: PPChar; length: Longint):PX509_CINF cdecl = nil;
  f_X509_new : function:PX509 cdecl = nil;
  f_X509_free : procedure(a: PX509) cdecl = nil;
  f_i2d_X509 : function(a: PX509; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509 : function(a: PPX509; pp: PPChar; length: Longint):PX509 cdecl = nil;
  f_X509_REVOKED_new : function:PX509_REVOKED cdecl = nil;
  f_X509_REVOKED_free : procedure(a: PX509_REVOKED) cdecl = nil;
  f_i2d_X509_REVOKED : function(a: PX509_REVOKED; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_REVOKED : function(a: PPX509_REVOKED; pp: PPChar; length: Longint):PX509_REVOKED cdecl = nil;
  f_X509_CRL_INFO_new : function:PX509_CRL_INFO cdecl = nil;
  f_X509_CRL_INFO_free : procedure(a: PX509_CRL_INFO) cdecl = nil;
  f_i2d_X509_CRL_INFO : function(a: PX509_CRL_INFO; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_CRL_INFO : function(a: PPX509_CRL_INFO; pp: PPChar; length: Longint):PX509_CRL_INFO cdecl = nil;
  f_X509_CRL_new : function:PX509_CRL cdecl = nil;
  f_X509_CRL_free : procedure(a: PX509_CRL) cdecl = nil;
  f_i2d_X509_CRL : function(a: PX509_CRL; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_CRL : function(a: PPX509_CRL; pp: PPChar; length: Longint):PX509_CRL cdecl = nil;
  f_X509_PKEY_new : function:PX509_PKEY cdecl = nil;
  f_X509_PKEY_free : procedure(a: PX509_PKEY) cdecl = nil;
  f_i2d_X509_PKEY : function(a: PX509_PKEY; pp: PPChar):Integer cdecl = nil;
  f_d2i_X509_PKEY : function(a: PPX509_PKEY; pp: PPChar; length: Longint):PX509_PKEY cdecl = nil;
  f_NETSCAPE_SPKI_new : function:PNETSCAPE_SPKI cdecl = nil;
  f_NETSCAPE_SPKI_free : procedure(a: PNETSCAPE_SPKI) cdecl = nil;
  f_i2d_NETSCAPE_SPKI : function(a: PNETSCAPE_SPKI; pp: PPChar):Integer cdecl = nil;
  f_d2i_NETSCAPE_SPKI : function(a: PPNETSCAPE_SPKI; pp: PPChar; length: Longint):PNETSCAPE_SPKI cdecl = nil;
  f_NETSCAPE_SPKAC_new : function:PNETSCAPE_SPKAC cdecl = nil;
  f_NETSCAPE_SPKAC_free : procedure(a: PNETSCAPE_SPKAC) cdecl = nil;
  f_i2d_NETSCAPE_SPKAC : function(a: PNETSCAPE_SPKAC; pp: PPChar):Integer cdecl = nil;
  f_d2i_NETSCAPE_SPKAC : function(a: PPNETSCAPE_SPKAC; pp: PPChar; length: Longint):PNETSCAPE_SPKAC cdecl = nil;
  f_i2d_NETSCAPE_CERT_SEQUENCE : function(a: PNETSCAPE_CERT_SEQUENCE; pp: PPChar):Integer cdecl = nil;
  f_NETSCAPE_CERT_SEQUENCE_new : function:PNETSCAPE_CERT_SEQUENCE cdecl = nil;
  f_d2i_NETSCAPE_CERT_SEQUENCE : function(a: PPNETSCAPE_CERT_SEQUENCE; pp: PPChar; length: Longint):PNETSCAPE_CERT_SEQUENCE cdecl = nil;
  f_NETSCAPE_CERT_SEQUENCE_free : procedure(a: PNETSCAPE_CERT_SEQUENCE) cdecl = nil;
  f_X509_INFO_new : function:PX509_INFO cdecl = nil;
  f_X509_INFO_free : procedure(a: PX509_INFO) cdecl = nil;
  f_X509_NAME_oneline : function(a: PX509_NAME; buf: PChar; size: Integer):PChar cdecl = nil;
  f_ASN1_verify : function(arg0: PFunction; algor1: PX509_ALGOR; signature: PASN1_STRING; data: PChar; pkey: PEVP_PKEY):Integer cdecl = nil;
  f_ASN1_digest : function(arg0: PFunction; _type: PEVP_MD; data: PChar; md: PChar; len: PUInteger):Integer cdecl = nil;
  f_ASN1_sign : function(arg0: PFunction; algor1: PX509_ALGOR; algor2: PX509_ALGOR; signature: PASN1_STRING; data: PChar; pkey: PEVP_PKEY; const _type: PEVP_MD):Integer cdecl = nil;
  f_X509_set_version : function(x: PX509; version: Longint):Integer cdecl = nil;
  f_X509_set_serialNumber : function(x: PX509; serial: PASN1_STRING):Integer cdecl = nil;
  f_X509_get_serialNumber : function(x: PX509):PASN1_STRING cdecl = nil;
  f_X509_set_issuer_name : function(x: PX509; name: PX509_NAME):Integer cdecl = nil;
  f_X509_get_issuer_name : function(a: PX509):PX509_NAME cdecl = nil;
  f_X509_set_subject_name : function(x: PX509; name: PX509_NAME):Integer cdecl = nil;
  f_X509_get_subject_name : function(a: PX509):PX509_NAME cdecl = nil;
  f_X509_set_notBefore : function(x: PX509; tm: PASN1_STRING):Integer cdecl = nil;
  f_X509_set_notAfter : function(x: PX509; tm: PASN1_STRING):Integer cdecl = nil;
  f_X509_set_pubkey : function(x: PX509; pkey: PEVP_PKEY):Integer cdecl = nil;
  f_X509_get_pubkey : function(x: PX509):PEVP_PKEY cdecl = nil;
  f_X509_certificate_type : function(x: PX509; pubkey: PEVP_PKEY):Integer cdecl = nil;
  f_X509_REQ_set_version : function(x: PX509_REQ; version: Longint):Integer cdecl = nil;
  f_X509_REQ_set_subject_name : function(req: PX509_REQ; name: PX509_NAME):Integer cdecl = nil;
  f_X509_REQ_set_pubkey : function(x: PX509_REQ; pkey: PEVP_PKEY):Integer cdecl = nil;
  f_X509_REQ_get_pubkey : function(req: PX509_REQ):PEVP_PKEY cdecl = nil;
  f_X509_check_private_key : function(x509: PX509; pkey: PEVP_PKEY):Integer cdecl = nil;
  f_X509_issuer_and_serial_cmp : function(a: PX509; b: PX509):Integer cdecl = nil;
  f_X509_issuer_and_serial_hash : function(a: PX509):Cardinal cdecl = nil;
  f_X509_issuer_name_cmp : function(a: PX509; b: PX509):Integer cdecl = nil;
  f_X509_issuer_name_hash : function(a: PX509):Cardinal cdecl = nil;
  f_X509_subject_name_cmp : function(a: PX509; b: PX509):Integer cdecl = nil;
  f_X509_subject_name_hash : function(x: PX509):Cardinal cdecl = nil;
  f_X509_NAME_cmp : function(a: PX509_NAME; b: PX509_NAME):Integer cdecl = nil;
  f_X509_NAME_hash : function(x: PX509_NAME):Cardinal cdecl = nil;
  f_X509_CRL_cmp : function(a: PX509_CRL; b: PX509_CRL):Integer cdecl = nil;
  f_X509_print_fp : function(bp: PFILE; x: PX509):Integer cdecl = nil;
  f_X509_CRL_print_fp : function(bp: PFILE; x: PX509_CRL):Integer cdecl = nil;
  f_X509_REQ_print_fp : function(bp: PFILE; req: PX509_REQ):Integer cdecl = nil;
  f_X509_NAME_print : function(bp: PBIO; name: PX509_NAME; obase: Integer):Integer cdecl = nil;
  f_X509_print : function(bp: PBIO; x: PX509):Integer cdecl = nil;
  f_X509_CRL_print : function(bp: PBIO; x: PX509_CRL):Integer cdecl = nil;
  f_X509_REQ_print : function(bp: PBIO; req: PX509_REQ):Integer cdecl = nil;
  f_X509_NAME_entry_count : function(name: PX509_NAME):Integer cdecl = nil;
  f_X509_NAME_get_text_by_NID : function(name: PX509_NAME; nid: Integer; buf: PChar; len: Integer):Integer cdecl = nil;
  f_X509_NAME_get_text_by_OBJ : function(name: PX509_NAME; obj: PASN1_OBJECT; buf: PChar; len: Integer):Integer cdecl = nil;
  f_X509_NAME_get_index_by_NID : function(name: PX509_NAME; nid: Integer; lastpos: Integer):Integer cdecl = nil;
  f_X509_NAME_get_index_by_OBJ : function(name: PX509_NAME; obj: PASN1_OBJECT; lastpos: Integer):Integer cdecl = nil;
  f_X509_NAME_get_entry : function(name: PX509_NAME; loc: Integer):PX509_NAME_ENTRY cdecl = nil;
  f_X509_NAME_delete_entry : function(name: PX509_NAME; loc: Integer):PX509_NAME_ENTRY cdecl = nil;
  f_X509_NAME_add_entry : function(name: PX509_NAME; ne: PX509_NAME_ENTRY; loc: Integer; _set: Integer):Integer cdecl = nil;
  f_X509_NAME_ENTRY_create_by_NID : function(ne: PPX509_NAME_ENTRY; nid: Integer; _type: Integer; bytes: PChar; len: Integer):PX509_NAME_ENTRY cdecl = nil;
  f_X509_NAME_ENTRY_create_by_OBJ : function(ne: PPX509_NAME_ENTRY; obj: PASN1_OBJECT; _type: Integer; bytes: PChar; len: Integer):PX509_NAME_ENTRY cdecl = nil;
  f_X509_NAME_ENTRY_set_object : function(ne: PX509_NAME_ENTRY; obj: PASN1_OBJECT):Integer cdecl = nil;
  f_X509_NAME_ENTRY_set_data : function(ne: PX509_NAME_ENTRY; _type: Integer; bytes: PChar; len: Integer):Integer cdecl = nil;
  f_X509_NAME_ENTRY_get_object : function(ne: PX509_NAME_ENTRY):PASN1_OBJECT cdecl = nil;
  f_X509_NAME_ENTRY_get_data : function(ne: PX509_NAME_ENTRY):PASN1_STRING cdecl = nil;
  f_X509v3_get_ext_count : function(const x: PSTACK_X509_EXTENSION):Integer cdecl = nil;
  f_X509v3_get_ext_by_NID : function(const x: PSTACK_X509_EXTENSION; nid: Integer; lastpos: Integer):Integer cdecl = nil;
  f_X509v3_get_ext_by_OBJ : function(const x: PSTACK_X509_EXTENSION; obj: PASN1_OBJECT; lastpos: Integer):Integer cdecl = nil;
  f_X509v3_get_ext_by_critical : function(const x: PSTACK_X509_EXTENSION; crit: Integer; lastpos: Integer):Integer cdecl = nil;
  f_X509v3_get_ext : function(const x: PSTACK_X509_EXTENSION; loc: Integer):PX509_EXTENSION cdecl = nil;
  f_X509v3_delete_ext : function(x: PSTACK_X509_EXTENSION; loc: Integer):PX509_EXTENSION cdecl = nil;
  f_X509v3_add_ext : function(x: PPSTACK_X509_EXTENSION; ex: PX509_EXTENSION; loc: Integer):PSTACK_X509_EXTENSION cdecl = nil;
  f_X509_get_ext_count : function(x: PX509):Integer cdecl = nil;
  f_X509_get_ext_by_NID : function(x: PX509; nid: Integer; lastpos: Integer):Integer cdecl = nil;
  f_X509_get_ext_by_OBJ : function(x: PX509; obj: PASN1_OBJECT; lastpos: Integer):Integer cdecl = nil;
  f_X509_get_ext_by_critical : function(x: PX509; crit: Integer; lastpos: Integer):Integer cdecl = nil;
  f_X509_get_ext : function(x: PX509; loc: Integer):PX509_EXTENSION cdecl = nil;
  f_X509_delete_ext : function(x: PX509; loc: Integer):PX509_EXTENSION cdecl = nil;
  f_X509_add_ext : function(x: PX509; ex: PX509_EXTENSION; loc: Integer):Integer cdecl = nil;
  f_X509_CRL_get_ext_count : function(x: PX509_CRL):Integer cdecl = nil;
  f_X509_CRL_get_ext_by_NID : function(x: PX509_CRL; nid: Integer; lastpos: Integer):Integer cdecl = nil;
  f_X509_CRL_get_ext_by_OBJ : function(x: PX509_CRL; obj: PASN1_OBJECT; lastpos: Integer):Integer cdecl = nil;
  f_X509_CRL_get_ext_by_critical : function(x: PX509_CRL; crit: Integer; lastpos: Integer):Integer cdecl = nil;
  f_X509_CRL_get_ext : function(x: PX509_CRL; loc: Integer):PX509_EXTENSION cdecl = nil;
  f_X509_CRL_delete_ext : function(x: PX509_CRL; loc: Integer):PX509_EXTENSION cdecl = nil;
  f_X509_CRL_add_ext : function(x: PX509_CRL; ex: PX509_EXTENSION; loc: Integer):Integer cdecl = nil;
  f_X509_REVOKED_get_ext_count : function(x: PX509_REVOKED):Integer cdecl = nil;
  f_X509_REVOKED_get_ext_by_NID : function(x: PX509_REVOKED; nid: Integer; lastpos: Integer):Integer cdecl = nil;
  f_X509_REVOKED_get_ext_by_OBJ : function(x: PX509_REVOKED; obj: PASN1_OBJECT; lastpos: Integer):Integer cdecl = nil;
  f_X509_REVOKED_get_ext_by_critical : function(x: PX509_REVOKED; crit: Integer; lastpos: Integer):Integer cdecl = nil;
  f_X509_REVOKED_get_ext : function(x: PX509_REVOKED; loc: Integer):PX509_EXTENSION cdecl = nil;
  f_X509_REVOKED_delete_ext : function(x: PX509_REVOKED; loc: Integer):PX509_EXTENSION cdecl = nil;
  f_X509_REVOKED_add_ext : function(x: PX509_REVOKED; ex: PX509_EXTENSION; loc: Integer):Integer cdecl = nil;
  f_X509_EXTENSION_create_by_NID : function(ex: PPX509_EXTENSION; nid: Integer; crit: Integer; data: PASN1_STRING):PX509_EXTENSION cdecl = nil;
  f_X509_EXTENSION_create_by_OBJ : function(ex: PPX509_EXTENSION; obj: PASN1_OBJECT; crit: Integer; data: PASN1_STRING):PX509_EXTENSION cdecl = nil;
  f_X509_EXTENSION_set_object : function(ex: PX509_EXTENSION; obj: PASN1_OBJECT):Integer cdecl = nil;
  f_X509_EXTENSION_set_critical : function(ex: PX509_EXTENSION; crit: Integer):Integer cdecl = nil;
  f_X509_EXTENSION_set_data : function(ex: PX509_EXTENSION; data: PASN1_STRING):Integer cdecl = nil;
  f_X509_EXTENSION_get_object : function(ex: PX509_EXTENSION):PASN1_OBJECT cdecl = nil;
  f_X509_EXTENSION_get_data : function(ne: PX509_EXTENSION):PASN1_STRING cdecl = nil;
  f_X509_EXTENSION_get_critical : function(ex: PX509_EXTENSION):Integer cdecl = nil;
  f_X509_verify_cert : function(ctx: PX509_STORE_CTX):Integer cdecl = nil;
  f_X509_find_by_issuer_and_serial : function(sk: PSTACK_X509; name: PX509_NAME; serial: PASN1_STRING):PX509 cdecl = nil;
  f_X509_find_by_subject : function(sk: PSTACK_X509; name: PX509_NAME):PX509 cdecl = nil;
  f_i2d_PBEPARAM : function(a: PPBEPARAM; pp: PPChar):Integer cdecl = nil;
  f_PBEPARAM_new : function:PPBEPARAM cdecl = nil;
  f_d2i_PBEPARAM : function(a: PPPBEPARAM; pp: PPChar; length: Longint):PPBEPARAM cdecl = nil;
  f_PBEPARAM_free : procedure(a: PPBEPARAM) cdecl = nil;
  f_PKCS5_pbe_set : function(alg: Integer; iter: Integer; salt: PChar; saltlen: Integer):PX509_ALGOR cdecl = nil;
  f_PKCS5_pbe2_set : function(const cipher: PEVP_CIPHER; iter: Integer; salt: PChar; saltlen: Integer):PX509_ALGOR cdecl = nil;
  f_i2d_PBKDF2PARAM : function(a: PPBKDF2PARAM; pp: PPChar):Integer cdecl = nil;
  f_PBKDF2PARAM_new : function:PPBKDF2PARAM cdecl = nil;
  f_d2i_PBKDF2PARAM : function(a: PPPBKDF2PARAM; pp: PPChar; length: Longint):PPBKDF2PARAM cdecl = nil;
  f_PBKDF2PARAM_free : procedure(a: PPBKDF2PARAM) cdecl = nil;
  f_i2d_PBE2PARAM : function(a: PPBE2PARAM; pp: PPChar):Integer cdecl = nil;
  f_PBE2PARAM_new : function:PPBE2PARAM cdecl = nil;
  f_d2i_PBE2PARAM : function(a: PPPBE2PARAM; pp: PPChar; length: Longint):PPBE2PARAM cdecl = nil;
  f_PBE2PARAM_free : procedure(a: PPBE2PARAM) cdecl = nil;
  f_i2d_PKCS8_PRIV_KEY_INFO : function(a: PPKCS8_PRIV_KEY_INFO; pp: PPChar):Integer cdecl = nil;
  f_PKCS8_PRIV_KEY_INFO_new : function:PPKCS8_PRIV_KEY_INFO cdecl = nil;
  f_d2i_PKCS8_PRIV_KEY_INFO : function(a: PPPKCS8_PRIV_KEY_INFO; pp: PPChar; length: Longint):PPKCS8_PRIV_KEY_INFO cdecl = nil;
  f_PKCS8_PRIV_KEY_INFO_free : procedure(a: PPKCS8_PRIV_KEY_INFO) cdecl = nil;
  f_EVP_PKCS82PKEY : function(p8: PPKCS8_PRIV_KEY_INFO):PEVP_PKEY cdecl = nil;
  f_EVP_PKEY2PKCS8 : function(pkey: PEVP_PKEY):PPKCS8_PRIV_KEY_INFO cdecl = nil;
  f_PKCS8_set_broken : function(p8: PPKCS8_PRIV_KEY_INFO; broken: Integer):PPKCS8_PRIV_KEY_INFO cdecl = nil;
  f_ERR_load_PEM_strings : procedure cdecl = nil;
  f_PEM_get_EVP_CIPHER_INFO : function(header: PChar; cipher: PEVP_CIPHER_INFO):Integer cdecl = nil;
  f_PEM_do_header : function(cipher: PEVP_CIPHER_INFO; data: PChar; len: PLong; callback: Ppem_password_cb; u: Pointer):Integer cdecl = nil;
  f_PEM_read_bio : function(bp: PBIO; name: PPChar; header: PPChar; data: PPChar; len: PLong):Integer cdecl = nil;
  f_PEM_write_bio : function(bp: PBIO; const name: PChar; hdr: PChar; data: PChar; len: Longint):Integer cdecl = nil;
  f_PEM_ASN1_read_bio : function(arg0: PFunction; const name: PChar; bp: PBIO; x: PPChar; cb: Ppem_password_cb; u: Pointer):PChar cdecl = nil;
  f_PEM_ASN1_write_bio : function(arg0: PFunction; const name: PChar; bp: PBIO; x: PChar; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer cdecl = nil;
  f_PEM_X509_INFO_read_bio : function(bp: PBIO; sk: PSTACK_X509_INFO; cb: Ppem_password_cb; u: Pointer):PSTACK_X509_INFO cdecl = nil;
  f_PEM_X509_INFO_write_bio : function(bp: PBIO; xi: PX509_INFO; enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cd: Ppem_password_cb; u: Pointer):Integer cdecl = nil;
  f_PEM_read : function(fp: PFILE; name: PPChar; header: PPChar; data: PPChar; len: PLong):Integer cdecl = nil;
  f_PEM_write : function(fp: PFILE; name: PChar; hdr: PChar; data: PChar; len: Longint):Integer cdecl = nil;
  f_PEM_ASN1_read : function(arg0: PFunction; const name: PChar; fp: PFILE; x: PPChar; cb: Ppem_password_cb; u: Pointer):PChar cdecl = nil;
  f_PEM_ASN1_write : function(arg0: PFunction; const name: PChar; fp: PFILE; x: PChar; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; callback: Ppem_password_cb; u: Pointer):Integer cdecl = nil;
  f_PEM_X509_INFO_read : function(fp: PFILE; sk: PSTACK_X509_INFO; cb: Ppem_password_cb; u: Pointer):PSTACK_X509_INFO cdecl = nil;
  f_PEM_SealInit : function(ctx: PPEM_ENCODE_SEAL_CTX; _type: PEVP_CIPHER; md_type: PEVP_MD; ek: PPChar; ekl: PInteger; iv: PChar; pubk: PPEVP_PKEY; npubk: Integer):Integer cdecl = nil;
  f_PEM_SealUpdate : procedure(ctx: PPEM_ENCODE_SEAL_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer) cdecl = nil;
  f_PEM_SealFinal : function(ctx: PPEM_ENCODE_SEAL_CTX; sig: PChar; sigl: PInteger; _out: PChar; outl: PInteger; priv: PEVP_PKEY):Integer cdecl = nil;
  f_PEM_SignInit : procedure(ctx: PEVP_MD_CTX; _type: PEVP_MD) cdecl = nil;
  f_PEM_SignUpdate : procedure(ctx: PEVP_MD_CTX; d: PChar; cnt: UInteger) cdecl = nil;
  f_PEM_SignFinal : function(ctx: PEVP_MD_CTX; sigret: PChar; siglen: PUInteger; pkey: PEVP_PKEY):Integer cdecl = nil;
  f_PEM_proc_type : procedure(buf: PChar; _type: Integer) cdecl = nil;
  f_PEM_dek_info : procedure(buf: PChar; const _type: PChar; len: Integer; str: PChar) cdecl = nil;
  f_PEM_read_bio_X509 : function(bp: PBIO; x: PPX509; cb: Ppem_password_cb; u: Pointer):PX509 cdecl = nil;
  f_PEM_read_X509 : function(fp: PFILE; x: PPX509; cb: Ppem_password_cb; u: Pointer):PX509 cdecl = nil;
  f_PEM_write_bio_X509 : function(bp: PBIO; x: PX509):Integer cdecl = nil;
  f_PEM_write_X509 : function(fp: PFILE; x: PX509):Integer cdecl = nil;
  f_PEM_read_bio_X509_REQ : function(bp: PBIO; x: PPX509_REQ; cb: Ppem_password_cb; u: Pointer):PX509_REQ cdecl = nil;
  f_PEM_read_X509_REQ : function(fp: PFILE; x: PPX509_REQ; cb: Ppem_password_cb; u: Pointer):PX509_REQ cdecl = nil;
  f_PEM_write_bio_X509_REQ : function(bp: PBIO; x: PX509_REQ):Integer cdecl = nil;
  f_PEM_write_X509_REQ : function(fp: PFILE; x: PX509_REQ):Integer cdecl = nil;
  f_PEM_read_bio_X509_CRL : function(bp: PBIO; x: PPX509_CRL; cb: Ppem_password_cb; u: Pointer):PX509_CRL cdecl = nil;
  f_PEM_read_X509_CRL : function(fp: PFILE; x: PPX509_CRL; cb: Ppem_password_cb; u: Pointer):PX509_CRL cdecl = nil;
  f_PEM_write_bio_X509_CRL : function(bp: PBIO; x: PX509_CRL):Integer cdecl = nil;
  f_PEM_write_X509_CRL : function(fp: PFILE; x: PX509_CRL):Integer cdecl = nil;
  f_PEM_read_bio_PKCS7 : function(bp: PBIO; x: PPPKCS7; cb: Ppem_password_cb; u: Pointer):PPKCS7 cdecl = nil;
  f_PEM_read_PKCS7 : function(fp: PFILE; x: PPPKCS7; cb: Ppem_password_cb; u: Pointer):PPKCS7 cdecl = nil;
  f_PEM_write_bio_PKCS7 : function(bp: PBIO; x: PPKCS7):Integer cdecl = nil;
  f_PEM_write_PKCS7 : function(fp: PFILE; x: PPKCS7):Integer cdecl = nil;
  f_PEM_read_bio_NETSCAPE_CERT_SEQUENCE : function(bp: PBIO; x: PPNETSCAPE_CERT_SEQUENCE; cb: Ppem_password_cb; u: Pointer):PNETSCAPE_CERT_SEQUENCE cdecl = nil;
  f_PEM_read_NETSCAPE_CERT_SEQUENCE : function(fp: PFILE; x: PPNETSCAPE_CERT_SEQUENCE; cb: Ppem_password_cb; u: Pointer):PNETSCAPE_CERT_SEQUENCE cdecl = nil;
  f_PEM_write_bio_NETSCAPE_CERT_SEQUENCE : function(bp: PBIO; x: PNETSCAPE_CERT_SEQUENCE):Integer cdecl = nil;
  f_PEM_write_NETSCAPE_CERT_SEQUENCE : function(fp: PFILE; x: PNETSCAPE_CERT_SEQUENCE):Integer cdecl = nil;
  f_PEM_read_bio_PKCS8 : function(bp: PBIO; x: PPX509_SIG; cb: Ppem_password_cb; u: Pointer):PX509_SIG cdecl = nil;
  f_PEM_read_PKCS8 : function(fp: PFILE; x: PPX509_SIG; cb: Ppem_password_cb; u: Pointer):PX509_SIG cdecl = nil;
  f_PEM_write_bio_PKCS8 : function(bp: PBIO; x: PX509_SIG):Integer cdecl = nil;
  f_PEM_write_PKCS8 : function(fp: PFILE; x: PX509_SIG):Integer cdecl = nil;
  f_PEM_read_bio_PKCS8_PRIV_KEY_INFO : function(bp: PBIO; x: PPPKCS8_PRIV_KEY_INFO; cb: Ppem_password_cb; u: Pointer):PPKCS8_PRIV_KEY_INFO cdecl = nil;
  f_PEM_read_PKCS8_PRIV_KEY_INFO : function(fp: PFILE; x: PPPKCS8_PRIV_KEY_INFO; cb: Ppem_password_cb; u: Pointer):PPKCS8_PRIV_KEY_INFO cdecl = nil;
  f_PEM_write_bio_PKCS8_PRIV_KEY_INFO : function(bp: PBIO; x: PPKCS8_PRIV_KEY_INFO):Integer cdecl = nil;
  f_PEM_write_PKCS8_PRIV_KEY_INFO : function(fp: PFILE; x: PPKCS8_PRIV_KEY_INFO):Integer cdecl = nil;
  f_PEM_read_bio_RSAPrivateKey : function(bp: PBIO; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA cdecl = nil;
  f_PEM_read_RSAPrivateKey : function(fp: PFILE; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA cdecl = nil;
  f_PEM_write_bio_RSAPrivateKey : function(bp: PBIO; x: PRSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer cdecl = nil;
  f_PEM_write_RSAPrivateKey : function(fp: PFILE; x: PRSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer cdecl = nil;
  f_PEM_read_bio_RSAPublicKey : function(bp: PBIO; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA cdecl = nil;
  f_PEM_read_RSAPublicKey : function(fp: PFILE; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA cdecl = nil;
  f_PEM_write_bio_RSAPublicKey : function(bp: PBIO; x: PRSA):Integer cdecl = nil;
  f_PEM_write_RSAPublicKey : function(fp: PFILE; x: PRSA):Integer cdecl = nil;
  f_PEM_read_bio_DSAPrivateKey : function(bp: PBIO; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA cdecl = nil;
  f_PEM_read_DSAPrivateKey : function(fp: PFILE; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA cdecl = nil;
  f_PEM_write_bio_DSAPrivateKey : function(bp: PBIO; x: PDSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer cdecl = nil;
  f_PEM_write_DSAPrivateKey : function(fp: PFILE; x: PDSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer cdecl = nil;
  f_PEM_read_bio_DSAparams : function(bp: PBIO; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA cdecl = nil;
  f_PEM_read_DSAparams : function(fp: PFILE; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA cdecl = nil;
  f_PEM_write_bio_DSAparams : function(bp: PBIO; x: PDSA):Integer cdecl = nil;
  f_PEM_write_DSAparams : function(fp: PFILE; x: PDSA):Integer cdecl = nil;
  f_PEM_read_bio_DHparams : function(bp: PBIO; x: PPDH; cb: Ppem_password_cb; u: Pointer):PDH cdecl = nil;
  f_PEM_read_DHparams : function(fp: PFILE; x: PPDH; cb: Ppem_password_cb; u: Pointer):PDH cdecl = nil;
  f_PEM_write_bio_DHparams : function(bp: PBIO; x: PDH):Integer cdecl = nil;
  f_PEM_write_DHparams : function(fp: PFILE; x: PDH):Integer cdecl = nil;
  f_PEM_read_bio_PrivateKey : function(bp: PBIO; x: PPEVP_PKEY; cb: Ppem_password_cb; u: Pointer):PEVP_PKEY cdecl = nil;
  f_PEM_read_PrivateKey : function(fp: PFILE; x: PPEVP_PKEY; cb: Ppem_password_cb; u: Pointer):PEVP_PKEY cdecl = nil;
  f_PEM_write_bio_PrivateKey : function(bp: PBIO; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer cdecl = nil;
  f_PEM_write_PrivateKey : function(fp: PFILE; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer cdecl = nil;
  f_PEM_write_bio_PKCS8PrivateKey : function(arg0: PBIO; arg1: PEVP_PKEY; const arg2: PEVP_CIPHER; arg3: PChar; arg4: Integer; arg5: Ppem_password_cb; arg6: Pointer):Integer cdecl = nil;
  f_PEM_write_PKCS8PrivateKey : function(fp: PFILE; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cd: Ppem_password_cb; u: Pointer):Integer cdecl = nil;
  f_sk_SSL_CIPHER_new : function(arg0: PFunction):PSTACK_SSL_CIPHER cdecl = nil;
  f_sk_SSL_CIPHER_new_null : function:PSTACK_SSL_CIPHER cdecl = nil;
  f_sk_SSL_CIPHER_free : procedure(sk: PSTACK_SSL_CIPHER) cdecl = nil;
  f_sk_SSL_CIPHER_num : function(const sk: PSTACK_SSL_CIPHER):Integer cdecl = nil;
  f_sk_SSL_CIPHER_value : function(const sk: PSTACK_SSL_CIPHER; n: Integer):PSSL_CIPHER cdecl = nil;
  f_sk_SSL_CIPHER_set : function(sk: PSTACK_SSL_CIPHER; n: Integer; v: PSSL_CIPHER):PSSL_CIPHER cdecl = nil;
  f_sk_SSL_CIPHER_zero : procedure(sk: PSTACK_SSL_CIPHER) cdecl = nil;
  f_sk_SSL_CIPHER_push : function(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER):Integer cdecl = nil;
  f_sk_SSL_CIPHER_unshift : function(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER):Integer cdecl = nil;
  f_sk_SSL_CIPHER_find : function(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER):Integer cdecl = nil;
  f_sk_SSL_CIPHER_delete : function(sk: PSTACK_SSL_CIPHER; n: Integer):PSSL_CIPHER cdecl = nil;
  f_sk_SSL_CIPHER_delete_ptr : procedure(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER) cdecl = nil;
  f_sk_SSL_CIPHER_insert : function(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER; n: Integer):Integer cdecl = nil;
  f_sk_SSL_CIPHER_dup : function(sk: PSTACK_SSL_CIPHER):PSTACK_SSL_CIPHER cdecl = nil;
  f_sk_SSL_CIPHER_pop_free : procedure(sk: PSTACK_SSL_CIPHER; arg1: PFunction) cdecl = nil;
  f_sk_SSL_CIPHER_shift : function(sk: PSTACK_SSL_CIPHER):PSSL_CIPHER cdecl = nil;
  f_sk_SSL_CIPHER_pop : function(sk: PSTACK_SSL_CIPHER):PSSL_CIPHER cdecl = nil;
  f_sk_SSL_CIPHER_sort : procedure(sk: PSTACK_SSL_CIPHER) cdecl = nil;
  f_sk_SSL_COMP_new : function(arg0: PFunction):PSTACK_SSL_COMP cdecl = nil;
  f_sk_SSL_COMP_new_null : function:PSTACK_SSL_COMP cdecl = nil;
  f_sk_SSL_COMP_free : procedure(sk: PSTACK_SSL_COMP) cdecl = nil;
  f_sk_SSL_COMP_num : function(const sk: PSTACK_SSL_COMP):Integer cdecl = nil;
  f_sk_SSL_COMP_value : function(const sk: PSTACK_SSL_COMP; n: Integer):PSSL_COMP cdecl = nil;
  f_sk_SSL_COMP_set : function(sk: PSTACK_SSL_COMP; n: Integer; v: PSSL_COMP):PSSL_COMP cdecl = nil;
  f_sk_SSL_COMP_zero : procedure(sk: PSTACK_SSL_COMP) cdecl = nil;
  f_sk_SSL_COMP_push : function(sk: PSTACK_SSL_COMP; v: PSSL_COMP):Integer cdecl = nil;
  f_sk_SSL_COMP_unshift : function(sk: PSTACK_SSL_COMP; v: PSSL_COMP):Integer cdecl = nil;
  f_sk_SSL_COMP_find : function(sk: PSTACK_SSL_COMP; v: PSSL_COMP):Integer cdecl = nil;
  f_sk_SSL_COMP_delete : function(sk: PSTACK_SSL_COMP; n: Integer):PSSL_COMP cdecl = nil;
  f_sk_SSL_COMP_delete_ptr : procedure(sk: PSTACK_SSL_COMP; v: PSSL_COMP) cdecl = nil;
  f_sk_SSL_COMP_insert : function(sk: PSTACK_SSL_COMP; v: PSSL_COMP; n: Integer):Integer cdecl = nil;
  f_sk_SSL_COMP_dup : function(sk: PSTACK_SSL_COMP):PSTACK_SSL_COMP cdecl = nil;
  f_sk_SSL_COMP_pop_free : procedure(sk: PSTACK_SSL_COMP; arg1: PFunction) cdecl = nil;
  f_sk_SSL_COMP_shift : function(sk: PSTACK_SSL_COMP):PSSL_COMP cdecl = nil;
  f_sk_SSL_COMP_pop : function(sk: PSTACK_SSL_COMP):PSSL_COMP cdecl = nil;
  f_sk_SSL_COMP_sort : procedure(sk: PSTACK_SSL_COMP) cdecl = nil;
  f_BIO_f_ssl : function:PBIO_METHOD cdecl = nil;
  f_BIO_new_ssl : function(ctx: PSSL_CTX; client: Integer):PBIO cdecl = nil;
  f_BIO_new_ssl_connect : function(ctx: PSSL_CTX):PBIO cdecl = nil;
  f_BIO_new_buffer_ssl_connect : function(ctx: PSSL_CTX):PBIO cdecl = nil;
  f_BIO_ssl_copy_session_id : function(_to: PBIO; from: PBIO):Integer cdecl = nil;
  f_BIO_ssl_shutdown : procedure(ssl_bio: PBIO) cdecl = nil;
  f_SSL_CTX_set_cipher_list : function(arg0: PSSL_CTX; str: PChar):Integer cdecl = nil;
  f_SSL_CTX_new : function(meth: PSSL_METHOD):PSSL_CTX cdecl = nil;
  f_SSL_CTX_free : procedure(arg0: PSSL_CTX) cdecl = nil;
  f_SSL_CTX_set_timeout : function(ctx: PSSL_CTX; t: Longint):Longint cdecl = nil;
  f_SSL_CTX_get_timeout : function(ctx: PSSL_CTX):Longint cdecl = nil;
  f_SSL_CTX_get_cert_store : function(arg0: PSSL_CTX):PX509_STORE cdecl = nil;
  f_SSL_CTX_set_cert_store : procedure(arg0: PSSL_CTX; arg1: PX509_STORE) cdecl = nil;
  f_SSL_want : function(s: PSSL):Integer cdecl = nil;
  f_SSL_clear : function(s: PSSL):Integer cdecl = nil;
  f_SSL_CTX_flush_sessions : procedure(ctx: PSSL_CTX; tm: Longint) cdecl = nil;
  f_SSL_get_current_cipher : function(s: PSSL):PSSL_CIPHER cdecl = nil;
  f_SSL_CIPHER_get_bits : function(c: PSSL_CIPHER; alg_bits: PInteger):Integer cdecl = nil;
  f_SSL_CIPHER_get_version : function(c: PSSL_CIPHER):PChar cdecl = nil;
  f_SSL_CIPHER_get_name : function(c: PSSL_CIPHER):PChar cdecl = nil;
  f_SSL_get_fd : function(s: PSSL):Integer cdecl = nil;
  f_SSL_get_cipher_list : function(s: PSSL; n: Integer):PChar cdecl = nil;
  f_SSL_get_shared_ciphers : function(s: PSSL; buf: PChar; len: Integer):PChar cdecl = nil;
  f_SSL_get_read_ahead : function(s: PSSL):Integer cdecl = nil;
  f_SSL_pending : function(s: PSSL):Integer cdecl = nil;
  f_SSL_set_fd : function(s: PSSL; fd: Integer):Integer cdecl = nil;
  f_SSL_set_rfd : function(s: PSSL; fd: Integer):Integer cdecl = nil;
  f_SSL_set_wfd : function(s: PSSL; fd: Integer):Integer cdecl = nil;
  f_SSL_set_bio : procedure(s: PSSL; rbio: PBIO; wbio: PBIO) cdecl = nil;
  f_SSL_get_rbio : function(s: PSSL):PBIO cdecl = nil;
  f_SSL_get_wbio : function(s: PSSL):PBIO cdecl = nil;
  f_SSL_set_cipher_list : function(s: PSSL; str: PChar):Integer cdecl = nil;
  f_SSL_set_read_ahead : procedure(s: PSSL; yes: Integer) cdecl = nil;
  f_SSL_get_verify_mode : function(s: PSSL):Integer cdecl = nil;
  f_SSL_get_verify_depth : function(s: PSSL):Integer cdecl = nil;
  f_SSL_set_verify : procedure(s: PSSL; mode: Integer; arg2: PFunction) cdecl = nil;
  f_SSL_set_verify_depth : procedure(s: PSSL; depth: Integer) cdecl = nil;
  f_SSL_use_RSAPrivateKey : function(ssl: PSSL; rsa: PRSA):Integer cdecl = nil;
  f_SSL_use_RSAPrivateKey_ASN1 : function(ssl: PSSL; d: PChar; len: Longint):Integer cdecl = nil;
  f_SSL_use_PrivateKey : function(ssl: PSSL; pkey: PEVP_PKEY):Integer cdecl = nil;
  f_SSL_use_PrivateKey_ASN1 : function(pk: Integer; ssl: PSSL; d: PChar; len: Longint):Integer cdecl = nil;
  f_SSL_use_certificate : function(ssl: PSSL; x: PX509):Integer cdecl = nil;
  f_SSL_use_certificate_ASN1 : function(ssl: PSSL; d: PChar; len: Integer):Integer cdecl = nil;
  f_SSL_use_RSAPrivateKey_file : function(ssl: PSSL; const _file: PChar; _type: Integer):Integer cdecl = nil;
  f_SSL_use_PrivateKey_file : function(ssl: PSSL; const _file: PChar; _type: Integer):Integer cdecl = nil;
  f_SSL_use_certificate_file : function(ssl: PSSL; const _file: PChar; _type: Integer):Integer cdecl = nil;
  f_SSL_CTX_use_RSAPrivateKey_file : function(ctx: PSSL_CTX; const _file: PChar; _type: Integer):Integer cdecl = nil;
  f_SSL_CTX_use_PrivateKey_file : function(ctx: PSSL_CTX; const _file: PChar; _type: Integer):Integer cdecl = nil;
  f_SSL_CTX_use_certificate_file : function(ctx: PSSL_CTX; const _file: PChar; _type: Integer):Integer cdecl = nil;
  f_SSL_CTX_use_certificate_chain_file : function(ctx: PSSL_CTX; const _file: PChar):Integer cdecl = nil;
  f_SSL_load_client_CA_file : function(const _file: PChar):PSTACK_X509_NAME cdecl = nil;
  f_SSL_add_file_cert_subjects_to_stack : function(stackCAs: PSTACK_X509_NAME; const _file: PChar):Integer cdecl = nil;
  f_ERR_load_SSL_strings : procedure cdecl = nil;
  f_SSL_load_error_strings : procedure cdecl = nil;
  f_SSL_state_string : function(s: PSSL):PChar cdecl = nil;
  f_SSL_rstate_string : function(s: PSSL):PChar cdecl = nil;
  f_SSL_state_string_long : function(s: PSSL):PChar cdecl = nil;
  f_SSL_rstate_string_long : function(s: PSSL):PChar cdecl = nil;
  f_SSL_SESSION_get_time : function(s: PSSL_SESSION):Longint cdecl = nil;
  f_SSL_SESSION_set_time : function(s: PSSL_SESSION; t: Longint):Longint cdecl = nil;
  f_SSL_SESSION_get_timeout : function(s: PSSL_SESSION):Longint cdecl = nil;
  f_SSL_SESSION_set_timeout : function(s: PSSL_SESSION; t: Longint):Longint cdecl = nil;
  f_SSL_copy_session_id : procedure(_to: PSSL; from: PSSL) cdecl = nil;
  f_SSL_SESSION_new : function:PSSL_SESSION cdecl = nil;
  f_SSL_SESSION_hash : function(a: PSSL_SESSION):Cardinal cdecl = nil;
  f_SSL_SESSION_cmp : function(a: PSSL_SESSION; b: PSSL_SESSION):Integer cdecl = nil;
  f_SSL_SESSION_print_fp : function(fp: PFILE; ses: PSSL_SESSION):Integer cdecl = nil;
  f_SSL_SESSION_print : function(fp: PBIO; ses: PSSL_SESSION):Integer cdecl = nil;
  f_SSL_SESSION_free : procedure(ses: PSSL_SESSION) cdecl = nil;
  f_i2d_SSL_SESSION : function(_in: PSSL_SESSION; pp: PPChar):Integer cdecl = nil;
  f_SSL_set_session : function(_to: PSSL; session: PSSL_SESSION):Integer cdecl = nil;
  f_SSL_CTX_add_session : function(s: PSSL_CTX; c: PSSL_SESSION):Integer cdecl = nil;
  f_SSL_CTX_remove_session : function(arg0: PSSL_CTX; c: PSSL_SESSION):Integer cdecl = nil;
  f_d2i_SSL_SESSION : function(a: PPSSL_SESSION; pp: PPChar; length: Longint):PSSL_SESSION cdecl = nil;
  f_SSL_get_peer_certificate : function(s: PSSL):PX509 cdecl = nil;
  f_SSL_get_peer_cert_chain : function(s: PSSL):PSTACK_X509 cdecl = nil;
  f_SSL_CTX_get_verify_mode : function(ctx: PSSL_CTX):Integer cdecl = nil;
  f_SSL_CTX_get_verify_depth : function(ctx: PSSL_CTX):Integer cdecl = nil;
  f_SSL_CTX_set_verify : procedure(ctx: PSSL_CTX; mode: Integer; arg2: PFunction) cdecl = nil;
  f_SSL_CTX_set_verify_depth : procedure(ctx: PSSL_CTX; depth: Integer) cdecl = nil;
  f_SSL_CTX_set_cert_verify_callback : procedure(ctx: PSSL_CTX; arg1: PFunction; arg: PChar) cdecl = nil;
  f_SSL_CTX_use_RSAPrivateKey : function(ctx: PSSL_CTX; rsa: PRSA):Integer cdecl = nil;
  f_SSL_CTX_use_RSAPrivateKey_ASN1 : function(ctx: PSSL_CTX; d: PChar; len: Longint):Integer cdecl = nil;
  f_SSL_CTX_use_PrivateKey : function(ctx: PSSL_CTX; pkey: PEVP_PKEY):Integer cdecl = nil;
  f_SSL_CTX_use_PrivateKey_ASN1 : function(pk: Integer; ctx: PSSL_CTX; d: PChar; len: Longint):Integer cdecl = nil;
  f_SSL_CTX_use_certificate : function(ctx: PSSL_CTX; x: PX509):Integer cdecl = nil;
  f_SSL_CTX_use_certificate_ASN1 : function(ctx: PSSL_CTX; len: Integer; d: PChar):Integer cdecl = nil;
  f_SSL_CTX_set_default_passwd_cb : procedure(ctx: PSSL_CTX; cb: Ppem_password_cb) cdecl = nil;
  f_SSL_CTX_set_default_passwd_cb_userdata : procedure(ctx: PSSL_CTX; u: Pointer) cdecl = nil;
  f_SSL_CTX_check_private_key : function(ctx: PSSL_CTX):Integer cdecl = nil;
  f_SSL_check_private_key : function(ctx: PSSL):Integer cdecl = nil;
  f_SSL_CTX_set_session_id_context : function(ctx: PSSL_CTX; const sid_ctx: PChar; sid_ctx_len: UInteger):Integer cdecl = nil;
  f_SSL_new : function(ctx: PSSL_CTX):PSSL cdecl = nil;
  f_SSL_set_session_id_context : function(ssl: PSSL; const sid_ctx: PChar; sid_ctx_len: UInteger):Integer cdecl = nil;
  f_SSL_free : procedure(ssl: PSSL) cdecl = nil;
  f_SSL_accept : function(ssl: PSSL):Integer cdecl = nil;
  f_SSL_connect : function(ssl: PSSL):Integer cdecl = nil;
  f_SSL_read : function(ssl: PSSL; buf: PChar; num: Integer):Integer cdecl = nil;
  f_SSL_peek : function(ssl: PSSL; buf: PChar; num: Integer):Integer cdecl = nil;
  f_SSL_write : function(ssl: PSSL; const buf: PChar; num: Integer):Integer cdecl = nil;
  f_SSL_ctrl : function(ssl: PSSL; cmd: Integer; larg: Longint; parg: PChar):Longint cdecl = nil;
  f_SSL_CTX_ctrl : function(ctx: PSSL_CTX; cmd: Integer; larg: Longint; parg: PChar):Longint cdecl = nil;
  f_SSL_get_error : function(s: PSSL; ret_code: Integer):Integer cdecl = nil;
  f_SSL_get_version : function(s: PSSL):PChar cdecl = nil;
  f_SSL_CTX_set_ssl_version : function(ctx: PSSL_CTX; meth: PSSL_METHOD):Integer cdecl = nil;
  f_SSLv2_method : function:PSSL_METHOD cdecl = nil;
  f_SSLv2_server_method : function:PSSL_METHOD cdecl = nil;
  f_SSLv2_client_method : function:PSSL_METHOD cdecl = nil;
  f_SSLv3_method : function:PSSL_METHOD cdecl = nil;
  f_SSLv3_server_method : function:PSSL_METHOD cdecl = nil;
  f_SSLv3_client_method : function:PSSL_METHOD cdecl = nil;
  f_SSLv23_method : function:PSSL_METHOD cdecl = nil;
  f_SSLv23_server_method : function:PSSL_METHOD cdecl = nil;
  f_SSLv23_client_method : function:PSSL_METHOD cdecl = nil;
  f_TLSv1_method : function:PSSL_METHOD cdecl = nil;
  f_TLSv1_server_method : function:PSSL_METHOD cdecl = nil;
  f_TLSv1_client_method : function:PSSL_METHOD cdecl = nil;
  f_SSL_get_ciphers : function(s: PSSL):PSTACK_SSL_CIPHER cdecl = nil;
  f_SSL_do_handshake : function(s: PSSL):Integer cdecl = nil;
  f_SSL_renegotiate : function(s: PSSL):Integer cdecl = nil;
  f_SSL_shutdown : function(s: PSSL):Integer cdecl = nil;
  f_SSL_get_ssl_method : function(s: PSSL):PSSL_METHOD cdecl = nil;
  f_SSL_set_ssl_method : function(s: PSSL; method: PSSL_METHOD):Integer cdecl = nil;
  f_SSL_alert_type_string_long : function(value: Integer):PChar cdecl = nil;
  f_SSL_alert_type_string : function(value: Integer):PChar cdecl = nil;
  f_SSL_alert_desc_string_long : function(value: Integer):PChar cdecl = nil;
  f_SSL_alert_desc_string : function(value: Integer):PChar cdecl = nil;
  f_SSL_set_client_CA_list : procedure(s: PSSL; list: PSTACK_X509_NAME) cdecl = nil;
  f_SSL_CTX_set_client_CA_list : procedure(ctx: PSSL_CTX; list: PSTACK_X509_NAME) cdecl = nil;
  f_SSL_get_client_CA_list : function(s: PSSL):PSTACK_X509_NAME cdecl = nil;
  f_SSL_CTX_get_client_CA_list : function(s: PSSL_CTX):PSTACK_X509_NAME cdecl = nil;
  f_SSL_add_client_CA : function(ssl: PSSL; x: PX509):Integer cdecl = nil;
  f_SSL_CTX_add_client_CA : function(ctx: PSSL_CTX; x: PX509):Integer cdecl = nil;
  f_SSL_set_connect_state : procedure(s: PSSL) cdecl = nil;
  f_SSL_set_accept_state : procedure(s: PSSL) cdecl = nil;
  f_SSL_get_default_timeout : function(s: PSSL):Longint cdecl = nil;
  f_SSL_library_init : function:Integer cdecl = nil;
  f_SSL_CIPHER_description : function(arg0: PSSL_CIPHER; buf: PChar; size: Integer):PChar cdecl = nil;
  f_SSL_dup_CA_list : function(sk: PSTACK_X509_NAME):PSTACK_X509_NAME cdecl = nil;
  f_SSL_dup : function(ssl: PSSL):PSSL cdecl = nil;
  f_SSL_get_certificate : function(ssl: PSSL):PX509 cdecl = nil;
  f_SSL_get_privatekey : function(ssl: PSSL):Pevp_pkey_st cdecl = nil;
  f_SSL_CTX_set_quiet_shutdown : procedure(ctx: PSSL_CTX; mode: Integer) cdecl = nil;
  f_SSL_CTX_get_quiet_shutdown : function(ctx: PSSL_CTX):Integer cdecl = nil;
  f_SSL_set_quiet_shutdown : procedure(ssl: PSSL; mode: Integer) cdecl = nil;
  f_SSL_get_quiet_shutdown : function(ssl: PSSL):Integer cdecl = nil;
  f_SSL_set_shutdown : procedure(ssl: PSSL; mode: Integer) cdecl = nil;
  f_SSL_get_shutdown : function(ssl: PSSL):Integer cdecl = nil;
  f_SSL_version : function(ssl: PSSL):Integer cdecl = nil;
  f_SSL_CTX_set_default_verify_paths : function(ctx: PSSL_CTX):Integer cdecl = nil;
  f_SSL_CTX_load_verify_locations : function(ctx: PSSL_CTX; const CAfile: PChar; const CApath: PChar):Integer cdecl = nil;
  f_SSL_get_session : function(ssl: PSSL):PSSL_SESSION cdecl = nil;
  f_SSL_get_SSL_CTX : function(ssl: PSSL):PSSL_CTX cdecl = nil;
  f_SSL_set_info_callback : procedure(ssl: PSSL; arg1: PFunction) cdecl = nil;
  f_SSL_state : function(ssl: PSSL):Integer cdecl = nil;
  f_SSL_set_verify_result : procedure(ssl: PSSL; v: Longint) cdecl = nil;
  f_SSL_get_verify_result : function(ssl: PSSL):Longint cdecl = nil;
  f_SSL_set_ex_data : function(ssl: PSSL; idx: Integer; data: Pointer):Integer cdecl = nil;
  f_SSL_get_ex_data : function(ssl: PSSL; idx: Integer):Pointer cdecl = nil;
  f_SSL_get_ex_new_index : function(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer cdecl = nil;
  f_SSL_SESSION_set_ex_data : function(ss: PSSL_SESSION; idx: Integer; data: Pointer):Integer cdecl = nil;
  f_SSL_SESSION_get_ex_data : function(ss: PSSL_SESSION; idx: Integer):Pointer cdecl = nil;
  f_SSL_SESSION_get_ex_new_index : function(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer cdecl = nil;
  f_SSL_CTX_set_ex_data : function(ssl: PSSL_CTX; idx: Integer; data: Pointer):Integer cdecl = nil;
  f_SSL_CTX_get_ex_data : function(ssl: PSSL_CTX; idx: Integer):Pointer cdecl = nil;
  f_SSL_CTX_get_ex_new_index : function(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer cdecl = nil;
  f_SSL_get_ex_data_X509_STORE_CTX_idx : function:Integer cdecl = nil;
  f_SSL_CTX_set_tmp_rsa_callback : procedure(ctx: PSSL_CTX; arg1: PFunction) cdecl = nil;
  f_SSL_set_tmp_rsa_callback : procedure(ssl: PSSL; arg1: PFunction) cdecl = nil;
  f_SSL_CTX_set_tmp_dh_callback : procedure(ctx: PSSL_CTX; arg1: PFunction) cdecl = nil;
  f_SSL_set_tmp_dh_callback : procedure(ssl: PSSL; arg1: PFunction) cdecl = nil;
  f_SSL_COMP_add_compression_method : function(id: Integer; cm: PChar):Integer cdecl = nil;
  f_SSLeay_add_ssl_algorithms : function:Integer cdecl = nil;
  f_SSL_set_app_data : function(s: PSSL; arg: Pointer):Integer cdecl = nil;
  f_SSL_get_app_data : function(s: PSSL):Pointer cdecl = nil;
  f_SSL_CTX_set_info_callback : procedure(ctx: PSSL_CTX; cb: PFunction) cdecl = nil;
  f_SSL_CTX_set_options : function(ctx: PSSL_CTX; op: Longint):Longint cdecl = nil;
  f_SSL_is_init_finished : function(s: PSSL):Integer cdecl = nil;
  f_SSL_in_init : function(s: PSSL):Integer cdecl = nil;
  f_SSL_in_before : function(s: PSSL):Integer cdecl = nil;
  f_SSL_in_connect_init : function(s: PSSL):Integer cdecl = nil;
  f_SSL_in_accept_init : function(s: PSSL):Integer cdecl = nil;
  f_X509_STORE_CTX_get_app_data : function(ctx: PX509_STORE_CTX):Pointer cdecl = nil;
  f_X509_get_notBefore : function(x509: PX509):PASN1_UTCTIME cdecl = nil;
  f_X509_get_notAfter : function(x509: PX509):PASN1_UTCTIME cdecl = nil;
  f_UCTTimeDecode : function(UCTtime: PASN1_UTCTIME; year: PUShort; month: PUShort; day: PUShort; hour: PUShort; min: PUShort; sec: PUShort; tz_hour: PInteger; tz_min: PInteger):Integer cdecl = nil;
  f_SSL_CTX_get_version : function(ctx: PSSL_CTX):Integer cdecl = nil;
  f_SSL_SESSION_get_id : function(s: PSSL_SESSION; id: PPChar; length: PInteger):Integer cdecl = nil;
  f_SSL_SESSION_get_id_ctx : function(s: PSSL_SESSION; id: PPChar; length: PInteger):Integer cdecl = nil;
  f_fopen : function(const path: PChar; mode: PChar):PFILE cdecl = nil;
  f_fclose : function(stream: PFILE):Integer cdecl = nil;

{$ENDIF}

Function Load:Boolean;
Procedure Unload;
Function WhichFailedToLoad:String;

{ Folowing functions are in parsed files DUPLICATED ---------------------------
  ERR_load_PEM_strings

----------------------------------------------------------------------------- }
implementation

Uses
  WinTypes, WinProcs;

Const
  MySSL_DLL_name   = 'MySSL.dll';
  hMySSL : Integer = 0;

{ This constant's are used twice. First time in Load function and second time  }
{ in function WhichFailedToLoad. I belive that this reduce size of final       }
{ compiled file.                                                               }
Const
  fn_sk_num = 'sk_num';
  fn_sk_value = 'sk_value';
  fn_sk_set = 'sk_set';
  fn_sk_new = 'sk_new';
  fn_sk_free = 'sk_free';
  fn_sk_pop_free = 'sk_pop_free';
  fn_sk_insert = 'sk_insert';
  fn_sk_delete = 'sk_delete';
  fn_sk_delete_ptr = 'sk_delete_ptr';
  fn_sk_find = 'sk_find';
  fn_sk_push = 'sk_push';
  fn_sk_unshift = 'sk_unshift';
  fn_sk_shift = 'sk_shift';
  fn_sk_pop = 'sk_pop';
  fn_sk_zero = 'sk_zero';
  fn_sk_dup = 'sk_dup';
  fn_sk_sort = 'sk_sort';
  fn_SSLeay_version = 'SSLeay_version';
  fn_SSLeay = 'SSLeay';
  fn_CRYPTO_get_ex_new_index = 'CRYPTO_get_ex_new_index';
  fn_CRYPTO_set_ex_data = 'CRYPTO_set_ex_data';
  fn_CRYPTO_get_ex_data = 'CRYPTO_get_ex_data';
  fn_CRYPTO_dup_ex_data = 'CRYPTO_dup_ex_data';
  fn_CRYPTO_free_ex_data = 'CRYPTO_free_ex_data';
  fn_CRYPTO_new_ex_data = 'CRYPTO_new_ex_data';
  fn_CRYPTO_mem_ctrl = 'CRYPTO_mem_ctrl';
  fn_CRYPTO_get_new_lockid = 'CRYPTO_get_new_lockid';
  fn_CRYPTO_num_locks = 'CRYPTO_num_locks';
  fn_CRYPTO_lock = 'CRYPTO_lock';
  fn_CRYPTO_set_locking_callback = 'CRYPTO_set_locking_callback';
  fn_CRYPTO_set_add_lock_callback = 'CRYPTO_set_add_lock_callback';
  fn_CRYPTO_set_id_callback = 'CRYPTO_set_id_callback';
  fn_CRYPTO_thread_id = 'CRYPTO_thread_id';
  fn_CRYPTO_get_lock_name = 'CRYPTO_get_lock_name';
  fn_CRYPTO_add_lock = 'CRYPTO_add_lock';
  fn_CRYPTO_set_mem_functions = 'CRYPTO_set_mem_functions';
  fn_CRYPTO_get_mem_functions = 'CRYPTO_get_mem_functions';
  fn_CRYPTO_set_locked_mem_functions = 'CRYPTO_set_locked_mem_functions';
  fn_CRYPTO_get_locked_mem_functions = 'CRYPTO_get_locked_mem_functions';
  fn_CRYPTO_malloc_locked = 'CRYPTO_malloc_locked';
  fn_CRYPTO_free_locked = 'CRYPTO_free_locked';
  fn_CRYPTO_malloc = 'CRYPTO_malloc';
  fn_CRYPTO_free = 'CRYPTO_free';
  fn_CRYPTO_realloc = 'CRYPTO_realloc';
  fn_CRYPTO_remalloc = 'CRYPTO_remalloc';
  fn_CRYPTO_dbg_malloc = 'CRYPTO_dbg_malloc';
  fn_CRYPTO_dbg_realloc = 'CRYPTO_dbg_realloc';
  fn_CRYPTO_dbg_free = 'CRYPTO_dbg_free';
  fn_CRYPTO_dbg_remalloc = 'CRYPTO_dbg_remalloc';
  fn_CRYPTO_mem_leaks_fp = 'CRYPTO_mem_leaks_fp';
  fn_CRYPTO_mem_leaks = 'CRYPTO_mem_leaks';
  fn_CRYPTO_mem_leaks_cb = 'CRYPTO_mem_leaks_cb';
  fn_ERR_load_CRYPTO_strings = 'ERR_load_CRYPTO_strings';
  fn_lh_new = 'lh_new';
  fn_lh_free = 'lh_free';
  fn_lh_insert = 'lh_insert';
  fn_lh_delete = 'lh_delete';
  fn_lh_retrieve = 'lh_retrieve';
  fn_lh_doall = 'lh_doall';
  fn_lh_doall_arg = 'lh_doall_arg';
  fn_lh_strhash = 'lh_strhash';
  fn_lh_stats = 'lh_stats';
  fn_lh_node_stats = 'lh_node_stats';
  fn_lh_node_usage_stats = 'lh_node_usage_stats';
  fn_BUF_MEM_new = 'BUF_MEM_new';
  fn_BUF_MEM_free = 'BUF_MEM_free';
  fn_BUF_MEM_grow = 'BUF_MEM_grow';
  fn_BUF_strdup = 'BUF_strdup';
  fn_ERR_load_BUF_strings = 'ERR_load_BUF_strings';
  fn_BIO_ctrl_pending = 'BIO_ctrl_pending';
  fn_BIO_ctrl_wpending = 'BIO_ctrl_wpending';
  fn_BIO_ctrl_get_write_guarantee = 'BIO_ctrl_get_write_guarantee';
  fn_BIO_ctrl_get_read_request = 'BIO_ctrl_get_read_request';
  fn_BIO_set_ex_data = 'BIO_set_ex_data';
  fn_BIO_get_ex_data = 'BIO_get_ex_data';
  fn_BIO_get_ex_new_index = 'BIO_get_ex_new_index';
  fn_BIO_s_file = 'BIO_s_file';
  fn_BIO_new_file = 'BIO_new_file';
  fn_BIO_new_fp = 'BIO_new_fp';
  fn_BIO_new = 'BIO_new';
  fn_BIO_set = 'BIO_set';
  fn_BIO_free = 'BIO_free';
  fn_BIO_read = 'BIO_read';
  fn_BIO_gets = 'BIO_gets';
  fn_BIO_write = 'BIO_write';
  fn_BIO_puts = 'BIO_puts';
  fn_BIO_ctrl = 'BIO_ctrl';
  fn_BIO_ptr_ctrl = 'BIO_ptr_ctrl';
  fn_BIO_int_ctrl = 'BIO_int_ctrl';
  fn_BIO_push = 'BIO_push';
  fn_BIO_pop = 'BIO_pop';
  fn_BIO_free_all = 'BIO_free_all';
  fn_BIO_find_type = 'BIO_find_type';
  fn_BIO_get_retry_BIO = 'BIO_get_retry_BIO';
  fn_BIO_get_retry_reason = 'BIO_get_retry_reason';
  fn_BIO_dup_chain = 'BIO_dup_chain';
  fn_BIO_debug_callback = 'BIO_debug_callback';
  fn_BIO_s_mem = 'BIO_s_mem';
  fn_BIO_s_socket = 'BIO_s_socket';
  fn_BIO_s_connect = 'BIO_s_connect';
  fn_BIO_s_accept = 'BIO_s_accept';
  fn_BIO_s_fd = 'BIO_s_fd';
  fn_BIO_s_bio = 'BIO_s_bio';
  fn_BIO_s_null = 'BIO_s_null';
  fn_BIO_f_null = 'BIO_f_null';
  fn_BIO_f_buffer = 'BIO_f_buffer';
  fn_BIO_f_nbio_test = 'BIO_f_nbio_test';
  fn_BIO_sock_should_retry = 'BIO_sock_should_retry';
  fn_BIO_sock_non_fatal_error = 'BIO_sock_non_fatal_error';
  fn_BIO_fd_should_retry = 'BIO_fd_should_retry';
  fn_BIO_fd_non_fatal_error = 'BIO_fd_non_fatal_error';
  fn_BIO_dump = 'BIO_dump';
  fn_BIO_gethostbyname = 'BIO_gethostbyname';
  fn_BIO_sock_error = 'BIO_sock_error';
  fn_BIO_socket_ioctl = 'BIO_socket_ioctl';
  fn_BIO_socket_nbio = 'BIO_socket_nbio';
  fn_BIO_get_port = 'BIO_get_port';
  fn_BIO_get_host_ip = 'BIO_get_host_ip';
  fn_BIO_get_accept_socket = 'BIO_get_accept_socket';
  fn_BIO_accept = 'BIO_accept';
  fn_BIO_sock_init = 'BIO_sock_init';
  fn_BIO_sock_cleanup = 'BIO_sock_cleanup';
  fn_BIO_set_tcp_ndelay = 'BIO_set_tcp_ndelay';
  fn_ERR_load_BIO_strings = 'ERR_load_BIO_strings';
  fn_BIO_new_socket = 'BIO_new_socket';
  fn_BIO_new_fd = 'BIO_new_fd';
  fn_BIO_new_connect = 'BIO_new_connect';
  fn_BIO_new_accept = 'BIO_new_accept';
  fn_BIO_new_bio_pair = 'BIO_new_bio_pair';
  fn_BIO_copy_next_retry = 'BIO_copy_next_retry';
  fn_BIO_ghbn_ctrl = 'BIO_ghbn_ctrl';
  fn_MD2_options = 'MD2_options';
  fn_MD2_Init = 'MD2_Init';
  fn_MD2_Update = 'MD2_Update';
  fn_MD2_Final = 'MD2_Final';
  fn_MD2 = 'MD2';
  fn_MD5_Init = 'MD5_Init';
  fn_MD5_Update = 'MD5_Update';
  fn_MD5_Final = 'MD5_Final';
  fn_MD5 = 'MD5';
  fn_MD5_Transform = 'MD5_Transform';
  fn_SHA_Init = 'SHA_Init';
  fn_SHA_Update = 'SHA_Update';
  fn_SHA_Final = 'SHA_Final';
  fn_SHA = 'SHA';
  fn_SHA_Transform = 'SHA_Transform';
  fn_SHA1_Init = 'SHA1_Init';
  fn_SHA1_Update = 'SHA1_Update';
  fn_SHA1_Final = 'SHA1_Final';
  fn_SHA1 = 'SHA1';
  fn_SHA1_Transform = 'SHA1_Transform';
  fn_RIPEMD160_Init = 'RIPEMD160_Init';
  fn_RIPEMD160_Update = 'RIPEMD160_Update';
  fn_RIPEMD160_Final = 'RIPEMD160_Final';
  fn_RIPEMD160 = 'RIPEMD160';
  fn_RIPEMD160_Transform = 'RIPEMD160_Transform';
  fn_des_options = 'des_options';
  fn_des_ecb3_encrypt = 'des_ecb3_encrypt';
  fn_des_cbc_cksum = 'des_cbc_cksum';
  fn_des_cbc_encrypt = 'des_cbc_encrypt';
  fn_des_ncbc_encrypt = 'des_ncbc_encrypt';
  fn_des_xcbc_encrypt = 'des_xcbc_encrypt';
  fn_des_cfb_encrypt = 'des_cfb_encrypt';
  fn_des_ecb_encrypt = 'des_ecb_encrypt';
  fn_des_encrypt = 'des_encrypt';
  fn_des_encrypt2 = 'des_encrypt2';
  fn_des_encrypt3 = 'des_encrypt3';
  fn_des_decrypt3 = 'des_decrypt3';
  fn_des_ede3_cbc_encrypt = 'des_ede3_cbc_encrypt';
  fn_des_ede3_cbcm_encrypt = 'des_ede3_cbcm_encrypt';
  fn_des_ede3_cfb64_encrypt = 'des_ede3_cfb64_encrypt';
  fn_des_ede3_ofb64_encrypt = 'des_ede3_ofb64_encrypt';
  fn_des_xwhite_in2out = 'des_xwhite_in2out';
  fn_des_enc_read = 'des_enc_read';
  fn_des_enc_write = 'des_enc_write';
  fn_des_fcrypt = 'des_fcrypt';
  fn_crypt = 'crypt';
  fn_des_ofb_encrypt = 'des_ofb_encrypt';
  fn_des_pcbc_encrypt = 'des_pcbc_encrypt';
  fn_des_quad_cksum = 'des_quad_cksum';
  fn_des_random_seed = 'des_random_seed';
  fn_des_random_key = 'des_random_key';
  fn_des_read_password = 'des_read_password';
  fn_des_read_2passwords = 'des_read_2passwords';
  fn_des_read_pw_string = 'des_read_pw_string';
  fn_des_set_odd_parity = 'des_set_odd_parity';
  fn_des_is_weak_key = 'des_is_weak_key';
  fn_des_set_key = 'des_set_key';
  fn_des_key_sched = 'des_key_sched';
  fn_des_string_to_key = 'des_string_to_key';
  fn_des_string_to_2keys = 'des_string_to_2keys';
  fn_des_cfb64_encrypt = 'des_cfb64_encrypt';
  fn_des_ofb64_encrypt = 'des_ofb64_encrypt';
  fn_des_read_pw = 'des_read_pw';
  fn_des_cblock_print_file = 'des_cblock_print_file';
  fn_RC4_options = 'RC4_options';
  fn_RC4_set_key = 'RC4_set_key';
  fn_RC4 = 'RC4';
  fn_RC2_set_key = 'RC2_set_key';
  fn_RC2_ecb_encrypt = 'RC2_ecb_encrypt';
  fn_RC2_encrypt = 'RC2_encrypt';
  fn_RC2_decrypt = 'RC2_decrypt';
  fn_RC2_cbc_encrypt = 'RC2_cbc_encrypt';
  fn_RC2_cfb64_encrypt = 'RC2_cfb64_encrypt';
  fn_RC2_ofb64_encrypt = 'RC2_ofb64_encrypt';
  fn_RC5_32_set_key = 'RC5_32_set_key';
  fn_RC5_32_ecb_encrypt = 'RC5_32_ecb_encrypt';
  fn_RC5_32_encrypt = 'RC5_32_encrypt';
  fn_RC5_32_decrypt = 'RC5_32_decrypt';
  fn_RC5_32_cbc_encrypt = 'RC5_32_cbc_encrypt';
  fn_RC5_32_cfb64_encrypt = 'RC5_32_cfb64_encrypt';
  fn_RC5_32_ofb64_encrypt = 'RC5_32_ofb64_encrypt';
  fn_BF_set_key = 'BF_set_key';
  fn_BF_ecb_encrypt = 'BF_ecb_encrypt';
  fn_BF_encrypt = 'BF_encrypt';
  fn_BF_decrypt = 'BF_decrypt';
  fn_BF_cbc_encrypt = 'BF_cbc_encrypt';
  fn_BF_cfb64_encrypt = 'BF_cfb64_encrypt';
  fn_BF_ofb64_encrypt = 'BF_ofb64_encrypt';
  fn_BF_options = 'BF_options';
  fn_CAST_set_key = 'CAST_set_key';
  fn_CAST_ecb_encrypt = 'CAST_ecb_encrypt';
  fn_CAST_encrypt = 'CAST_encrypt';
  fn_CAST_decrypt = 'CAST_decrypt';
  fn_CAST_cbc_encrypt = 'CAST_cbc_encrypt';
  fn_CAST_cfb64_encrypt = 'CAST_cfb64_encrypt';
  fn_CAST_ofb64_encrypt = 'CAST_ofb64_encrypt';
  fn_idea_options = 'idea_options';
  fn_idea_ecb_encrypt = 'idea_ecb_encrypt';
  fn_idea_set_encrypt_key = 'idea_set_encrypt_key';
  fn_idea_set_decrypt_key = 'idea_set_decrypt_key';
  fn_idea_cbc_encrypt = 'idea_cbc_encrypt';
  fn_idea_cfb64_encrypt = 'idea_cfb64_encrypt';
  fn_idea_ofb64_encrypt = 'idea_ofb64_encrypt';
  fn_idea_encrypt = 'idea_encrypt';
  fn_MDC2_Init = 'MDC2_Init';
  fn_MDC2_Update = 'MDC2_Update';
  fn_MDC2_Final = 'MDC2_Final';
  fn_MDC2 = 'MDC2';
  fn_BN_value_one = 'BN_value_one';
  fn_BN_options = 'BN_options';
  fn_BN_CTX_new = 'BN_CTX_new';
  fn_BN_CTX_init = 'BN_CTX_init';
  fn_BN_CTX_free = 'BN_CTX_free';
  fn_BN_rand = 'BN_rand';
  fn_BN_num_bits = 'BN_num_bits';
  fn_BN_num_bits_word = 'BN_num_bits_word';
  fn_BN_new = 'BN_new';
  fn_BN_init = 'BN_init';
  fn_BN_clear_free = 'BN_clear_free';
  fn_BN_copy = 'BN_copy';
  fn_BN_bin2bn = 'BN_bin2bn';
  fn_BN_bn2bin = 'BN_bn2bin';
  fn_BN_mpi2bn = 'BN_mpi2bn';
  fn_BN_bn2mpi = 'BN_bn2mpi';
  fn_BN_sub = 'BN_sub';
  fn_BN_usub = 'BN_usub';
  fn_BN_uadd = 'BN_uadd';
  fn_BN_add = 'BN_add';
  fn_BN_mod = 'BN_mod';
  fn_BN_div = 'BN_div';
  fn_BN_mul = 'BN_mul';
  fn_BN_sqr = 'BN_sqr';
  fn_BN_mod_word = 'BN_mod_word';
  fn_BN_div_word = 'BN_div_word';
  fn_BN_mul_word = 'BN_mul_word';
  fn_BN_add_word = 'BN_add_word';
  fn_BN_sub_word = 'BN_sub_word';
  fn_BN_set_word = 'BN_set_word';
  fn_BN_get_word = 'BN_get_word';
  fn_BN_cmp = 'BN_cmp';
  fn_BN_free = 'BN_free';
  fn_BN_is_bit_set = 'BN_is_bit_set';
  fn_BN_lshift = 'BN_lshift';
  fn_BN_lshift1 = 'BN_lshift1';
  fn_BN_exp = 'BN_exp';
  fn_BN_mod_exp = 'BN_mod_exp';
  fn_BN_mod_exp_mont = 'BN_mod_exp_mont';
  fn_BN_mod_exp2_mont = 'BN_mod_exp2_mont';
  fn_BN_mod_exp_simple = 'BN_mod_exp_simple';
  fn_BN_mask_bits = 'BN_mask_bits';
  fn_BN_mod_mul = 'BN_mod_mul';
  fn_BN_print_fp = 'BN_print_fp';
  fn_BN_print = 'BN_print';
  fn_BN_reciprocal = 'BN_reciprocal';
  fn_BN_rshift = 'BN_rshift';
  fn_BN_rshift1 = 'BN_rshift1';
  fn_BN_clear = 'BN_clear';
  fn_bn_expand2 = 'bn_expand2';
  fn_BN_dup = 'BN_dup';
  fn_BN_ucmp = 'BN_ucmp';
  fn_BN_set_bit = 'BN_set_bit';
  fn_BN_clear_bit = 'BN_clear_bit';
  fn_BN_bn2hex = 'BN_bn2hex';
  fn_BN_bn2dec = 'BN_bn2dec';
  fn_BN_hex2bn = 'BN_hex2bn';
  fn_BN_dec2bn = 'BN_dec2bn';
  fn_BN_gcd = 'BN_gcd';
  fn_BN_mod_inverse = 'BN_mod_inverse';
  fn_BN_generate_prime = 'BN_generate_prime';
  fn_BN_is_prime = 'BN_is_prime';
  fn_ERR_load_BN_strings = 'ERR_load_BN_strings';
  fn_bn_mul_add_words = 'bn_mul_add_words';
  fn_bn_mul_words = 'bn_mul_words';
  fn_bn_sqr_words = 'bn_sqr_words';
  fn_bn_div_words = 'bn_div_words';
  fn_bn_add_words = 'bn_add_words';
  fn_bn_sub_words = 'bn_sub_words';
  fn_BN_MONT_CTX_new = 'BN_MONT_CTX_new';
  fn_BN_MONT_CTX_init = 'BN_MONT_CTX_init';
  fn_BN_mod_mul_montgomery = 'BN_mod_mul_montgomery';
  fn_BN_from_montgomery = 'BN_from_montgomery';
  fn_BN_MONT_CTX_free = 'BN_MONT_CTX_free';
  fn_BN_MONT_CTX_set = 'BN_MONT_CTX_set';
  fn_BN_MONT_CTX_copy = 'BN_MONT_CTX_copy';
  fn_BN_BLINDING_new = 'BN_BLINDING_new';
  fn_BN_BLINDING_free = 'BN_BLINDING_free';
  fn_BN_BLINDING_update = 'BN_BLINDING_update';
  fn_BN_BLINDING_convert = 'BN_BLINDING_convert';
  fn_BN_BLINDING_invert = 'BN_BLINDING_invert';
  fn_BN_set_params = 'BN_set_params';
  fn_BN_get_params = 'BN_get_params';
  fn_BN_RECP_CTX_init = 'BN_RECP_CTX_init';
  fn_BN_RECP_CTX_new = 'BN_RECP_CTX_new';
  fn_BN_RECP_CTX_free = 'BN_RECP_CTX_free';
  fn_BN_RECP_CTX_set = 'BN_RECP_CTX_set';
  fn_BN_mod_mul_reciprocal = 'BN_mod_mul_reciprocal';
  fn_BN_mod_exp_recp = 'BN_mod_exp_recp';
  fn_BN_div_recp = 'BN_div_recp';
  fn_RSA_new = 'RSA_new';
  fn_RSA_new_method = 'RSA_new_method';
  fn_RSA_size = 'RSA_size';
  fn_RSA_generate_key = 'RSA_generate_key';
  fn_RSA_check_key = 'RSA_check_key';
  fn_RSA_public_encrypt = 'RSA_public_encrypt';
  fn_RSA_private_encrypt = 'RSA_private_encrypt';
  fn_RSA_public_decrypt = 'RSA_public_decrypt';
  fn_RSA_private_decrypt = 'RSA_private_decrypt';
  fn_RSA_free = 'RSA_free';
  fn_RSA_flags = 'RSA_flags';
  fn_RSA_set_default_method = 'RSA_set_default_method';
  fn_RSA_get_default_method = 'RSA_get_default_method';
  fn_RSA_get_method = 'RSA_get_method';
  fn_RSA_set_method = 'RSA_set_method';
  fn_RSA_memory_lock = 'RSA_memory_lock';
  fn_RSA_PKCS1_SSLeay = 'RSA_PKCS1_SSLeay';
  fn_ERR_load_RSA_strings = 'ERR_load_RSA_strings';
  fn_d2i_RSAPublicKey = 'd2i_RSAPublicKey';
  fn_i2d_RSAPublicKey = 'i2d_RSAPublicKey';
  fn_d2i_RSAPrivateKey = 'd2i_RSAPrivateKey';
  fn_i2d_RSAPrivateKey = 'i2d_RSAPrivateKey';
  fn_RSA_print_fp = 'RSA_print_fp';
  fn_RSA_print = 'RSA_print';
  fn_i2d_Netscape_RSA = 'i2d_Netscape_RSA';
  fn_d2i_Netscape_RSA = 'd2i_Netscape_RSA';
  fn_d2i_Netscape_RSA_2 = 'd2i_Netscape_RSA_2';
  fn_RSA_sign = 'RSA_sign';
  fn_RSA_verify = 'RSA_verify';
  fn_RSA_sign_ASN1_OCTET_STRING = 'RSA_sign_ASN1_OCTET_STRING';
  fn_RSA_verify_ASN1_OCTET_STRING = 'RSA_verify_ASN1_OCTET_STRING';
  fn_RSA_blinding_on = 'RSA_blinding_on';
  fn_RSA_blinding_off = 'RSA_blinding_off';
  fn_RSA_padding_add_PKCS1_type_1 = 'RSA_padding_add_PKCS1_type_1';
  fn_RSA_padding_check_PKCS1_type_1 = 'RSA_padding_check_PKCS1_type_1';
  fn_RSA_padding_add_PKCS1_type_2 = 'RSA_padding_add_PKCS1_type_2';
  fn_RSA_padding_check_PKCS1_type_2 = 'RSA_padding_check_PKCS1_type_2';
  fn_RSA_padding_add_PKCS1_OAEP = 'RSA_padding_add_PKCS1_OAEP';
  fn_RSA_padding_check_PKCS1_OAEP = 'RSA_padding_check_PKCS1_OAEP';
  fn_RSA_padding_add_SSLv23 = 'RSA_padding_add_SSLv23';
  fn_RSA_padding_check_SSLv23 = 'RSA_padding_check_SSLv23';
  fn_RSA_padding_add_none = 'RSA_padding_add_none';
  fn_RSA_padding_check_none = 'RSA_padding_check_none';
  fn_RSA_get_ex_new_index = 'RSA_get_ex_new_index';
  fn_RSA_set_ex_data = 'RSA_set_ex_data';
  fn_RSA_get_ex_data = 'RSA_get_ex_data';
  fn_DH_new = 'DH_new';
  fn_DH_free = 'DH_free';
  fn_DH_size = 'DH_size';
  fn_DH_generate_parameters = 'DH_generate_parameters';
  fn_DH_check = 'DH_check';
  fn_DH_generate_key = 'DH_generate_key';
  fn_DH_compute_key = 'DH_compute_key';
  fn_d2i_DHparams = 'd2i_DHparams';
  fn_i2d_DHparams = 'i2d_DHparams';
  fn_DHparams_print_fp = 'DHparams_print_fp';
  fn_DHparams_print = 'DHparams_print';
  fn_ERR_load_DH_strings = 'ERR_load_DH_strings';
  fn_DSA_SIG_new = 'DSA_SIG_new';
  fn_DSA_SIG_free = 'DSA_SIG_free';
  fn_i2d_DSA_SIG = 'i2d_DSA_SIG';
  fn_d2i_DSA_SIG = 'd2i_DSA_SIG';
  fn_DSA_do_sign = 'DSA_do_sign';
  fn_DSA_do_verify = 'DSA_do_verify';
  fn_DSA_new = 'DSA_new';
  fn_DSA_size = 'DSA_size';
  fn_DSA_sign_setup = 'DSA_sign_setup';
  fn_DSA_sign = 'DSA_sign';
  fn_DSA_verify = 'DSA_verify';
  fn_DSA_free = 'DSA_free';
  fn_ERR_load_DSA_strings = 'ERR_load_DSA_strings';
  fn_d2i_DSAPublicKey = 'd2i_DSAPublicKey';
  fn_d2i_DSAPrivateKey = 'd2i_DSAPrivateKey';
  fn_d2i_DSAparams = 'd2i_DSAparams';
  fn_DSA_generate_parameters = 'DSA_generate_parameters';
  fn_DSA_generate_key = 'DSA_generate_key';
  fn_i2d_DSAPublicKey = 'i2d_DSAPublicKey';
  fn_i2d_DSAPrivateKey = 'i2d_DSAPrivateKey';
  fn_i2d_DSAparams = 'i2d_DSAparams';
  fn_DSAparams_print = 'DSAparams_print';
  fn_DSA_print = 'DSA_print';
  fn_DSAparams_print_fp = 'DSAparams_print_fp';
  fn_DSA_print_fp = 'DSA_print_fp';
  fn_DSA_is_prime = 'DSA_is_prime';
  fn_DSA_dup_DH = 'DSA_dup_DH';
  fn_sk_ASN1_TYPE_new = 'sk_ASN1_TYPE_new';
  fn_sk_ASN1_TYPE_new_null = 'sk_ASN1_TYPE_new_null';
  fn_sk_ASN1_TYPE_free = 'sk_ASN1_TYPE_free';
  fn_sk_ASN1_TYPE_num = 'sk_ASN1_TYPE_num';
  fn_sk_ASN1_TYPE_value = 'sk_ASN1_TYPE_value';
  fn_sk_ASN1_TYPE_set = 'sk_ASN1_TYPE_set';
  fn_sk_ASN1_TYPE_zero = 'sk_ASN1_TYPE_zero';
  fn_sk_ASN1_TYPE_push = 'sk_ASN1_TYPE_push';
  fn_sk_ASN1_TYPE_unshift = 'sk_ASN1_TYPE_unshift';
  fn_sk_ASN1_TYPE_find = 'sk_ASN1_TYPE_find';
  fn_sk_ASN1_TYPE_delete = 'sk_ASN1_TYPE_delete';
  fn_sk_ASN1_TYPE_delete_ptr = 'sk_ASN1_TYPE_delete_ptr';
  fn_sk_ASN1_TYPE_insert = 'sk_ASN1_TYPE_insert';
  fn_sk_ASN1_TYPE_dup = 'sk_ASN1_TYPE_dup';
  fn_sk_ASN1_TYPE_pop_free = 'sk_ASN1_TYPE_pop_free';
  fn_sk_ASN1_TYPE_shift = 'sk_ASN1_TYPE_shift';
  fn_sk_ASN1_TYPE_pop = 'sk_ASN1_TYPE_pop';
  fn_sk_ASN1_TYPE_sort = 'sk_ASN1_TYPE_sort';
  fn_i2d_ASN1_SET_OF_ASN1_TYPE = 'i2d_ASN1_SET_OF_ASN1_TYPE';
  fn_d2i_ASN1_SET_OF_ASN1_TYPE = 'd2i_ASN1_SET_OF_ASN1_TYPE';
  fn_ASN1_TYPE_new = 'ASN1_TYPE_new';
  fn_ASN1_TYPE_free = 'ASN1_TYPE_free';
  fn_i2d_ASN1_TYPE = 'i2d_ASN1_TYPE';
  fn_d2i_ASN1_TYPE = 'd2i_ASN1_TYPE';
  fn_ASN1_TYPE_get = 'ASN1_TYPE_get';
  fn_ASN1_TYPE_set = 'ASN1_TYPE_set';
  fn_ASN1_OBJECT_new = 'ASN1_OBJECT_new';
  fn_ASN1_OBJECT_free = 'ASN1_OBJECT_free';
  fn_i2d_ASN1_OBJECT = 'i2d_ASN1_OBJECT';
  fn_d2i_ASN1_OBJECT = 'd2i_ASN1_OBJECT';
  fn_sk_ASN1_OBJECT_new = 'sk_ASN1_OBJECT_new';
  fn_sk_ASN1_OBJECT_new_null = 'sk_ASN1_OBJECT_new_null';
  fn_sk_ASN1_OBJECT_free = 'sk_ASN1_OBJECT_free';
  fn_sk_ASN1_OBJECT_num = 'sk_ASN1_OBJECT_num';
  fn_sk_ASN1_OBJECT_value = 'sk_ASN1_OBJECT_value';
  fn_sk_ASN1_OBJECT_set = 'sk_ASN1_OBJECT_set';
  fn_sk_ASN1_OBJECT_zero = 'sk_ASN1_OBJECT_zero';
  fn_sk_ASN1_OBJECT_push = 'sk_ASN1_OBJECT_push';
  fn_sk_ASN1_OBJECT_unshift = 'sk_ASN1_OBJECT_unshift';
  fn_sk_ASN1_OBJECT_find = 'sk_ASN1_OBJECT_find';
  fn_sk_ASN1_OBJECT_delete = 'sk_ASN1_OBJECT_delete';
  fn_sk_ASN1_OBJECT_delete_ptr = 'sk_ASN1_OBJECT_delete_ptr';
  fn_sk_ASN1_OBJECT_insert = 'sk_ASN1_OBJECT_insert';
  fn_sk_ASN1_OBJECT_dup = 'sk_ASN1_OBJECT_dup';
  fn_sk_ASN1_OBJECT_pop_free = 'sk_ASN1_OBJECT_pop_free';
  fn_sk_ASN1_OBJECT_shift = 'sk_ASN1_OBJECT_shift';
  fn_sk_ASN1_OBJECT_pop = 'sk_ASN1_OBJECT_pop';
  fn_sk_ASN1_OBJECT_sort = 'sk_ASN1_OBJECT_sort';
  fn_i2d_ASN1_SET_OF_ASN1_OBJECT = 'i2d_ASN1_SET_OF_ASN1_OBJECT';
  fn_d2i_ASN1_SET_OF_ASN1_OBJECT = 'd2i_ASN1_SET_OF_ASN1_OBJECT';
  fn_ASN1_STRING_new = 'ASN1_STRING_new';
  fn_ASN1_STRING_free = 'ASN1_STRING_free';
  fn_ASN1_STRING_dup = 'ASN1_STRING_dup';
  fn_ASN1_STRING_type_new = 'ASN1_STRING_type_new';
  fn_ASN1_STRING_cmp = 'ASN1_STRING_cmp';
  fn_ASN1_STRING_set = 'ASN1_STRING_set';
  fn_i2d_ASN1_BIT_STRING = 'i2d_ASN1_BIT_STRING';
  fn_d2i_ASN1_BIT_STRING = 'd2i_ASN1_BIT_STRING';
  fn_ASN1_BIT_STRING_set_bit = 'ASN1_BIT_STRING_set_bit';
  fn_ASN1_BIT_STRING_get_bit = 'ASN1_BIT_STRING_get_bit';
  fn_i2d_ASN1_BOOLEAN = 'i2d_ASN1_BOOLEAN';
  fn_d2i_ASN1_BOOLEAN = 'd2i_ASN1_BOOLEAN';
  fn_i2d_ASN1_INTEGER = 'i2d_ASN1_INTEGER';
  fn_d2i_ASN1_INTEGER = 'd2i_ASN1_INTEGER';
  fn_d2i_ASN1_UINTEGER = 'd2i_ASN1_UINTEGER';
  fn_i2d_ASN1_ENUMERATED = 'i2d_ASN1_ENUMERATED';
  fn_d2i_ASN1_ENUMERATED = 'd2i_ASN1_ENUMERATED';
  fn_ASN1_UTCTIME_check = 'ASN1_UTCTIME_check';
  fn_ASN1_UTCTIME_set = 'ASN1_UTCTIME_set';
  fn_ASN1_UTCTIME_set_string = 'ASN1_UTCTIME_set_string';
  fn_ASN1_GENERALIZEDTIME_check = 'ASN1_GENERALIZEDTIME_check';
  fn_ASN1_GENERALIZEDTIME_set = 'ASN1_GENERALIZEDTIME_set';
  fn_ASN1_GENERALIZEDTIME_set_string = 'ASN1_GENERALIZEDTIME_set_string';
  fn_i2d_ASN1_OCTET_STRING = 'i2d_ASN1_OCTET_STRING';
  fn_d2i_ASN1_OCTET_STRING = 'd2i_ASN1_OCTET_STRING';
  fn_i2d_ASN1_VISIBLESTRING = 'i2d_ASN1_VISIBLESTRING';
  fn_d2i_ASN1_VISIBLESTRING = 'd2i_ASN1_VISIBLESTRING';
  fn_i2d_ASN1_UTF8STRING = 'i2d_ASN1_UTF8STRING';
  fn_d2i_ASN1_UTF8STRING = 'd2i_ASN1_UTF8STRING';
  fn_i2d_ASN1_BMPSTRING = 'i2d_ASN1_BMPSTRING';
  fn_d2i_ASN1_BMPSTRING = 'd2i_ASN1_BMPSTRING';
  fn_i2d_ASN1_PRINTABLE = 'i2d_ASN1_PRINTABLE';
  fn_d2i_ASN1_PRINTABLE = 'd2i_ASN1_PRINTABLE';
  fn_d2i_ASN1_PRINTABLESTRING = 'd2i_ASN1_PRINTABLESTRING';
  fn_i2d_DIRECTORYSTRING = 'i2d_DIRECTORYSTRING';
  fn_d2i_DIRECTORYSTRING = 'd2i_DIRECTORYSTRING';
  fn_i2d_DISPLAYTEXT = 'i2d_DISPLAYTEXT';
  fn_d2i_DISPLAYTEXT = 'd2i_DISPLAYTEXT';
  fn_d2i_ASN1_T61STRING = 'd2i_ASN1_T61STRING';
  fn_i2d_ASN1_IA5STRING = 'i2d_ASN1_IA5STRING';
  fn_d2i_ASN1_IA5STRING = 'd2i_ASN1_IA5STRING';
  fn_i2d_ASN1_UTCTIME = 'i2d_ASN1_UTCTIME';
  fn_d2i_ASN1_UTCTIME = 'd2i_ASN1_UTCTIME';
  fn_i2d_ASN1_GENERALIZEDTIME = 'i2d_ASN1_GENERALIZEDTIME';
  fn_d2i_ASN1_GENERALIZEDTIME = 'd2i_ASN1_GENERALIZEDTIME';
  fn_i2d_ASN1_TIME = 'i2d_ASN1_TIME';
  fn_d2i_ASN1_TIME = 'd2i_ASN1_TIME';
  fn_ASN1_TIME_set = 'ASN1_TIME_set';
  fn_i2d_ASN1_SET = 'i2d_ASN1_SET';
  fn_d2i_ASN1_SET = 'd2i_ASN1_SET';
  fn_i2a_ASN1_INTEGER = 'i2a_ASN1_INTEGER';
  fn_a2i_ASN1_INTEGER = 'a2i_ASN1_INTEGER';
  fn_i2a_ASN1_ENUMERATED = 'i2a_ASN1_ENUMERATED';
  fn_a2i_ASN1_ENUMERATED = 'a2i_ASN1_ENUMERATED';
  fn_i2a_ASN1_OBJECT = 'i2a_ASN1_OBJECT';
  fn_a2i_ASN1_STRING = 'a2i_ASN1_STRING';
  fn_i2a_ASN1_STRING = 'i2a_ASN1_STRING';
  fn_i2t_ASN1_OBJECT = 'i2t_ASN1_OBJECT';
  fn_a2d_ASN1_OBJECT = 'a2d_ASN1_OBJECT';
  fn_ASN1_OBJECT_create = 'ASN1_OBJECT_create';
  fn_ASN1_INTEGER_set = 'ASN1_INTEGER_set';
  fn_ASN1_INTEGER_get = 'ASN1_INTEGER_get';
  fn_BN_to_ASN1_INTEGER = 'BN_to_ASN1_INTEGER';
  fn_ASN1_INTEGER_to_BN = 'ASN1_INTEGER_to_BN';
  fn_ASN1_ENUMERATED_set = 'ASN1_ENUMERATED_set';
  fn_ASN1_ENUMERATED_get = 'ASN1_ENUMERATED_get';
  fn_BN_to_ASN1_ENUMERATED = 'BN_to_ASN1_ENUMERATED';
  fn_ASN1_ENUMERATED_to_BN = 'ASN1_ENUMERATED_to_BN';
  fn_ASN1_PRINTABLE_type = 'ASN1_PRINTABLE_type';
  fn_i2d_ASN1_bytes = 'i2d_ASN1_bytes';
  fn_d2i_ASN1_bytes = 'd2i_ASN1_bytes';
  fn_d2i_ASN1_type_bytes = 'd2i_ASN1_type_bytes';
  fn_asn1_Finish = 'asn1_Finish';
  fn_ASN1_get_object = 'ASN1_get_object';
  fn_ASN1_check_infinite_end = 'ASN1_check_infinite_end';
  fn_ASN1_put_object = 'ASN1_put_object';
  fn_ASN1_object_size = 'ASN1_object_size';
  fn_ASN1_dup = 'ASN1_dup';
  fn_ASN1_d2i_fp = 'ASN1_d2i_fp';
  fn_ASN1_i2d_fp = 'ASN1_i2d_fp';
  fn_ASN1_d2i_bio = 'ASN1_d2i_bio';
  fn_ASN1_i2d_bio = 'ASN1_i2d_bio';
  fn_ASN1_UTCTIME_print = 'ASN1_UTCTIME_print';
  fn_ASN1_GENERALIZEDTIME_print = 'ASN1_GENERALIZEDTIME_print';
  fn_ASN1_TIME_print = 'ASN1_TIME_print';
  fn_ASN1_STRING_print = 'ASN1_STRING_print';
  fn_ASN1_parse = 'ASN1_parse';
  fn_i2d_ASN1_HEADER = 'i2d_ASN1_HEADER';
  fn_d2i_ASN1_HEADER = 'd2i_ASN1_HEADER';
  fn_ASN1_HEADER_new = 'ASN1_HEADER_new';
  fn_ASN1_HEADER_free = 'ASN1_HEADER_free';
  fn_ASN1_UNIVERSALSTRING_to_string = 'ASN1_UNIVERSALSTRING_to_string';
  fn_ERR_load_ASN1_strings = 'ERR_load_ASN1_strings';
  fn_X509_asn1_meth = 'X509_asn1_meth';
  fn_RSAPrivateKey_asn1_meth = 'RSAPrivateKey_asn1_meth';
  fn_ASN1_IA5STRING_asn1_meth = 'ASN1_IA5STRING_asn1_meth';
  fn_ASN1_BIT_STRING_asn1_meth = 'ASN1_BIT_STRING_asn1_meth';
  fn_ASN1_TYPE_set_octetstring = 'ASN1_TYPE_set_octetstring';
  fn_ASN1_TYPE_get_octetstring = 'ASN1_TYPE_get_octetstring';
  fn_ASN1_TYPE_set_int_octetstring = 'ASN1_TYPE_set_int_octetstring';
  fn_ASN1_TYPE_get_int_octetstring = 'ASN1_TYPE_get_int_octetstring';
  fn_ASN1_seq_unpack = 'ASN1_seq_unpack';
  fn_ASN1_seq_pack = 'ASN1_seq_pack';
  fn_ASN1_unpack_string = 'ASN1_unpack_string';
  fn_ASN1_pack_string = 'ASN1_pack_string';
  fn_OBJ_NAME_init = 'OBJ_NAME_init';
  fn_OBJ_NAME_new_index = 'OBJ_NAME_new_index';
  fn_OBJ_NAME_get = 'OBJ_NAME_get';
  fn_OBJ_NAME_add = 'OBJ_NAME_add';
  fn_OBJ_NAME_remove = 'OBJ_NAME_remove';
  fn_OBJ_NAME_cleanup = 'OBJ_NAME_cleanup';
  fn_OBJ_dup = 'OBJ_dup';
  fn_OBJ_nid2obj = 'OBJ_nid2obj';
  fn_OBJ_nid2ln = 'OBJ_nid2ln';
  fn_OBJ_nid2sn = 'OBJ_nid2sn';
  fn_OBJ_obj2nid = 'OBJ_obj2nid';
  fn_OBJ_txt2obj = 'OBJ_txt2obj';
  fn_OBJ_obj2txt = 'OBJ_obj2txt';
  fn_OBJ_txt2nid = 'OBJ_txt2nid';
  fn_OBJ_ln2nid = 'OBJ_ln2nid';
  fn_OBJ_sn2nid = 'OBJ_sn2nid';
  fn_OBJ_cmp = 'OBJ_cmp';
  fn_OBJ_bsearch = 'OBJ_bsearch';
  fn_ERR_load_OBJ_strings = 'ERR_load_OBJ_strings';
  fn_OBJ_new_nid = 'OBJ_new_nid';
  fn_OBJ_add_object = 'OBJ_add_object';
  fn_OBJ_create = 'OBJ_create';
  fn_OBJ_cleanup = 'OBJ_cleanup';
  fn_OBJ_create_objects = 'OBJ_create_objects';
  fn_EVP_MD_CTX_copy = 'EVP_MD_CTX_copy';
  fn_EVP_DigestInit = 'EVP_DigestInit';
  fn_EVP_DigestUpdate = 'EVP_DigestUpdate';
  fn_EVP_DigestFinal = 'EVP_DigestFinal';
  fn_EVP_read_pw_string = 'EVP_read_pw_string';
  fn_EVP_set_pw_prompt = 'EVP_set_pw_prompt';
  fn_EVP_get_pw_prompt = 'EVP_get_pw_prompt';
  fn_EVP_BytesToKey = 'EVP_BytesToKey';
  fn_EVP_EncryptInit = 'EVP_EncryptInit';
  fn_EVP_EncryptUpdate = 'EVP_EncryptUpdate';
  fn_EVP_EncryptFinal = 'EVP_EncryptFinal';
  fn_EVP_DecryptInit = 'EVP_DecryptInit';
  fn_EVP_DecryptUpdate = 'EVP_DecryptUpdate';
  fn_EVP_DecryptFinal = 'EVP_DecryptFinal';
  fn_EVP_CipherInit = 'EVP_CipherInit';
  fn_EVP_CipherUpdate = 'EVP_CipherUpdate';
  fn_EVP_CipherFinal = 'EVP_CipherFinal';
  fn_EVP_SignFinal = 'EVP_SignFinal';
  fn_EVP_VerifyFinal = 'EVP_VerifyFinal';
  fn_EVP_OpenInit = 'EVP_OpenInit';
  fn_EVP_OpenFinal = 'EVP_OpenFinal';
  fn_EVP_SealInit = 'EVP_SealInit';
  fn_EVP_SealFinal = 'EVP_SealFinal';
  fn_EVP_EncodeInit = 'EVP_EncodeInit';
  fn_EVP_EncodeUpdate = 'EVP_EncodeUpdate';
  fn_EVP_EncodeFinal = 'EVP_EncodeFinal';
  fn_EVP_EncodeBlock = 'EVP_EncodeBlock';
  fn_EVP_DecodeInit = 'EVP_DecodeInit';
  fn_EVP_DecodeUpdate = 'EVP_DecodeUpdate';
  fn_EVP_DecodeFinal = 'EVP_DecodeFinal';
  fn_EVP_DecodeBlock = 'EVP_DecodeBlock';
  fn_ERR_load_EVP_strings = 'ERR_load_EVP_strings';
  fn_EVP_CIPHER_CTX_init = 'EVP_CIPHER_CTX_init';
  fn_EVP_CIPHER_CTX_cleanup = 'EVP_CIPHER_CTX_cleanup';
  fn_BIO_f_md = 'BIO_f_md';
  fn_BIO_f_base64 = 'BIO_f_base64';
  fn_BIO_f_cipher = 'BIO_f_cipher';
  fn_BIO_f_reliable = 'BIO_f_reliable';
  fn_BIO_set_cipher = 'BIO_set_cipher';
  fn_EVP_md_null = 'EVP_md_null';
  fn_EVP_md2 = 'EVP_md2';
  fn_EVP_md5 = 'EVP_md5';
  fn_EVP_sha = 'EVP_sha';
  fn_EVP_sha1 = 'EVP_sha1';
  fn_EVP_dss = 'EVP_dss';
  fn_EVP_dss1 = 'EVP_dss1';
  fn_EVP_mdc2 = 'EVP_mdc2';
  fn_EVP_ripemd160 = 'EVP_ripemd160';
  fn_EVP_enc_null = 'EVP_enc_null';
  fn_EVP_des_ecb = 'EVP_des_ecb';
  fn_EVP_des_ede = 'EVP_des_ede';
  fn_EVP_des_ede3 = 'EVP_des_ede3';
  fn_EVP_des_cfb = 'EVP_des_cfb';
  fn_EVP_des_ede_cfb = 'EVP_des_ede_cfb';
  fn_EVP_des_ede3_cfb = 'EVP_des_ede3_cfb';
  fn_EVP_des_ofb = 'EVP_des_ofb';
  fn_EVP_des_ede_ofb = 'EVP_des_ede_ofb';
  fn_EVP_des_ede3_ofb = 'EVP_des_ede3_ofb';
  fn_EVP_des_cbc = 'EVP_des_cbc';
  fn_EVP_des_ede_cbc = 'EVP_des_ede_cbc';
  fn_EVP_des_ede3_cbc = 'EVP_des_ede3_cbc';
  fn_EVP_desx_cbc = 'EVP_desx_cbc';
  fn_EVP_rc4 = 'EVP_rc4';
  fn_EVP_rc4_40 = 'EVP_rc4_40';
  fn_EVP_idea_ecb = 'EVP_idea_ecb';
  fn_EVP_idea_cfb = 'EVP_idea_cfb';
  fn_EVP_idea_ofb = 'EVP_idea_ofb';
  fn_EVP_idea_cbc = 'EVP_idea_cbc';
  fn_EVP_rc2_ecb = 'EVP_rc2_ecb';
  fn_EVP_rc2_cbc = 'EVP_rc2_cbc';
  fn_EVP_rc2_40_cbc = 'EVP_rc2_40_cbc';
  fn_EVP_rc2_64_cbc = 'EVP_rc2_64_cbc';
  fn_EVP_rc2_cfb = 'EVP_rc2_cfb';
  fn_EVP_rc2_ofb = 'EVP_rc2_ofb';
  fn_EVP_bf_ecb = 'EVP_bf_ecb';
  fn_EVP_bf_cbc = 'EVP_bf_cbc';
  fn_EVP_bf_cfb = 'EVP_bf_cfb';
  fn_EVP_bf_ofb = 'EVP_bf_ofb';
  fn_EVP_cast5_ecb = 'EVP_cast5_ecb';
  fn_EVP_cast5_cbc = 'EVP_cast5_cbc';
  fn_EVP_cast5_cfb = 'EVP_cast5_cfb';
  fn_EVP_cast5_ofb = 'EVP_cast5_ofb';
  fn_EVP_rc5_32_12_16_cbc = 'EVP_rc5_32_12_16_cbc';
  fn_EVP_rc5_32_12_16_ecb = 'EVP_rc5_32_12_16_ecb';
  fn_EVP_rc5_32_12_16_cfb = 'EVP_rc5_32_12_16_cfb';
  fn_EVP_rc5_32_12_16_ofb = 'EVP_rc5_32_12_16_ofb';
  fn_SSLeay_add_all_algorithms = 'SSLeay_add_all_algorithms';
  fn_SSLeay_add_all_ciphers = 'SSLeay_add_all_ciphers';
  fn_SSLeay_add_all_digests = 'SSLeay_add_all_digests';
  fn_EVP_add_cipher = 'EVP_add_cipher';
  fn_EVP_add_digest = 'EVP_add_digest';
  fn_EVP_get_cipherbyname = 'EVP_get_cipherbyname';
  fn_EVP_get_digestbyname = 'EVP_get_digestbyname';
  fn_EVP_cleanup = 'EVP_cleanup';
  fn_EVP_PKEY_decrypt = 'EVP_PKEY_decrypt';
  fn_EVP_PKEY_encrypt = 'EVP_PKEY_encrypt';
  fn_EVP_PKEY_type = 'EVP_PKEY_type';
  fn_EVP_PKEY_bits = 'EVP_PKEY_bits';
  fn_EVP_PKEY_size = 'EVP_PKEY_size';
  fn_EVP_PKEY_assign = 'EVP_PKEY_assign';
  fn_EVP_PKEY_new = 'EVP_PKEY_new';
  fn_EVP_PKEY_free = 'EVP_PKEY_free';
  fn_d2i_PublicKey = 'd2i_PublicKey';
  fn_i2d_PublicKey = 'i2d_PublicKey';
  fn_d2i_PrivateKey = 'd2i_PrivateKey';
  fn_i2d_PrivateKey = 'i2d_PrivateKey';
  fn_EVP_PKEY_copy_parameters = 'EVP_PKEY_copy_parameters';
  fn_EVP_PKEY_missing_parameters = 'EVP_PKEY_missing_parameters';
  fn_EVP_PKEY_save_parameters = 'EVP_PKEY_save_parameters';
  fn_EVP_PKEY_cmp_parameters = 'EVP_PKEY_cmp_parameters';
  fn_EVP_CIPHER_type = 'EVP_CIPHER_type';
  fn_EVP_CIPHER_param_to_asn1 = 'EVP_CIPHER_param_to_asn1';
  fn_EVP_CIPHER_asn1_to_param = 'EVP_CIPHER_asn1_to_param';
  fn_EVP_CIPHER_set_asn1_iv = 'EVP_CIPHER_set_asn1_iv';
  fn_EVP_CIPHER_get_asn1_iv = 'EVP_CIPHER_get_asn1_iv';
  fn_PKCS5_PBE_keyivgen = 'PKCS5_PBE_keyivgen';
  fn_PKCS5_PBKDF2_HMAC_SHA1 = 'PKCS5_PBKDF2_HMAC_SHA1';
  fn_PKCS5_v2_PBE_keyivgen = 'PKCS5_v2_PBE_keyivgen';
  fn_PKCS5_PBE_add = 'PKCS5_PBE_add';
  fn_EVP_PBE_CipherInit = 'EVP_PBE_CipherInit';
  fn_EVP_PBE_alg_add = 'EVP_PBE_alg_add';
  fn_EVP_PBE_cleanup = 'EVP_PBE_cleanup';
  fn_sk_X509_ALGOR_new = 'sk_X509_ALGOR_new';
  fn_sk_X509_ALGOR_new_null = 'sk_X509_ALGOR_new_null';
  fn_sk_X509_ALGOR_free = 'sk_X509_ALGOR_free';
  fn_sk_X509_ALGOR_num = 'sk_X509_ALGOR_num';
  fn_sk_X509_ALGOR_value = 'sk_X509_ALGOR_value';
  fn_sk_X509_ALGOR_set = 'sk_X509_ALGOR_set';
  fn_sk_X509_ALGOR_zero = 'sk_X509_ALGOR_zero';
  fn_sk_X509_ALGOR_push = 'sk_X509_ALGOR_push';
  fn_sk_X509_ALGOR_unshift = 'sk_X509_ALGOR_unshift';
  fn_sk_X509_ALGOR_find = 'sk_X509_ALGOR_find';
  fn_sk_X509_ALGOR_delete = 'sk_X509_ALGOR_delete';
  fn_sk_X509_ALGOR_delete_ptr = 'sk_X509_ALGOR_delete_ptr';
  fn_sk_X509_ALGOR_insert = 'sk_X509_ALGOR_insert';
  fn_sk_X509_ALGOR_dup = 'sk_X509_ALGOR_dup';
  fn_sk_X509_ALGOR_pop_free = 'sk_X509_ALGOR_pop_free';
  fn_sk_X509_ALGOR_shift = 'sk_X509_ALGOR_shift';
  fn_sk_X509_ALGOR_pop = 'sk_X509_ALGOR_pop';
  fn_sk_X509_ALGOR_sort = 'sk_X509_ALGOR_sort';
  fn_i2d_ASN1_SET_OF_X509_ALGOR = 'i2d_ASN1_SET_OF_X509_ALGOR';
  fn_d2i_ASN1_SET_OF_X509_ALGOR = 'd2i_ASN1_SET_OF_X509_ALGOR';
  fn_sk_X509_NAME_ENTRY_new = 'sk_X509_NAME_ENTRY_new';
  fn_sk_X509_NAME_ENTRY_new_null = 'sk_X509_NAME_ENTRY_new_null';
  fn_sk_X509_NAME_ENTRY_free = 'sk_X509_NAME_ENTRY_free';
  fn_sk_X509_NAME_ENTRY_num = 'sk_X509_NAME_ENTRY_num';
  fn_sk_X509_NAME_ENTRY_value = 'sk_X509_NAME_ENTRY_value';
  fn_sk_X509_NAME_ENTRY_set = 'sk_X509_NAME_ENTRY_set';
  fn_sk_X509_NAME_ENTRY_zero = 'sk_X509_NAME_ENTRY_zero';
  fn_sk_X509_NAME_ENTRY_push = 'sk_X509_NAME_ENTRY_push';
  fn_sk_X509_NAME_ENTRY_unshift = 'sk_X509_NAME_ENTRY_unshift';
  fn_sk_X509_NAME_ENTRY_find = 'sk_X509_NAME_ENTRY_find';
  fn_sk_X509_NAME_ENTRY_delete = 'sk_X509_NAME_ENTRY_delete';
  fn_sk_X509_NAME_ENTRY_delete_ptr = 'sk_X509_NAME_ENTRY_delete_ptr';
  fn_sk_X509_NAME_ENTRY_insert = 'sk_X509_NAME_ENTRY_insert';
  fn_sk_X509_NAME_ENTRY_dup = 'sk_X509_NAME_ENTRY_dup';
  fn_sk_X509_NAME_ENTRY_pop_free = 'sk_X509_NAME_ENTRY_pop_free';
  fn_sk_X509_NAME_ENTRY_shift = 'sk_X509_NAME_ENTRY_shift';
  fn_sk_X509_NAME_ENTRY_pop = 'sk_X509_NAME_ENTRY_pop';
  fn_sk_X509_NAME_ENTRY_sort = 'sk_X509_NAME_ENTRY_sort';
  fn_i2d_ASN1_SET_OF_X509_NAME_ENTRY = 'i2d_ASN1_SET_OF_X509_NAME_ENTRY';
  fn_d2i_ASN1_SET_OF_X509_NAME_ENTRY = 'd2i_ASN1_SET_OF_X509_NAME_ENTRY';
  fn_sk_X509_NAME_new = 'sk_X509_NAME_new';
  fn_sk_X509_NAME_new_null = 'sk_X509_NAME_new_null';
  fn_sk_X509_NAME_free = 'sk_X509_NAME_free';
  fn_sk_X509_NAME_num = 'sk_X509_NAME_num';
  fn_sk_X509_NAME_value = 'sk_X509_NAME_value';
  fn_sk_X509_NAME_set = 'sk_X509_NAME_set';
  fn_sk_X509_NAME_zero = 'sk_X509_NAME_zero';
  fn_sk_X509_NAME_push = 'sk_X509_NAME_push';
  fn_sk_X509_NAME_unshift = 'sk_X509_NAME_unshift';
  fn_sk_X509_NAME_find = 'sk_X509_NAME_find';
  fn_sk_X509_NAME_delete = 'sk_X509_NAME_delete';
  fn_sk_X509_NAME_delete_ptr = 'sk_X509_NAME_delete_ptr';
  fn_sk_X509_NAME_insert = 'sk_X509_NAME_insert';
  fn_sk_X509_NAME_dup = 'sk_X509_NAME_dup';
  fn_sk_X509_NAME_pop_free = 'sk_X509_NAME_pop_free';
  fn_sk_X509_NAME_shift = 'sk_X509_NAME_shift';
  fn_sk_X509_NAME_pop = 'sk_X509_NAME_pop';
  fn_sk_X509_NAME_sort = 'sk_X509_NAME_sort';
  fn_sk_X509_EXTENSION_new = 'sk_X509_EXTENSION_new';
  fn_sk_X509_EXTENSION_new_null = 'sk_X509_EXTENSION_new_null';
  fn_sk_X509_EXTENSION_free = 'sk_X509_EXTENSION_free';
  fn_sk_X509_EXTENSION_num = 'sk_X509_EXTENSION_num';
  fn_sk_X509_EXTENSION_value = 'sk_X509_EXTENSION_value';
  fn_sk_X509_EXTENSION_set = 'sk_X509_EXTENSION_set';
  fn_sk_X509_EXTENSION_zero = 'sk_X509_EXTENSION_zero';
  fn_sk_X509_EXTENSION_push = 'sk_X509_EXTENSION_push';
  fn_sk_X509_EXTENSION_unshift = 'sk_X509_EXTENSION_unshift';
  fn_sk_X509_EXTENSION_find = 'sk_X509_EXTENSION_find';
  fn_sk_X509_EXTENSION_delete = 'sk_X509_EXTENSION_delete';
  fn_sk_X509_EXTENSION_delete_ptr = 'sk_X509_EXTENSION_delete_ptr';
  fn_sk_X509_EXTENSION_insert = 'sk_X509_EXTENSION_insert';
  fn_sk_X509_EXTENSION_dup = 'sk_X509_EXTENSION_dup';
  fn_sk_X509_EXTENSION_pop_free = 'sk_X509_EXTENSION_pop_free';
  fn_sk_X509_EXTENSION_shift = 'sk_X509_EXTENSION_shift';
  fn_sk_X509_EXTENSION_pop = 'sk_X509_EXTENSION_pop';
  fn_sk_X509_EXTENSION_sort = 'sk_X509_EXTENSION_sort';
  fn_i2d_ASN1_SET_OF_X509_EXTENSION = 'i2d_ASN1_SET_OF_X509_EXTENSION';
  fn_d2i_ASN1_SET_OF_X509_EXTENSION = 'd2i_ASN1_SET_OF_X509_EXTENSION';
  fn_sk_X509_ATTRIBUTE_new = 'sk_X509_ATTRIBUTE_new';
  fn_sk_X509_ATTRIBUTE_new_null = 'sk_X509_ATTRIBUTE_new_null';
  fn_sk_X509_ATTRIBUTE_free = 'sk_X509_ATTRIBUTE_free';
  fn_sk_X509_ATTRIBUTE_num = 'sk_X509_ATTRIBUTE_num';
  fn_sk_X509_ATTRIBUTE_value = 'sk_X509_ATTRIBUTE_value';
  fn_sk_X509_ATTRIBUTE_set = 'sk_X509_ATTRIBUTE_set';
  fn_sk_X509_ATTRIBUTE_zero = 'sk_X509_ATTRIBUTE_zero';
  fn_sk_X509_ATTRIBUTE_push = 'sk_X509_ATTRIBUTE_push';
  fn_sk_X509_ATTRIBUTE_unshift = 'sk_X509_ATTRIBUTE_unshift';
  fn_sk_X509_ATTRIBUTE_find = 'sk_X509_ATTRIBUTE_find';
  fn_sk_X509_ATTRIBUTE_delete = 'sk_X509_ATTRIBUTE_delete';
  fn_sk_X509_ATTRIBUTE_delete_ptr = 'sk_X509_ATTRIBUTE_delete_ptr';
  fn_sk_X509_ATTRIBUTE_insert = 'sk_X509_ATTRIBUTE_insert';
  fn_sk_X509_ATTRIBUTE_dup = 'sk_X509_ATTRIBUTE_dup';
  fn_sk_X509_ATTRIBUTE_pop_free = 'sk_X509_ATTRIBUTE_pop_free';
  fn_sk_X509_ATTRIBUTE_shift = 'sk_X509_ATTRIBUTE_shift';
  fn_sk_X509_ATTRIBUTE_pop = 'sk_X509_ATTRIBUTE_pop';
  fn_sk_X509_ATTRIBUTE_sort = 'sk_X509_ATTRIBUTE_sort';
  fn_i2d_ASN1_SET_OF_X509_ATTRIBUTE = 'i2d_ASN1_SET_OF_X509_ATTRIBUTE';
  fn_d2i_ASN1_SET_OF_X509_ATTRIBUTE = 'd2i_ASN1_SET_OF_X509_ATTRIBUTE';
  fn_sk_X509_new = 'sk_X509_new';
  fn_sk_X509_new_null = 'sk_X509_new_null';
  fn_sk_X509_free = 'sk_X509_free';
  fn_sk_X509_num = 'sk_X509_num';
  fn_sk_X509_value = 'sk_X509_value';
  fn_sk_X509_set = 'sk_X509_set';
  fn_sk_X509_zero = 'sk_X509_zero';
  fn_sk_X509_push = 'sk_X509_push';
  fn_sk_X509_unshift = 'sk_X509_unshift';
  fn_sk_X509_find = 'sk_X509_find';
  fn_sk_X509_delete = 'sk_X509_delete';
  fn_sk_X509_delete_ptr = 'sk_X509_delete_ptr';
  fn_sk_X509_insert = 'sk_X509_insert';
  fn_sk_X509_dup = 'sk_X509_dup';
  fn_sk_X509_pop_free = 'sk_X509_pop_free';
  fn_sk_X509_shift = 'sk_X509_shift';
  fn_sk_X509_pop = 'sk_X509_pop';
  fn_sk_X509_sort = 'sk_X509_sort';
  fn_i2d_ASN1_SET_OF_X509 = 'i2d_ASN1_SET_OF_X509';
  fn_d2i_ASN1_SET_OF_X509 = 'd2i_ASN1_SET_OF_X509';
  fn_sk_X509_REVOKED_new = 'sk_X509_REVOKED_new';
  fn_sk_X509_REVOKED_new_null = 'sk_X509_REVOKED_new_null';
  fn_sk_X509_REVOKED_free = 'sk_X509_REVOKED_free';
  fn_sk_X509_REVOKED_num = 'sk_X509_REVOKED_num';
  fn_sk_X509_REVOKED_value = 'sk_X509_REVOKED_value';
  fn_sk_X509_REVOKED_set = 'sk_X509_REVOKED_set';
  fn_sk_X509_REVOKED_zero = 'sk_X509_REVOKED_zero';
  fn_sk_X509_REVOKED_push = 'sk_X509_REVOKED_push';
  fn_sk_X509_REVOKED_unshift = 'sk_X509_REVOKED_unshift';
  fn_sk_X509_REVOKED_find = 'sk_X509_REVOKED_find';
  fn_sk_X509_REVOKED_delete = 'sk_X509_REVOKED_delete';
  fn_sk_X509_REVOKED_delete_ptr = 'sk_X509_REVOKED_delete_ptr';
  fn_sk_X509_REVOKED_insert = 'sk_X509_REVOKED_insert';
  fn_sk_X509_REVOKED_dup = 'sk_X509_REVOKED_dup';
  fn_sk_X509_REVOKED_pop_free = 'sk_X509_REVOKED_pop_free';
  fn_sk_X509_REVOKED_shift = 'sk_X509_REVOKED_shift';
  fn_sk_X509_REVOKED_pop = 'sk_X509_REVOKED_pop';
  fn_sk_X509_REVOKED_sort = 'sk_X509_REVOKED_sort';
  fn_i2d_ASN1_SET_OF_X509_REVOKED = 'i2d_ASN1_SET_OF_X509_REVOKED';
  fn_d2i_ASN1_SET_OF_X509_REVOKED = 'd2i_ASN1_SET_OF_X509_REVOKED';
  fn_sk_X509_CRL_new = 'sk_X509_CRL_new';
  fn_sk_X509_CRL_new_null = 'sk_X509_CRL_new_null';
  fn_sk_X509_CRL_free = 'sk_X509_CRL_free';
  fn_sk_X509_CRL_num = 'sk_X509_CRL_num';
  fn_sk_X509_CRL_value = 'sk_X509_CRL_value';
  fn_sk_X509_CRL_set = 'sk_X509_CRL_set';
  fn_sk_X509_CRL_zero = 'sk_X509_CRL_zero';
  fn_sk_X509_CRL_push = 'sk_X509_CRL_push';
  fn_sk_X509_CRL_unshift = 'sk_X509_CRL_unshift';
  fn_sk_X509_CRL_find = 'sk_X509_CRL_find';
  fn_sk_X509_CRL_delete = 'sk_X509_CRL_delete';
  fn_sk_X509_CRL_delete_ptr = 'sk_X509_CRL_delete_ptr';
  fn_sk_X509_CRL_insert = 'sk_X509_CRL_insert';
  fn_sk_X509_CRL_dup = 'sk_X509_CRL_dup';
  fn_sk_X509_CRL_pop_free = 'sk_X509_CRL_pop_free';
  fn_sk_X509_CRL_shift = 'sk_X509_CRL_shift';
  fn_sk_X509_CRL_pop = 'sk_X509_CRL_pop';
  fn_sk_X509_CRL_sort = 'sk_X509_CRL_sort';
  fn_i2d_ASN1_SET_OF_X509_CRL = 'i2d_ASN1_SET_OF_X509_CRL';
  fn_d2i_ASN1_SET_OF_X509_CRL = 'd2i_ASN1_SET_OF_X509_CRL';
  fn_sk_X509_INFO_new = 'sk_X509_INFO_new';
  fn_sk_X509_INFO_new_null = 'sk_X509_INFO_new_null';
  fn_sk_X509_INFO_free = 'sk_X509_INFO_free';
  fn_sk_X509_INFO_num = 'sk_X509_INFO_num';
  fn_sk_X509_INFO_value = 'sk_X509_INFO_value';
  fn_sk_X509_INFO_set = 'sk_X509_INFO_set';
  fn_sk_X509_INFO_zero = 'sk_X509_INFO_zero';
  fn_sk_X509_INFO_push = 'sk_X509_INFO_push';
  fn_sk_X509_INFO_unshift = 'sk_X509_INFO_unshift';
  fn_sk_X509_INFO_find = 'sk_X509_INFO_find';
  fn_sk_X509_INFO_delete = 'sk_X509_INFO_delete';
  fn_sk_X509_INFO_delete_ptr = 'sk_X509_INFO_delete_ptr';
  fn_sk_X509_INFO_insert = 'sk_X509_INFO_insert';
  fn_sk_X509_INFO_dup = 'sk_X509_INFO_dup';
  fn_sk_X509_INFO_pop_free = 'sk_X509_INFO_pop_free';
  fn_sk_X509_INFO_shift = 'sk_X509_INFO_shift';
  fn_sk_X509_INFO_pop = 'sk_X509_INFO_pop';
  fn_sk_X509_INFO_sort = 'sk_X509_INFO_sort';
  fn_sk_X509_LOOKUP_new = 'sk_X509_LOOKUP_new';
  fn_sk_X509_LOOKUP_new_null = 'sk_X509_LOOKUP_new_null';
  fn_sk_X509_LOOKUP_free = 'sk_X509_LOOKUP_free';
  fn_sk_X509_LOOKUP_num = 'sk_X509_LOOKUP_num';
  fn_sk_X509_LOOKUP_value = 'sk_X509_LOOKUP_value';
  fn_sk_X509_LOOKUP_set = 'sk_X509_LOOKUP_set';
  fn_sk_X509_LOOKUP_zero = 'sk_X509_LOOKUP_zero';
  fn_sk_X509_LOOKUP_push = 'sk_X509_LOOKUP_push';
  fn_sk_X509_LOOKUP_unshift = 'sk_X509_LOOKUP_unshift';
  fn_sk_X509_LOOKUP_find = 'sk_X509_LOOKUP_find';
  fn_sk_X509_LOOKUP_delete = 'sk_X509_LOOKUP_delete';
  fn_sk_X509_LOOKUP_delete_ptr = 'sk_X509_LOOKUP_delete_ptr';
  fn_sk_X509_LOOKUP_insert = 'sk_X509_LOOKUP_insert';
  fn_sk_X509_LOOKUP_dup = 'sk_X509_LOOKUP_dup';
  fn_sk_X509_LOOKUP_pop_free = 'sk_X509_LOOKUP_pop_free';
  fn_sk_X509_LOOKUP_shift = 'sk_X509_LOOKUP_shift';
  fn_sk_X509_LOOKUP_pop = 'sk_X509_LOOKUP_pop';
  fn_sk_X509_LOOKUP_sort = 'sk_X509_LOOKUP_sort';
  fn_X509_OBJECT_retrieve_by_subject = 'X509_OBJECT_retrieve_by_subject';
  fn_X509_OBJECT_up_ref_count = 'X509_OBJECT_up_ref_count';
  fn_X509_OBJECT_free_contents = 'X509_OBJECT_free_contents';
  fn_X509_STORE_new = 'X509_STORE_new';
  fn_X509_STORE_free = 'X509_STORE_free';
  fn_X509_STORE_CTX_init = 'X509_STORE_CTX_init';
  fn_X509_STORE_CTX_cleanup = 'X509_STORE_CTX_cleanup';
  fn_X509_STORE_add_lookup = 'X509_STORE_add_lookup';
  fn_X509_LOOKUP_hash_dir = 'X509_LOOKUP_hash_dir';
  fn_X509_LOOKUP_file = 'X509_LOOKUP_file';
  fn_X509_STORE_add_cert = 'X509_STORE_add_cert';
  fn_X509_STORE_add_crl = 'X509_STORE_add_crl';
  fn_X509_STORE_get_by_subject = 'X509_STORE_get_by_subject';
  fn_X509_LOOKUP_ctrl = 'X509_LOOKUP_ctrl';
  fn_X509_load_cert_file = 'X509_load_cert_file';
  fn_X509_load_crl_file = 'X509_load_crl_file';
  fn_X509_LOOKUP_new = 'X509_LOOKUP_new';
  fn_X509_LOOKUP_free = 'X509_LOOKUP_free';
  fn_X509_LOOKUP_init = 'X509_LOOKUP_init';
  fn_X509_LOOKUP_by_subject = 'X509_LOOKUP_by_subject';
  fn_X509_LOOKUP_by_issuer_serial = 'X509_LOOKUP_by_issuer_serial';
  fn_X509_LOOKUP_by_fingerprint = 'X509_LOOKUP_by_fingerprint';
  fn_X509_LOOKUP_by_alias = 'X509_LOOKUP_by_alias';
  fn_X509_LOOKUP_shutdown = 'X509_LOOKUP_shutdown';
  fn_X509_STORE_load_locations = 'X509_STORE_load_locations';
  fn_X509_STORE_set_default_paths = 'X509_STORE_set_default_paths';
  fn_X509_STORE_CTX_get_ex_new_index = 'X509_STORE_CTX_get_ex_new_index';
  fn_X509_STORE_CTX_set_ex_data = 'X509_STORE_CTX_set_ex_data';
  fn_X509_STORE_CTX_get_ex_data = 'X509_STORE_CTX_get_ex_data';
  fn_X509_STORE_CTX_get_error = 'X509_STORE_CTX_get_error';
  fn_X509_STORE_CTX_set_error = 'X509_STORE_CTX_set_error';
  fn_X509_STORE_CTX_get_error_depth = 'X509_STORE_CTX_get_error_depth';
  fn_X509_STORE_CTX_get_current_cert = 'X509_STORE_CTX_get_current_cert';
  fn_X509_STORE_CTX_get_chain = 'X509_STORE_CTX_get_chain';
  fn_X509_STORE_CTX_set_cert = 'X509_STORE_CTX_set_cert';
  fn_X509_STORE_CTX_set_chain = 'X509_STORE_CTX_set_chain';
  fn_sk_PKCS7_SIGNER_INFO_new = 'sk_PKCS7_SIGNER_INFO_new';
  fn_sk_PKCS7_SIGNER_INFO_new_null = 'sk_PKCS7_SIGNER_INFO_new_null';
  fn_sk_PKCS7_SIGNER_INFO_free = 'sk_PKCS7_SIGNER_INFO_free';
  fn_sk_PKCS7_SIGNER_INFO_num = 'sk_PKCS7_SIGNER_INFO_num';
  fn_sk_PKCS7_SIGNER_INFO_value = 'sk_PKCS7_SIGNER_INFO_value';
  fn_sk_PKCS7_SIGNER_INFO_set = 'sk_PKCS7_SIGNER_INFO_set';
  fn_sk_PKCS7_SIGNER_INFO_zero = 'sk_PKCS7_SIGNER_INFO_zero';
  fn_sk_PKCS7_SIGNER_INFO_push = 'sk_PKCS7_SIGNER_INFO_push';
  fn_sk_PKCS7_SIGNER_INFO_unshift = 'sk_PKCS7_SIGNER_INFO_unshift';
  fn_sk_PKCS7_SIGNER_INFO_find = 'sk_PKCS7_SIGNER_INFO_find';
  fn_sk_PKCS7_SIGNER_INFO_delete = 'sk_PKCS7_SIGNER_INFO_delete';
  fn_sk_PKCS7_SIGNER_INFO_delete_ptr = 'sk_PKCS7_SIGNER_INFO_delete_ptr';
  fn_sk_PKCS7_SIGNER_INFO_insert = 'sk_PKCS7_SIGNER_INFO_insert';
  fn_sk_PKCS7_SIGNER_INFO_dup = 'sk_PKCS7_SIGNER_INFO_dup';
  fn_sk_PKCS7_SIGNER_INFO_pop_free = 'sk_PKCS7_SIGNER_INFO_pop_free';
  fn_sk_PKCS7_SIGNER_INFO_shift = 'sk_PKCS7_SIGNER_INFO_shift';
  fn_sk_PKCS7_SIGNER_INFO_pop = 'sk_PKCS7_SIGNER_INFO_pop';
  fn_sk_PKCS7_SIGNER_INFO_sort = 'sk_PKCS7_SIGNER_INFO_sort';
  fn_i2d_ASN1_SET_OF_PKCS7_SIGNER_INFO = 'i2d_ASN1_SET_OF_PKCS7_SIGNER_INFO';
  fn_d2i_ASN1_SET_OF_PKCS7_SIGNER_INFO = 'd2i_ASN1_SET_OF_PKCS7_SIGNER_INFO';
  fn_sk_PKCS7_RECIP_INFO_new = 'sk_PKCS7_RECIP_INFO_new';
  fn_sk_PKCS7_RECIP_INFO_new_null = 'sk_PKCS7_RECIP_INFO_new_null';
  fn_sk_PKCS7_RECIP_INFO_free = 'sk_PKCS7_RECIP_INFO_free';
  fn_sk_PKCS7_RECIP_INFO_num = 'sk_PKCS7_RECIP_INFO_num';
  fn_sk_PKCS7_RECIP_INFO_value = 'sk_PKCS7_RECIP_INFO_value';
  fn_sk_PKCS7_RECIP_INFO_set = 'sk_PKCS7_RECIP_INFO_set';
  fn_sk_PKCS7_RECIP_INFO_zero = 'sk_PKCS7_RECIP_INFO_zero';
  fn_sk_PKCS7_RECIP_INFO_push = 'sk_PKCS7_RECIP_INFO_push';
  fn_sk_PKCS7_RECIP_INFO_unshift = 'sk_PKCS7_RECIP_INFO_unshift';
  fn_sk_PKCS7_RECIP_INFO_find = 'sk_PKCS7_RECIP_INFO_find';
  fn_sk_PKCS7_RECIP_INFO_delete = 'sk_PKCS7_RECIP_INFO_delete';
  fn_sk_PKCS7_RECIP_INFO_delete_ptr = 'sk_PKCS7_RECIP_INFO_delete_ptr';
  fn_sk_PKCS7_RECIP_INFO_insert = 'sk_PKCS7_RECIP_INFO_insert';
  fn_sk_PKCS7_RECIP_INFO_dup = 'sk_PKCS7_RECIP_INFO_dup';
  fn_sk_PKCS7_RECIP_INFO_pop_free = 'sk_PKCS7_RECIP_INFO_pop_free';
  fn_sk_PKCS7_RECIP_INFO_shift = 'sk_PKCS7_RECIP_INFO_shift';
  fn_sk_PKCS7_RECIP_INFO_pop = 'sk_PKCS7_RECIP_INFO_pop';
  fn_sk_PKCS7_RECIP_INFO_sort = 'sk_PKCS7_RECIP_INFO_sort';
  fn_i2d_ASN1_SET_OF_PKCS7_RECIP_INFO = 'i2d_ASN1_SET_OF_PKCS7_RECIP_INFO';
  fn_d2i_ASN1_SET_OF_PKCS7_RECIP_INFO = 'd2i_ASN1_SET_OF_PKCS7_RECIP_INFO';
  fn_PKCS7_ISSUER_AND_SERIAL_new = 'PKCS7_ISSUER_AND_SERIAL_new';
  fn_PKCS7_ISSUER_AND_SERIAL_free = 'PKCS7_ISSUER_AND_SERIAL_free';
  fn_i2d_PKCS7_ISSUER_AND_SERIAL = 'i2d_PKCS7_ISSUER_AND_SERIAL';
  fn_d2i_PKCS7_ISSUER_AND_SERIAL = 'd2i_PKCS7_ISSUER_AND_SERIAL';
  fn_PKCS7_ISSUER_AND_SERIAL_digest = 'PKCS7_ISSUER_AND_SERIAL_digest';
  fn_d2i_PKCS7_fp = 'd2i_PKCS7_fp';
  fn_i2d_PKCS7_fp = 'i2d_PKCS7_fp';
  fn_PKCS7_dup = 'PKCS7_dup';
  fn_d2i_PKCS7_bio = 'd2i_PKCS7_bio';
  fn_i2d_PKCS7_bio = 'i2d_PKCS7_bio';
  fn_PKCS7_SIGNER_INFO_new = 'PKCS7_SIGNER_INFO_new';
  fn_PKCS7_SIGNER_INFO_free = 'PKCS7_SIGNER_INFO_free';
  fn_i2d_PKCS7_SIGNER_INFO = 'i2d_PKCS7_SIGNER_INFO';
  fn_d2i_PKCS7_SIGNER_INFO = 'd2i_PKCS7_SIGNER_INFO';
  fn_PKCS7_RECIP_INFO_new = 'PKCS7_RECIP_INFO_new';
  fn_PKCS7_RECIP_INFO_free = 'PKCS7_RECIP_INFO_free';
  fn_i2d_PKCS7_RECIP_INFO = 'i2d_PKCS7_RECIP_INFO';
  fn_d2i_PKCS7_RECIP_INFO = 'd2i_PKCS7_RECIP_INFO';
  fn_PKCS7_SIGNED_new = 'PKCS7_SIGNED_new';
  fn_PKCS7_SIGNED_free = 'PKCS7_SIGNED_free';
  fn_i2d_PKCS7_SIGNED = 'i2d_PKCS7_SIGNED';
  fn_d2i_PKCS7_SIGNED = 'd2i_PKCS7_SIGNED';
  fn_PKCS7_ENC_CONTENT_new = 'PKCS7_ENC_CONTENT_new';
  fn_PKCS7_ENC_CONTENT_free = 'PKCS7_ENC_CONTENT_free';
  fn_i2d_PKCS7_ENC_CONTENT = 'i2d_PKCS7_ENC_CONTENT';
  fn_d2i_PKCS7_ENC_CONTENT = 'd2i_PKCS7_ENC_CONTENT';
  fn_PKCS7_ENVELOPE_new = 'PKCS7_ENVELOPE_new';
  fn_PKCS7_ENVELOPE_free = 'PKCS7_ENVELOPE_free';
  fn_i2d_PKCS7_ENVELOPE = 'i2d_PKCS7_ENVELOPE';
  fn_d2i_PKCS7_ENVELOPE = 'd2i_PKCS7_ENVELOPE';
  fn_PKCS7_SIGN_ENVELOPE_new = 'PKCS7_SIGN_ENVELOPE_new';
  fn_PKCS7_SIGN_ENVELOPE_free = 'PKCS7_SIGN_ENVELOPE_free';
  fn_i2d_PKCS7_SIGN_ENVELOPE = 'i2d_PKCS7_SIGN_ENVELOPE';
  fn_d2i_PKCS7_SIGN_ENVELOPE = 'd2i_PKCS7_SIGN_ENVELOPE';
  fn_PKCS7_DIGEST_new = 'PKCS7_DIGEST_new';
  fn_PKCS7_DIGEST_free = 'PKCS7_DIGEST_free';
  fn_i2d_PKCS7_DIGEST = 'i2d_PKCS7_DIGEST';
  fn_d2i_PKCS7_DIGEST = 'd2i_PKCS7_DIGEST';
  fn_PKCS7_ENCRYPT_new = 'PKCS7_ENCRYPT_new';
  fn_PKCS7_ENCRYPT_free = 'PKCS7_ENCRYPT_free';
  fn_i2d_PKCS7_ENCRYPT = 'i2d_PKCS7_ENCRYPT';
  fn_d2i_PKCS7_ENCRYPT = 'd2i_PKCS7_ENCRYPT';
  fn_PKCS7_new = 'PKCS7_new';
  fn_PKCS7_free = 'PKCS7_free';
  fn_PKCS7_content_free = 'PKCS7_content_free';
  fn_i2d_PKCS7 = 'i2d_PKCS7';
  fn_d2i_PKCS7 = 'd2i_PKCS7';
  fn_ERR_load_PKCS7_strings = 'ERR_load_PKCS7_strings';
  fn_PKCS7_ctrl = 'PKCS7_ctrl';
  fn_PKCS7_set_type = 'PKCS7_set_type';
  fn_PKCS7_set_content = 'PKCS7_set_content';
  fn_PKCS7_SIGNER_INFO_set = 'PKCS7_SIGNER_INFO_set';
  fn_PKCS7_add_signer = 'PKCS7_add_signer';
  fn_PKCS7_add_certificate = 'PKCS7_add_certificate';
  fn_PKCS7_add_crl = 'PKCS7_add_crl';
  fn_PKCS7_content_new = 'PKCS7_content_new';
  fn_PKCS7_dataVerify = 'PKCS7_dataVerify';
  fn_PKCS7_signatureVerify = 'PKCS7_signatureVerify';
  fn_PKCS7_dataInit = 'PKCS7_dataInit';
  fn_PKCS7_dataFinal = 'PKCS7_dataFinal';
  fn_PKCS7_dataDecode = 'PKCS7_dataDecode';
  fn_PKCS7_add_signature = 'PKCS7_add_signature';
  fn_PKCS7_cert_from_signer_info = 'PKCS7_cert_from_signer_info';
  fn_PKCS7_get_signer_info = 'PKCS7_get_signer_info';
  fn_PKCS7_add_recipient = 'PKCS7_add_recipient';
  fn_PKCS7_add_recipient_info = 'PKCS7_add_recipient_info';
  fn_PKCS7_RECIP_INFO_set = 'PKCS7_RECIP_INFO_set';
  fn_PKCS7_set_cipher = 'PKCS7_set_cipher';
  fn_PKCS7_get_issuer_and_serial = 'PKCS7_get_issuer_and_serial';
  fn_PKCS7_digest_from_attributes = 'PKCS7_digest_from_attributes';
  fn_PKCS7_add_signed_attribute = 'PKCS7_add_signed_attribute';
  fn_PKCS7_add_attribute = 'PKCS7_add_attribute';
  fn_PKCS7_get_attribute = 'PKCS7_get_attribute';
  fn_PKCS7_get_signed_attribute = 'PKCS7_get_signed_attribute';
  fn_PKCS7_set_signed_attributes = 'PKCS7_set_signed_attributes';
  fn_PKCS7_set_attributes = 'PKCS7_set_attributes';
  fn_X509_verify_cert_error_string = 'X509_verify_cert_error_string';
  fn_X509_verify = 'X509_verify';
  fn_X509_REQ_verify = 'X509_REQ_verify';
  fn_X509_CRL_verify = 'X509_CRL_verify';
  fn_NETSCAPE_SPKI_verify = 'NETSCAPE_SPKI_verify';
  fn_X509_sign = 'X509_sign';
  fn_X509_REQ_sign = 'X509_REQ_sign';
  fn_X509_CRL_sign = 'X509_CRL_sign';
  fn_NETSCAPE_SPKI_sign = 'NETSCAPE_SPKI_sign';
  fn_X509_digest = 'X509_digest';
  fn_X509_NAME_digest = 'X509_NAME_digest';
  fn_d2i_X509_fp = 'd2i_X509_fp';
  fn_i2d_X509_fp = 'i2d_X509_fp';
  fn_d2i_X509_CRL_fp = 'd2i_X509_CRL_fp';
  fn_i2d_X509_CRL_fp = 'i2d_X509_CRL_fp';
  fn_d2i_X509_REQ_fp = 'd2i_X509_REQ_fp';
  fn_i2d_X509_REQ_fp = 'i2d_X509_REQ_fp';
  fn_d2i_RSAPrivateKey_fp = 'd2i_RSAPrivateKey_fp';
  fn_i2d_RSAPrivateKey_fp = 'i2d_RSAPrivateKey_fp';
  fn_d2i_RSAPublicKey_fp = 'd2i_RSAPublicKey_fp';
  fn_i2d_RSAPublicKey_fp = 'i2d_RSAPublicKey_fp';
  fn_d2i_DSAPrivateKey_fp = 'd2i_DSAPrivateKey_fp';
  fn_i2d_DSAPrivateKey_fp = 'i2d_DSAPrivateKey_fp';
  fn_d2i_PKCS8_fp = 'd2i_PKCS8_fp';
  fn_i2d_PKCS8_fp = 'i2d_PKCS8_fp';
  fn_d2i_PKCS8_PRIV_KEY_INFO_fp = 'd2i_PKCS8_PRIV_KEY_INFO_fp';
  fn_i2d_PKCS8_PRIV_KEY_INFO_fp = 'i2d_PKCS8_PRIV_KEY_INFO_fp';
  fn_d2i_X509_bio = 'd2i_X509_bio';
  fn_i2d_X509_bio = 'i2d_X509_bio';
  fn_d2i_X509_CRL_bio = 'd2i_X509_CRL_bio';
  fn_i2d_X509_CRL_bio = 'i2d_X509_CRL_bio';
  fn_d2i_X509_REQ_bio = 'd2i_X509_REQ_bio';
  fn_i2d_X509_REQ_bio = 'i2d_X509_REQ_bio';
  fn_d2i_RSAPrivateKey_bio = 'd2i_RSAPrivateKey_bio';
  fn_i2d_RSAPrivateKey_bio = 'i2d_RSAPrivateKey_bio';
  fn_d2i_RSAPublicKey_bio = 'd2i_RSAPublicKey_bio';
  fn_i2d_RSAPublicKey_bio = 'i2d_RSAPublicKey_bio';
  fn_d2i_DSAPrivateKey_bio = 'd2i_DSAPrivateKey_bio';
  fn_i2d_DSAPrivateKey_bio = 'i2d_DSAPrivateKey_bio';
  fn_d2i_PKCS8_bio = 'd2i_PKCS8_bio';
  fn_i2d_PKCS8_bio = 'i2d_PKCS8_bio';
  fn_d2i_PKCS8_PRIV_KEY_INFO_bio = 'd2i_PKCS8_PRIV_KEY_INFO_bio';
  fn_i2d_PKCS8_PRIV_KEY_INFO_bio = 'i2d_PKCS8_PRIV_KEY_INFO_bio';
  fn_X509_dup = 'X509_dup';
  fn_X509_ATTRIBUTE_dup = 'X509_ATTRIBUTE_dup';
  fn_X509_EXTENSION_dup = 'X509_EXTENSION_dup';
  fn_X509_CRL_dup = 'X509_CRL_dup';
  fn_X509_REQ_dup = 'X509_REQ_dup';
  fn_X509_ALGOR_dup = 'X509_ALGOR_dup';
  fn_X509_NAME_dup = 'X509_NAME_dup';
  fn_X509_NAME_ENTRY_dup = 'X509_NAME_ENTRY_dup';
  fn_RSAPublicKey_dup = 'RSAPublicKey_dup';
  fn_RSAPrivateKey_dup = 'RSAPrivateKey_dup';
  fn_X509_cmp_current_time = 'X509_cmp_current_time';
  fn_X509_gmtime_adj = 'X509_gmtime_adj';
  fn_X509_get_default_cert_area = 'X509_get_default_cert_area';
  fn_X509_get_default_cert_dir = 'X509_get_default_cert_dir';
  fn_X509_get_default_cert_file = 'X509_get_default_cert_file';
  fn_X509_get_default_cert_dir_env = 'X509_get_default_cert_dir_env';
  fn_X509_get_default_cert_file_env = 'X509_get_default_cert_file_env';
  fn_X509_get_default_private_dir = 'X509_get_default_private_dir';
  fn_X509_to_X509_REQ = 'X509_to_X509_REQ';
  fn_X509_REQ_to_X509 = 'X509_REQ_to_X509';
  fn_ERR_load_X509_strings = 'ERR_load_X509_strings';
  fn_X509_ALGOR_new = 'X509_ALGOR_new';
  fn_X509_ALGOR_free = 'X509_ALGOR_free';
  fn_i2d_X509_ALGOR = 'i2d_X509_ALGOR';
  fn_d2i_X509_ALGOR = 'd2i_X509_ALGOR';
  fn_X509_VAL_new = 'X509_VAL_new';
  fn_X509_VAL_free = 'X509_VAL_free';
  fn_i2d_X509_VAL = 'i2d_X509_VAL';
  fn_d2i_X509_VAL = 'd2i_X509_VAL';
  fn_X509_PUBKEY_new = 'X509_PUBKEY_new';
  fn_X509_PUBKEY_free = 'X509_PUBKEY_free';
  fn_i2d_X509_PUBKEY = 'i2d_X509_PUBKEY';
  fn_d2i_X509_PUBKEY = 'd2i_X509_PUBKEY';
  fn_X509_PUBKEY_set = 'X509_PUBKEY_set';
  fn_X509_PUBKEY_get = 'X509_PUBKEY_get';
  fn_X509_get_pubkey_parameters = 'X509_get_pubkey_parameters';
  fn_X509_SIG_new = 'X509_SIG_new';
  fn_X509_SIG_free = 'X509_SIG_free';
  fn_i2d_X509_SIG = 'i2d_X509_SIG';
  fn_d2i_X509_SIG = 'd2i_X509_SIG';
  fn_X509_REQ_INFO_new = 'X509_REQ_INFO_new';
  fn_X509_REQ_INFO_free = 'X509_REQ_INFO_free';
  fn_i2d_X509_REQ_INFO = 'i2d_X509_REQ_INFO';
  fn_d2i_X509_REQ_INFO = 'd2i_X509_REQ_INFO';
  fn_X509_REQ_new = 'X509_REQ_new';
  fn_X509_REQ_free = 'X509_REQ_free';
  fn_i2d_X509_REQ = 'i2d_X509_REQ';
  fn_d2i_X509_REQ = 'd2i_X509_REQ';
  fn_X509_ATTRIBUTE_new = 'X509_ATTRIBUTE_new';
  fn_X509_ATTRIBUTE_free = 'X509_ATTRIBUTE_free';
  fn_i2d_X509_ATTRIBUTE = 'i2d_X509_ATTRIBUTE';
  fn_d2i_X509_ATTRIBUTE = 'd2i_X509_ATTRIBUTE';
  fn_X509_ATTRIBUTE_create = 'X509_ATTRIBUTE_create';
  fn_X509_EXTENSION_new = 'X509_EXTENSION_new';
  fn_X509_EXTENSION_free = 'X509_EXTENSION_free';
  fn_i2d_X509_EXTENSION = 'i2d_X509_EXTENSION';
  fn_d2i_X509_EXTENSION = 'd2i_X509_EXTENSION';
  fn_X509_NAME_ENTRY_new = 'X509_NAME_ENTRY_new';
  fn_X509_NAME_ENTRY_free = 'X509_NAME_ENTRY_free';
  fn_i2d_X509_NAME_ENTRY = 'i2d_X509_NAME_ENTRY';
  fn_d2i_X509_NAME_ENTRY = 'd2i_X509_NAME_ENTRY';
  fn_X509_NAME_new = 'X509_NAME_new';
  fn_X509_NAME_free = 'X509_NAME_free';
  fn_i2d_X509_NAME = 'i2d_X509_NAME';
  fn_d2i_X509_NAME = 'd2i_X509_NAME';
  fn_X509_NAME_set = 'X509_NAME_set';
  fn_X509_CINF_new = 'X509_CINF_new';
  fn_X509_CINF_free = 'X509_CINF_free';
  fn_i2d_X509_CINF = 'i2d_X509_CINF';
  fn_d2i_X509_CINF = 'd2i_X509_CINF';
  fn_X509_new = 'X509_new';
  fn_X509_free = 'X509_free';
  fn_i2d_X509 = 'i2d_X509';
  fn_d2i_X509 = 'd2i_X509';
  fn_X509_REVOKED_new = 'X509_REVOKED_new';
  fn_X509_REVOKED_free = 'X509_REVOKED_free';
  fn_i2d_X509_REVOKED = 'i2d_X509_REVOKED';
  fn_d2i_X509_REVOKED = 'd2i_X509_REVOKED';
  fn_X509_CRL_INFO_new = 'X509_CRL_INFO_new';
  fn_X509_CRL_INFO_free = 'X509_CRL_INFO_free';
  fn_i2d_X509_CRL_INFO = 'i2d_X509_CRL_INFO';
  fn_d2i_X509_CRL_INFO = 'd2i_X509_CRL_INFO';
  fn_X509_CRL_new = 'X509_CRL_new';
  fn_X509_CRL_free = 'X509_CRL_free';
  fn_i2d_X509_CRL = 'i2d_X509_CRL';
  fn_d2i_X509_CRL = 'd2i_X509_CRL';
  fn_X509_PKEY_new = 'X509_PKEY_new';
  fn_X509_PKEY_free = 'X509_PKEY_free';
  fn_i2d_X509_PKEY = 'i2d_X509_PKEY';
  fn_d2i_X509_PKEY = 'd2i_X509_PKEY';
  fn_NETSCAPE_SPKI_new = 'NETSCAPE_SPKI_new';
  fn_NETSCAPE_SPKI_free = 'NETSCAPE_SPKI_free';
  fn_i2d_NETSCAPE_SPKI = 'i2d_NETSCAPE_SPKI';
  fn_d2i_NETSCAPE_SPKI = 'd2i_NETSCAPE_SPKI';
  fn_NETSCAPE_SPKAC_new = 'NETSCAPE_SPKAC_new';
  fn_NETSCAPE_SPKAC_free = 'NETSCAPE_SPKAC_free';
  fn_i2d_NETSCAPE_SPKAC = 'i2d_NETSCAPE_SPKAC';
  fn_d2i_NETSCAPE_SPKAC = 'd2i_NETSCAPE_SPKAC';
  fn_i2d_NETSCAPE_CERT_SEQUENCE = 'i2d_NETSCAPE_CERT_SEQUENCE';
  fn_NETSCAPE_CERT_SEQUENCE_new = 'NETSCAPE_CERT_SEQUENCE_new';
  fn_d2i_NETSCAPE_CERT_SEQUENCE = 'd2i_NETSCAPE_CERT_SEQUENCE';
  fn_NETSCAPE_CERT_SEQUENCE_free = 'NETSCAPE_CERT_SEQUENCE_free';
  fn_X509_INFO_new = 'X509_INFO_new';
  fn_X509_INFO_free = 'X509_INFO_free';
  fn_X509_NAME_oneline = 'X509_NAME_oneline';
  fn_ASN1_verify = 'ASN1_verify';
  fn_ASN1_digest = 'ASN1_digest';
  fn_ASN1_sign = 'ASN1_sign';
  fn_X509_set_version = 'X509_set_version';
  fn_X509_set_serialNumber = 'X509_set_serialNumber';
  fn_X509_get_serialNumber = 'X509_get_serialNumber';
  fn_X509_set_issuer_name = 'X509_set_issuer_name';
  fn_X509_get_issuer_name = 'X509_get_issuer_name';
  fn_X509_set_subject_name = 'X509_set_subject_name';
  fn_X509_get_subject_name = 'X509_get_subject_name';
  fn_X509_set_notBefore = 'X509_set_notBefore';
  fn_X509_set_notAfter = 'X509_set_notAfter';
  fn_X509_set_pubkey = 'X509_set_pubkey';
  fn_X509_get_pubkey = 'X509_get_pubkey';
  fn_X509_certificate_type = 'X509_certificate_type';
  fn_X509_REQ_set_version = 'X509_REQ_set_version';
  fn_X509_REQ_set_subject_name = 'X509_REQ_set_subject_name';
  fn_X509_REQ_set_pubkey = 'X509_REQ_set_pubkey';
  fn_X509_REQ_get_pubkey = 'X509_REQ_get_pubkey';
  fn_X509_check_private_key = 'X509_check_private_key';
  fn_X509_issuer_and_serial_cmp = 'X509_issuer_and_serial_cmp';
  fn_X509_issuer_and_serial_hash = 'X509_issuer_and_serial_hash';
  fn_X509_issuer_name_cmp = 'X509_issuer_name_cmp';
  fn_X509_issuer_name_hash = 'X509_issuer_name_hash';
  fn_X509_subject_name_cmp = 'X509_subject_name_cmp';
  fn_X509_subject_name_hash = 'X509_subject_name_hash';
  fn_X509_NAME_cmp = 'X509_NAME_cmp';
  fn_X509_NAME_hash = 'X509_NAME_hash';
  fn_X509_CRL_cmp = 'X509_CRL_cmp';
  fn_X509_print_fp = 'X509_print_fp';
  fn_X509_CRL_print_fp = 'X509_CRL_print_fp';
  fn_X509_REQ_print_fp = 'X509_REQ_print_fp';
  fn_X509_NAME_print = 'X509_NAME_print';
  fn_X509_print = 'X509_print';
  fn_X509_CRL_print = 'X509_CRL_print';
  fn_X509_REQ_print = 'X509_REQ_print';
  fn_X509_NAME_entry_count = 'X509_NAME_entry_count';
  fn_X509_NAME_get_text_by_NID = 'X509_NAME_get_text_by_NID';
  fn_X509_NAME_get_text_by_OBJ = 'X509_NAME_get_text_by_OBJ';
  fn_X509_NAME_get_index_by_NID = 'X509_NAME_get_index_by_NID';
  fn_X509_NAME_get_index_by_OBJ = 'X509_NAME_get_index_by_OBJ';
  fn_X509_NAME_get_entry = 'X509_NAME_get_entry';
  fn_X509_NAME_delete_entry = 'X509_NAME_delete_entry';
  fn_X509_NAME_add_entry = 'X509_NAME_add_entry';
  fn_X509_NAME_ENTRY_create_by_NID = 'X509_NAME_ENTRY_create_by_NID';
  fn_X509_NAME_ENTRY_create_by_OBJ = 'X509_NAME_ENTRY_create_by_OBJ';
  fn_X509_NAME_ENTRY_set_object = 'X509_NAME_ENTRY_set_object';
  fn_X509_NAME_ENTRY_set_data = 'X509_NAME_ENTRY_set_data';
  fn_X509_NAME_ENTRY_get_object = 'X509_NAME_ENTRY_get_object';
  fn_X509_NAME_ENTRY_get_data = 'X509_NAME_ENTRY_get_data';
  fn_X509v3_get_ext_count = 'X509v3_get_ext_count';
  fn_X509v3_get_ext_by_NID = 'X509v3_get_ext_by_NID';
  fn_X509v3_get_ext_by_OBJ = 'X509v3_get_ext_by_OBJ';
  fn_X509v3_get_ext_by_critical = 'X509v3_get_ext_by_critical';
  fn_X509v3_get_ext = 'X509v3_get_ext';
  fn_X509v3_delete_ext = 'X509v3_delete_ext';
  fn_X509v3_add_ext = 'X509v3_add_ext';
  fn_X509_get_ext_count = 'X509_get_ext_count';
  fn_X509_get_ext_by_NID = 'X509_get_ext_by_NID';
  fn_X509_get_ext_by_OBJ = 'X509_get_ext_by_OBJ';
  fn_X509_get_ext_by_critical = 'X509_get_ext_by_critical';
  fn_X509_get_ext = 'X509_get_ext';
  fn_X509_delete_ext = 'X509_delete_ext';
  fn_X509_add_ext = 'X509_add_ext';
  fn_X509_CRL_get_ext_count = 'X509_CRL_get_ext_count';
  fn_X509_CRL_get_ext_by_NID = 'X509_CRL_get_ext_by_NID';
  fn_X509_CRL_get_ext_by_OBJ = 'X509_CRL_get_ext_by_OBJ';
  fn_X509_CRL_get_ext_by_critical = 'X509_CRL_get_ext_by_critical';
  fn_X509_CRL_get_ext = 'X509_CRL_get_ext';
  fn_X509_CRL_delete_ext = 'X509_CRL_delete_ext';
  fn_X509_CRL_add_ext = 'X509_CRL_add_ext';
  fn_X509_REVOKED_get_ext_count = 'X509_REVOKED_get_ext_count';
  fn_X509_REVOKED_get_ext_by_NID = 'X509_REVOKED_get_ext_by_NID';
  fn_X509_REVOKED_get_ext_by_OBJ = 'X509_REVOKED_get_ext_by_OBJ';
  fn_X509_REVOKED_get_ext_by_critical = 'X509_REVOKED_get_ext_by_critical';
  fn_X509_REVOKED_get_ext = 'X509_REVOKED_get_ext';
  fn_X509_REVOKED_delete_ext = 'X509_REVOKED_delete_ext';
  fn_X509_REVOKED_add_ext = 'X509_REVOKED_add_ext';
  fn_X509_EXTENSION_create_by_NID = 'X509_EXTENSION_create_by_NID';
  fn_X509_EXTENSION_create_by_OBJ = 'X509_EXTENSION_create_by_OBJ';
  fn_X509_EXTENSION_set_object = 'X509_EXTENSION_set_object';
  fn_X509_EXTENSION_set_critical = 'X509_EXTENSION_set_critical';
  fn_X509_EXTENSION_set_data = 'X509_EXTENSION_set_data';
  fn_X509_EXTENSION_get_object = 'X509_EXTENSION_get_object';
  fn_X509_EXTENSION_get_data = 'X509_EXTENSION_get_data';
  fn_X509_EXTENSION_get_critical = 'X509_EXTENSION_get_critical';
  fn_X509_verify_cert = 'X509_verify_cert';
  fn_X509_find_by_issuer_and_serial = 'X509_find_by_issuer_and_serial';
  fn_X509_find_by_subject = 'X509_find_by_subject';
  fn_i2d_PBEPARAM = 'i2d_PBEPARAM';
  fn_PBEPARAM_new = 'PBEPARAM_new';
  fn_d2i_PBEPARAM = 'd2i_PBEPARAM';
  fn_PBEPARAM_free = 'PBEPARAM_free';
  fn_PKCS5_pbe_set = 'PKCS5_pbe_set';
  fn_PKCS5_pbe2_set = 'PKCS5_pbe2_set';
  fn_i2d_PBKDF2PARAM = 'i2d_PBKDF2PARAM';
  fn_PBKDF2PARAM_new = 'PBKDF2PARAM_new';
  fn_d2i_PBKDF2PARAM = 'd2i_PBKDF2PARAM';
  fn_PBKDF2PARAM_free = 'PBKDF2PARAM_free';
  fn_i2d_PBE2PARAM = 'i2d_PBE2PARAM';
  fn_PBE2PARAM_new = 'PBE2PARAM_new';
  fn_d2i_PBE2PARAM = 'd2i_PBE2PARAM';
  fn_PBE2PARAM_free = 'PBE2PARAM_free';
  fn_i2d_PKCS8_PRIV_KEY_INFO = 'i2d_PKCS8_PRIV_KEY_INFO';
  fn_PKCS8_PRIV_KEY_INFO_new = 'PKCS8_PRIV_KEY_INFO_new';
  fn_d2i_PKCS8_PRIV_KEY_INFO = 'd2i_PKCS8_PRIV_KEY_INFO';
  fn_PKCS8_PRIV_KEY_INFO_free = 'PKCS8_PRIV_KEY_INFO_free';
  fn_EVP_PKCS82PKEY = 'EVP_PKCS82PKEY';
  fn_EVP_PKEY2PKCS8 = 'EVP_PKEY2PKCS8';
  fn_PKCS8_set_broken = 'PKCS8_set_broken';
  fn_ERR_load_PEM_strings = 'ERR_load_PEM_strings';
  fn_PEM_get_EVP_CIPHER_INFO = 'PEM_get_EVP_CIPHER_INFO';
  fn_PEM_do_header = 'PEM_do_header';
  fn_PEM_read_bio = 'PEM_read_bio';
  fn_PEM_write_bio = 'PEM_write_bio';
  fn_PEM_ASN1_read_bio = 'PEM_ASN1_read_bio';
  fn_PEM_ASN1_write_bio = 'PEM_ASN1_write_bio';
  fn_PEM_X509_INFO_read_bio = 'PEM_X509_INFO_read_bio';
  fn_PEM_X509_INFO_write_bio = 'PEM_X509_INFO_write_bio';
  fn_PEM_read = 'PEM_read';
  fn_PEM_write = 'PEM_write';
  fn_PEM_ASN1_read = 'PEM_ASN1_read';
  fn_PEM_ASN1_write = 'PEM_ASN1_write';
  fn_PEM_X509_INFO_read = 'PEM_X509_INFO_read';
  fn_PEM_SealInit = 'PEM_SealInit';
  fn_PEM_SealUpdate = 'PEM_SealUpdate';
  fn_PEM_SealFinal = 'PEM_SealFinal';
  fn_PEM_SignInit = 'PEM_SignInit';
  fn_PEM_SignUpdate = 'PEM_SignUpdate';
  fn_PEM_SignFinal = 'PEM_SignFinal';
  fn_PEM_proc_type = 'PEM_proc_type';
  fn_PEM_dek_info = 'PEM_dek_info';
  fn_PEM_read_bio_X509 = 'PEM_read_bio_X509';
  fn_PEM_read_X509 = 'PEM_read_X509';
  fn_PEM_write_bio_X509 = 'PEM_write_bio_X509';
  fn_PEM_write_X509 = 'PEM_write_X509';
  fn_PEM_read_bio_X509_REQ = 'PEM_read_bio_X509_REQ';
  fn_PEM_read_X509_REQ = 'PEM_read_X509_REQ';
  fn_PEM_write_bio_X509_REQ = 'PEM_write_bio_X509_REQ';
  fn_PEM_write_X509_REQ = 'PEM_write_X509_REQ';
  fn_PEM_read_bio_X509_CRL = 'PEM_read_bio_X509_CRL';
  fn_PEM_read_X509_CRL = 'PEM_read_X509_CRL';
  fn_PEM_write_bio_X509_CRL = 'PEM_write_bio_X509_CRL';
  fn_PEM_write_X509_CRL = 'PEM_write_X509_CRL';
  fn_PEM_read_bio_PKCS7 = 'PEM_read_bio_PKCS7';
  fn_PEM_read_PKCS7 = 'PEM_read_PKCS7';
  fn_PEM_write_bio_PKCS7 = 'PEM_write_bio_PKCS7';
  fn_PEM_write_PKCS7 = 'PEM_write_PKCS7';
  fn_PEM_read_bio_NETSCAPE_CERT_SEQUENCE = 'PEM_read_bio_NETSCAPE_CERT_SEQUENCE';
  fn_PEM_read_NETSCAPE_CERT_SEQUENCE = 'PEM_read_NETSCAPE_CERT_SEQUENCE';
  fn_PEM_write_bio_NETSCAPE_CERT_SEQUENCE = 'PEM_write_bio_NETSCAPE_CERT_SEQUENCE';
  fn_PEM_write_NETSCAPE_CERT_SEQUENCE = 'PEM_write_NETSCAPE_CERT_SEQUENCE';
  fn_PEM_read_bio_PKCS8 = 'PEM_read_bio_PKCS8';
  fn_PEM_read_PKCS8 = 'PEM_read_PKCS8';
  fn_PEM_write_bio_PKCS8 = 'PEM_write_bio_PKCS8';
  fn_PEM_write_PKCS8 = 'PEM_write_PKCS8';
  fn_PEM_read_bio_PKCS8_PRIV_KEY_INFO = 'PEM_read_bio_PKCS8_PRIV_KEY_INFO';
  fn_PEM_read_PKCS8_PRIV_KEY_INFO = 'PEM_read_PKCS8_PRIV_KEY_INFO';
  fn_PEM_write_bio_PKCS8_PRIV_KEY_INFO = 'PEM_write_bio_PKCS8_PRIV_KEY_INFO';
  fn_PEM_write_PKCS8_PRIV_KEY_INFO = 'PEM_write_PKCS8_PRIV_KEY_INFO';
  fn_PEM_read_bio_RSAPrivateKey = 'PEM_read_bio_RSAPrivateKey';
  fn_PEM_read_RSAPrivateKey = 'PEM_read_RSAPrivateKey';
  fn_PEM_write_bio_RSAPrivateKey = 'PEM_write_bio_RSAPrivateKey';
  fn_PEM_write_RSAPrivateKey = 'PEM_write_RSAPrivateKey';
  fn_PEM_read_bio_RSAPublicKey = 'PEM_read_bio_RSAPublicKey';
  fn_PEM_read_RSAPublicKey = 'PEM_read_RSAPublicKey';
  fn_PEM_write_bio_RSAPublicKey = 'PEM_write_bio_RSAPublicKey';
  fn_PEM_write_RSAPublicKey = 'PEM_write_RSAPublicKey';
  fn_PEM_read_bio_DSAPrivateKey = 'PEM_read_bio_DSAPrivateKey';
  fn_PEM_read_DSAPrivateKey = 'PEM_read_DSAPrivateKey';
  fn_PEM_write_bio_DSAPrivateKey = 'PEM_write_bio_DSAPrivateKey';
  fn_PEM_write_DSAPrivateKey = 'PEM_write_DSAPrivateKey';
  fn_PEM_read_bio_DSAparams = 'PEM_read_bio_DSAparams';
  fn_PEM_read_DSAparams = 'PEM_read_DSAparams';
  fn_PEM_write_bio_DSAparams = 'PEM_write_bio_DSAparams';
  fn_PEM_write_DSAparams = 'PEM_write_DSAparams';
  fn_PEM_read_bio_DHparams = 'PEM_read_bio_DHparams';
  fn_PEM_read_DHparams = 'PEM_read_DHparams';
  fn_PEM_write_bio_DHparams = 'PEM_write_bio_DHparams';
  fn_PEM_write_DHparams = 'PEM_write_DHparams';
  fn_PEM_read_bio_PrivateKey = 'PEM_read_bio_PrivateKey';
  fn_PEM_read_PrivateKey = 'PEM_read_PrivateKey';
  fn_PEM_write_bio_PrivateKey = 'PEM_write_bio_PrivateKey';
  fn_PEM_write_PrivateKey = 'PEM_write_PrivateKey';
  fn_PEM_write_bio_PKCS8PrivateKey = 'PEM_write_bio_PKCS8PrivateKey';
  fn_PEM_write_PKCS8PrivateKey = 'PEM_write_PKCS8PrivateKey';
  fn_sk_SSL_CIPHER_new = 'sk_SSL_CIPHER_new';
  fn_sk_SSL_CIPHER_new_null = 'sk_SSL_CIPHER_new_null';
  fn_sk_SSL_CIPHER_free = 'sk_SSL_CIPHER_free';
  fn_sk_SSL_CIPHER_num = 'sk_SSL_CIPHER_num';
  fn_sk_SSL_CIPHER_value = 'sk_SSL_CIPHER_value';
  fn_sk_SSL_CIPHER_set = 'sk_SSL_CIPHER_set';
  fn_sk_SSL_CIPHER_zero = 'sk_SSL_CIPHER_zero';
  fn_sk_SSL_CIPHER_push = 'sk_SSL_CIPHER_push';
  fn_sk_SSL_CIPHER_unshift = 'sk_SSL_CIPHER_unshift';
  fn_sk_SSL_CIPHER_find = 'sk_SSL_CIPHER_find';
  fn_sk_SSL_CIPHER_delete = 'sk_SSL_CIPHER_delete';
  fn_sk_SSL_CIPHER_delete_ptr = 'sk_SSL_CIPHER_delete_ptr';
  fn_sk_SSL_CIPHER_insert = 'sk_SSL_CIPHER_insert';
  fn_sk_SSL_CIPHER_dup = 'sk_SSL_CIPHER_dup';
  fn_sk_SSL_CIPHER_pop_free = 'sk_SSL_CIPHER_pop_free';
  fn_sk_SSL_CIPHER_shift = 'sk_SSL_CIPHER_shift';
  fn_sk_SSL_CIPHER_pop = 'sk_SSL_CIPHER_pop';
  fn_sk_SSL_CIPHER_sort = 'sk_SSL_CIPHER_sort';
  fn_sk_SSL_COMP_new = 'sk_SSL_COMP_new';
  fn_sk_SSL_COMP_new_null = 'sk_SSL_COMP_new_null';
  fn_sk_SSL_COMP_free = 'sk_SSL_COMP_free';
  fn_sk_SSL_COMP_num = 'sk_SSL_COMP_num';
  fn_sk_SSL_COMP_value = 'sk_SSL_COMP_value';
  fn_sk_SSL_COMP_set = 'sk_SSL_COMP_set';
  fn_sk_SSL_COMP_zero = 'sk_SSL_COMP_zero';
  fn_sk_SSL_COMP_push = 'sk_SSL_COMP_push';
  fn_sk_SSL_COMP_unshift = 'sk_SSL_COMP_unshift';
  fn_sk_SSL_COMP_find = 'sk_SSL_COMP_find';
  fn_sk_SSL_COMP_delete = 'sk_SSL_COMP_delete';
  fn_sk_SSL_COMP_delete_ptr = 'sk_SSL_COMP_delete_ptr';
  fn_sk_SSL_COMP_insert = 'sk_SSL_COMP_insert';
  fn_sk_SSL_COMP_dup = 'sk_SSL_COMP_dup';
  fn_sk_SSL_COMP_pop_free = 'sk_SSL_COMP_pop_free';
  fn_sk_SSL_COMP_shift = 'sk_SSL_COMP_shift';
  fn_sk_SSL_COMP_pop = 'sk_SSL_COMP_pop';
  fn_sk_SSL_COMP_sort = 'sk_SSL_COMP_sort';
  fn_BIO_f_ssl = 'BIO_f_ssl';
  fn_BIO_new_ssl = 'BIO_new_ssl';
  fn_BIO_new_ssl_connect = 'BIO_new_ssl_connect';
  fn_BIO_new_buffer_ssl_connect = 'BIO_new_buffer_ssl_connect';
  fn_BIO_ssl_copy_session_id = 'BIO_ssl_copy_session_id';
  fn_BIO_ssl_shutdown = 'BIO_ssl_shutdown';
  fn_SSL_CTX_set_cipher_list = 'SSL_CTX_set_cipher_list';
  fn_SSL_CTX_new = 'SSL_CTX_new';
  fn_SSL_CTX_free = 'SSL_CTX_free';
  fn_SSL_CTX_set_timeout = 'SSL_CTX_set_timeout';
  fn_SSL_CTX_get_timeout = 'SSL_CTX_get_timeout';
  fn_SSL_CTX_get_cert_store = 'SSL_CTX_get_cert_store';
  fn_SSL_CTX_set_cert_store = 'SSL_CTX_set_cert_store';
  fn_SSL_want = 'SSL_want';
  fn_SSL_clear = 'SSL_clear';
  fn_SSL_CTX_flush_sessions = 'SSL_CTX_flush_sessions';
  fn_SSL_get_current_cipher = 'SSL_get_current_cipher';
  fn_SSL_CIPHER_get_bits = 'SSL_CIPHER_get_bits';
  fn_SSL_CIPHER_get_version = 'SSL_CIPHER_get_version';
  fn_SSL_CIPHER_get_name = 'SSL_CIPHER_get_name';
  fn_SSL_get_fd = 'SSL_get_fd';
  fn_SSL_get_cipher_list = 'SSL_get_cipher_list';
  fn_SSL_get_shared_ciphers = 'SSL_get_shared_ciphers';
  fn_SSL_get_read_ahead = 'SSL_get_read_ahead';
  fn_SSL_pending = 'SSL_pending';
  fn_SSL_set_fd = 'SSL_set_fd';
  fn_SSL_set_rfd = 'SSL_set_rfd';
  fn_SSL_set_wfd = 'SSL_set_wfd';
  fn_SSL_set_bio = 'SSL_set_bio';
  fn_SSL_get_rbio = 'SSL_get_rbio';
  fn_SSL_get_wbio = 'SSL_get_wbio';
  fn_SSL_set_cipher_list = 'SSL_set_cipher_list';
  fn_SSL_set_read_ahead = 'SSL_set_read_ahead';
  fn_SSL_get_verify_mode = 'SSL_get_verify_mode';
  fn_SSL_get_verify_depth = 'SSL_get_verify_depth';
  fn_SSL_set_verify = 'SSL_set_verify';
  fn_SSL_set_verify_depth = 'SSL_set_verify_depth';
  fn_SSL_use_RSAPrivateKey = 'SSL_use_RSAPrivateKey';
  fn_SSL_use_RSAPrivateKey_ASN1 = 'SSL_use_RSAPrivateKey_ASN1';
  fn_SSL_use_PrivateKey = 'SSL_use_PrivateKey';
  fn_SSL_use_PrivateKey_ASN1 = 'SSL_use_PrivateKey_ASN1';
  fn_SSL_use_certificate = 'SSL_use_certificate';
  fn_SSL_use_certificate_ASN1 = 'SSL_use_certificate_ASN1';
  fn_SSL_use_RSAPrivateKey_file = 'SSL_use_RSAPrivateKey_file';
  fn_SSL_use_PrivateKey_file = 'SSL_use_PrivateKey_file';
  fn_SSL_use_certificate_file = 'SSL_use_certificate_file';
  fn_SSL_CTX_use_RSAPrivateKey_file = 'SSL_CTX_use_RSAPrivateKey_file';
  fn_SSL_CTX_use_PrivateKey_file = 'SSL_CTX_use_PrivateKey_file';
  fn_SSL_CTX_use_certificate_file = 'SSL_CTX_use_certificate_file';
  fn_SSL_CTX_use_certificate_chain_file = 'SSL_CTX_use_certificate_chain_file';
  fn_SSL_load_client_CA_file = 'SSL_load_client_CA_file';
  fn_SSL_add_file_cert_subjects_to_stack = 'SSL_add_file_cert_subjects_to_stack';
  fn_ERR_load_SSL_strings = 'ERR_load_SSL_strings';
  fn_SSL_load_error_strings = 'SSL_load_error_strings';
  fn_SSL_state_string = 'SSL_state_string';
  fn_SSL_rstate_string = 'SSL_rstate_string';
  fn_SSL_state_string_long = 'SSL_state_string_long';
  fn_SSL_rstate_string_long = 'SSL_rstate_string_long';
  fn_SSL_SESSION_get_time = 'SSL_SESSION_get_time';
  fn_SSL_SESSION_set_time = 'SSL_SESSION_set_time';
  fn_SSL_SESSION_get_timeout = 'SSL_SESSION_get_timeout';
  fn_SSL_SESSION_set_timeout = 'SSL_SESSION_set_timeout';
  fn_SSL_copy_session_id = 'SSL_copy_session_id';
  fn_SSL_SESSION_new = 'SSL_SESSION_new';
  fn_SSL_SESSION_hash = 'SSL_SESSION_hash';
  fn_SSL_SESSION_cmp = 'SSL_SESSION_cmp';
  fn_SSL_SESSION_print_fp = 'SSL_SESSION_print_fp';
  fn_SSL_SESSION_print = 'SSL_SESSION_print';
  fn_SSL_SESSION_free = 'SSL_SESSION_free';
  fn_i2d_SSL_SESSION = 'i2d_SSL_SESSION';
  fn_SSL_set_session = 'SSL_set_session';
  fn_SSL_CTX_add_session = 'SSL_CTX_add_session';
  fn_SSL_CTX_remove_session = 'SSL_CTX_remove_session';
  fn_d2i_SSL_SESSION = 'd2i_SSL_SESSION';
  fn_SSL_get_peer_certificate = 'SSL_get_peer_certificate';
  fn_SSL_get_peer_cert_chain = 'SSL_get_peer_cert_chain';
  fn_SSL_CTX_get_verify_mode = 'SSL_CTX_get_verify_mode';
  fn_SSL_CTX_get_verify_depth = 'SSL_CTX_get_verify_depth';
  fn_SSL_CTX_set_verify = 'SSL_CTX_set_verify';
  fn_SSL_CTX_set_verify_depth = 'SSL_CTX_set_verify_depth';
  fn_SSL_CTX_set_cert_verify_callback = 'SSL_CTX_set_cert_verify_callback';
  fn_SSL_CTX_use_RSAPrivateKey = 'SSL_CTX_use_RSAPrivateKey';
  fn_SSL_CTX_use_RSAPrivateKey_ASN1 = 'SSL_CTX_use_RSAPrivateKey_ASN1';
  fn_SSL_CTX_use_PrivateKey = 'SSL_CTX_use_PrivateKey';
  fn_SSL_CTX_use_PrivateKey_ASN1 = 'SSL_CTX_use_PrivateKey_ASN1';
  fn_SSL_CTX_use_certificate = 'SSL_CTX_use_certificate';
  fn_SSL_CTX_use_certificate_ASN1 = 'SSL_CTX_use_certificate_ASN1';
  fn_SSL_CTX_set_default_passwd_cb = 'SSL_CTX_set_default_passwd_cb';
  fn_SSL_CTX_set_default_passwd_cb_userdata = 'SSL_CTX_set_default_passwd_cb_userdata';
  fn_SSL_CTX_check_private_key = 'SSL_CTX_check_private_key';
  fn_SSL_check_private_key = 'SSL_check_private_key';
  fn_SSL_CTX_set_session_id_context = 'SSL_CTX_set_session_id_context';
  fn_SSL_new = 'SSL_new';
  fn_SSL_set_session_id_context = 'SSL_set_session_id_context';
  fn_SSL_free = 'SSL_free';
  fn_SSL_accept = 'SSL_accept';
  fn_SSL_connect = 'SSL_connect';
  fn_SSL_read = 'SSL_read';
  fn_SSL_peek = 'SSL_peek';
  fn_SSL_write = 'SSL_write';
  fn_SSL_ctrl = 'SSL_ctrl';
  fn_SSL_CTX_ctrl = 'SSL_CTX_ctrl';
  fn_SSL_get_error = 'SSL_get_error';
  fn_SSL_get_version = 'SSL_get_version';
  fn_SSL_CTX_set_ssl_version = 'SSL_CTX_set_ssl_version';
  fn_SSLv2_method = 'SSLv2_method';
  fn_SSLv2_server_method = 'SSLv2_server_method';
  fn_SSLv2_client_method = 'SSLv2_client_method';
  fn_SSLv3_method = 'SSLv3_method';
  fn_SSLv3_server_method = 'SSLv3_server_method';
  fn_SSLv3_client_method = 'SSLv3_client_method';
  fn_SSLv23_method = 'SSLv23_method';
  fn_SSLv23_server_method = 'SSLv23_server_method';
  fn_SSLv23_client_method = 'SSLv23_client_method';
  fn_TLSv1_method = 'TLSv1_method';
  fn_TLSv1_server_method = 'TLSv1_server_method';
  fn_TLSv1_client_method = 'TLSv1_client_method';
  fn_SSL_get_ciphers = 'SSL_get_ciphers';
  fn_SSL_do_handshake = 'SSL_do_handshake';
  fn_SSL_renegotiate = 'SSL_renegotiate';
  fn_SSL_shutdown = 'SSL_shutdown';
  fn_SSL_get_ssl_method = 'SSL_get_ssl_method';
  fn_SSL_set_ssl_method = 'SSL_set_ssl_method';
  fn_SSL_alert_type_string_long = 'SSL_alert_type_string_long';
  fn_SSL_alert_type_string = 'SSL_alert_type_string';
  fn_SSL_alert_desc_string_long = 'SSL_alert_desc_string_long';
  fn_SSL_alert_desc_string = 'SSL_alert_desc_string';
  fn_SSL_set_client_CA_list = 'SSL_set_client_CA_list';
  fn_SSL_CTX_set_client_CA_list = 'SSL_CTX_set_client_CA_list';
  fn_SSL_get_client_CA_list = 'SSL_get_client_CA_list';
  fn_SSL_CTX_get_client_CA_list = 'SSL_CTX_get_client_CA_list';
  fn_SSL_add_client_CA = 'SSL_add_client_CA';
  fn_SSL_CTX_add_client_CA = 'SSL_CTX_add_client_CA';
  fn_SSL_set_connect_state = 'SSL_set_connect_state';
  fn_SSL_set_accept_state = 'SSL_set_accept_state';
  fn_SSL_get_default_timeout = 'SSL_get_default_timeout';
  fn_SSL_library_init = 'SSL_library_init';
  fn_SSL_CIPHER_description = 'SSL_CIPHER_description';
  fn_SSL_dup_CA_list = 'SSL_dup_CA_list';
  fn_SSL_dup = 'SSL_dup';
  fn_SSL_get_certificate = 'SSL_get_certificate';
  fn_SSL_get_privatekey = 'SSL_get_privatekey';
  fn_SSL_CTX_set_quiet_shutdown = 'SSL_CTX_set_quiet_shutdown';
  fn_SSL_CTX_get_quiet_shutdown = 'SSL_CTX_get_quiet_shutdown';
  fn_SSL_set_quiet_shutdown = 'SSL_set_quiet_shutdown';
  fn_SSL_get_quiet_shutdown = 'SSL_get_quiet_shutdown';
  fn_SSL_set_shutdown = 'SSL_set_shutdown';
  fn_SSL_get_shutdown = 'SSL_get_shutdown';
  fn_SSL_version = 'SSL_version';
  fn_SSL_CTX_set_default_verify_paths = 'SSL_CTX_set_default_verify_paths';
  fn_SSL_CTX_load_verify_locations = 'SSL_CTX_load_verify_locations';
  fn_SSL_get_session = 'SSL_get_session';
  fn_SSL_get_SSL_CTX = 'SSL_get_SSL_CTX';
  fn_SSL_set_info_callback = 'SSL_set_info_callback';
  fn_SSL_state = 'SSL_state';
  fn_SSL_set_verify_result = 'SSL_set_verify_result';
  fn_SSL_get_verify_result = 'SSL_get_verify_result';
  fn_SSL_set_ex_data = 'SSL_set_ex_data';
  fn_SSL_get_ex_data = 'SSL_get_ex_data';
  fn_SSL_get_ex_new_index = 'SSL_get_ex_new_index';
  fn_SSL_SESSION_set_ex_data = 'SSL_SESSION_set_ex_data';
  fn_SSL_SESSION_get_ex_data = 'SSL_SESSION_get_ex_data';
  fn_SSL_SESSION_get_ex_new_index = 'SSL_SESSION_get_ex_new_index';
  fn_SSL_CTX_set_ex_data = 'SSL_CTX_set_ex_data';
  fn_SSL_CTX_get_ex_data = 'SSL_CTX_get_ex_data';
  fn_SSL_CTX_get_ex_new_index = 'SSL_CTX_get_ex_new_index';
  fn_SSL_get_ex_data_X509_STORE_CTX_idx = 'SSL_get_ex_data_X509_STORE_CTX_idx';
  fn_SSL_CTX_set_tmp_rsa_callback = 'SSL_CTX_set_tmp_rsa_callback';
  fn_SSL_set_tmp_rsa_callback = 'SSL_set_tmp_rsa_callback';
  fn_SSL_CTX_set_tmp_dh_callback = 'SSL_CTX_set_tmp_dh_callback';
  fn_SSL_set_tmp_dh_callback = 'SSL_set_tmp_dh_callback';
  fn_SSL_COMP_add_compression_method = 'SSL_COMP_add_compression_method';
  fn_SSLeay_add_ssl_algorithms = 'mi_SSLeay_add_ssl_algorithms';
  fn_SSL_set_app_data = 'mi_SSL_set_app_data';
  fn_SSL_get_app_data = 'mi_SSL_get_app_data';
  fn_SSL_CTX_set_info_callback = 'mi_SSL_CTX_set_info_callback';
  fn_SSL_CTX_set_options = 'mi_SSL_CTX_set_options';
  fn_SSL_is_init_finished = 'mi_SSL_is_init_finished';
  fn_SSL_in_init = 'mi_SSL_in_init';
  fn_SSL_in_before = 'mi_SSL_in_before';
  fn_SSL_in_connect_init = 'mi_SSL_in_connect_init';
  fn_SSL_in_accept_init = 'mi_SSL_in_accept_init';
  fn_X509_STORE_CTX_get_app_data = 'mi_X509_STORE_CTX_get_app_data';
  fn_X509_get_notBefore = 'mi_X509_get_notBefore';
  fn_X509_get_notAfter = 'mi_X509_get_notAfter';
  fn_UCTTimeDecode = 'mi_UCTTimeDecode';
  fn_SSL_CTX_get_version = 'mi_SSL_CTX_get_version';
  fn_SSL_SESSION_get_id = 'mi_SSL_SESSION_get_id';
  fn_SSL_SESSION_get_id_ctx = 'mi_SSL_SESSION_get_id_ctx';
  fn_fopen = 'mi_fopen';
  fn_fclose = 'mi_fclose';


{$IFDEF MySSL_STATIC}
  function  f_sk_num(arg0: PSTACK):Integer; external MySSL_DLL_name name fn_sk_num;
  function  f_sk_value(arg0: PSTACK; arg1: Integer):PChar; external MySSL_DLL_name name fn_sk_value;
  function  f_sk_set(arg0: PSTACK; arg1: Integer; arg2: PChar):PChar; external MySSL_DLL_name name fn_sk_set;
  function  f_sk_new(arg0: PFunction):PSTACK; external MySSL_DLL_name name fn_sk_new;
  procedure f_sk_free(arg0: PSTACK); external MySSL_DLL_name name fn_sk_free;
  procedure f_sk_pop_free(st: PSTACK; arg1: PFunction); external MySSL_DLL_name name fn_sk_pop_free;
  function  f_sk_insert(sk: PSTACK; data: PChar; where: Integer):Integer; external MySSL_DLL_name name fn_sk_insert;
  function  f_sk_delete(st: PSTACK; loc: Integer):PChar; external MySSL_DLL_name name fn_sk_delete;
  function  f_sk_delete_ptr(st: PSTACK; p: PChar):PChar; external MySSL_DLL_name name fn_sk_delete_ptr;
  function  f_sk_find(st: PSTACK; data: PChar):Integer; external MySSL_DLL_name name fn_sk_find;
  function  f_sk_push(st: PSTACK; data: PChar):Integer; external MySSL_DLL_name name fn_sk_push;
  function  f_sk_unshift(st: PSTACK; data: PChar):Integer; external MySSL_DLL_name name fn_sk_unshift;
  function  f_sk_shift(st: PSTACK):PChar; external MySSL_DLL_name name fn_sk_shift;
  function  f_sk_pop(st: PSTACK):PChar; external MySSL_DLL_name name fn_sk_pop;
  procedure f_sk_zero(st: PSTACK); external MySSL_DLL_name name fn_sk_zero;
  function  f_sk_dup(st: PSTACK):PSTACK; external MySSL_DLL_name name fn_sk_dup;
  procedure f_sk_sort(st: PSTACK); external MySSL_DLL_name name fn_sk_sort;
  function  f_SSLeay_version(_type: Integer):PChar; external MySSL_DLL_name name fn_SSLeay_version;
  function  f_SSLeay:Cardinal; external MySSL_DLL_name name fn_SSLeay;
  function  f_CRYPTO_get_ex_new_index(idx: Integer; sk: PPSTACK; argl: Longint; argp: PChar; arg4: PFunction; arg5: PFunction; arg6: PFunction):Integer; external MySSL_DLL_name name fn_CRYPTO_get_ex_new_index;
  function  f_CRYPTO_set_ex_data(ad: PCRYPTO_EX_DATA; idx: Integer; val: PChar):Integer; external MySSL_DLL_name name fn_CRYPTO_set_ex_data;
  function  f_CRYPTO_get_ex_data(ad: PCRYPTO_EX_DATA; idx: Integer):PChar; external MySSL_DLL_name name fn_CRYPTO_get_ex_data;
  function  f_CRYPTO_dup_ex_data(meth: PSTACK; from: PCRYPTO_EX_DATA; _to: PCRYPTO_EX_DATA):Integer; external MySSL_DLL_name name fn_CRYPTO_dup_ex_data;
  procedure f_CRYPTO_free_ex_data(meth: PSTACK; obj: PChar; ad: PCRYPTO_EX_DATA); external MySSL_DLL_name name fn_CRYPTO_free_ex_data;
  procedure f_CRYPTO_new_ex_data(meth: PSTACK; obj: PChar; ad: PCRYPTO_EX_DATA); external MySSL_DLL_name name fn_CRYPTO_new_ex_data;
  function  f_CRYPTO_mem_ctrl(mode: Integer):Integer; external MySSL_DLL_name name fn_CRYPTO_mem_ctrl;
  function  f_CRYPTO_get_new_lockid(name: PChar):Integer; external MySSL_DLL_name name fn_CRYPTO_get_new_lockid;
  function  f_CRYPTO_num_locks:Integer; external MySSL_DLL_name name fn_CRYPTO_num_locks;
  procedure f_CRYPTO_lock(mode: Integer; _type: Integer; const _file: PChar; line: Integer); external MySSL_DLL_name name fn_CRYPTO_lock;
  procedure f_CRYPTO_set_locking_callback(arg0: PFunction); external MySSL_DLL_name name fn_CRYPTO_set_locking_callback;
  procedure f_CRYPTO_set_add_lock_callback(arg0: PFunction); external MySSL_DLL_name name fn_CRYPTO_set_add_lock_callback;
  procedure f_CRYPTO_set_id_callback(arg0: PFunction); external MySSL_DLL_name name fn_CRYPTO_set_id_callback;
  function  f_CRYPTO_thread_id:Cardinal; external MySSL_DLL_name name fn_CRYPTO_thread_id;
  function  f_CRYPTO_get_lock_name(_type: Integer):PChar; external MySSL_DLL_name name fn_CRYPTO_get_lock_name;
  function  f_CRYPTO_add_lock(pointer: PInteger; amount: Integer; _type: Integer; const _file: PChar; line: Integer):Integer; external MySSL_DLL_name name fn_CRYPTO_add_lock;
  procedure f_CRYPTO_set_mem_functions(arg0: PFunction; arg1: PFunction; arg2: PFunction); external MySSL_DLL_name name fn_CRYPTO_set_mem_functions;
  procedure f_CRYPTO_get_mem_functions(arg0: PFunction; arg1: PFunction; arg2: PFunction); external MySSL_DLL_name name fn_CRYPTO_get_mem_functions;
  procedure f_CRYPTO_set_locked_mem_functions(arg0: PFunction; arg1: PFunction); external MySSL_DLL_name name fn_CRYPTO_set_locked_mem_functions;
  procedure f_CRYPTO_get_locked_mem_functions(arg0: PFunction; arg1: PFunction); external MySSL_DLL_name name fn_CRYPTO_get_locked_mem_functions;
  function  f_CRYPTO_malloc_locked(num: Integer):Pointer; external MySSL_DLL_name name fn_CRYPTO_malloc_locked;
  procedure f_CRYPTO_free_locked(arg0: Pointer); external MySSL_DLL_name name fn_CRYPTO_free_locked;
  function  f_CRYPTO_malloc(num: Integer):Pointer; external MySSL_DLL_name name fn_CRYPTO_malloc;
  procedure f_CRYPTO_free(arg0: Pointer); external MySSL_DLL_name name fn_CRYPTO_free;
  function  f_CRYPTO_realloc(addr: Pointer; num: Integer):Pointer; external MySSL_DLL_name name fn_CRYPTO_realloc;
  function  f_CRYPTO_remalloc(addr: Pointer; num: Integer):Pointer; external MySSL_DLL_name name fn_CRYPTO_remalloc;
  function  f_CRYPTO_dbg_malloc(num: Integer; const _file: PChar; line: Integer):Pointer; external MySSL_DLL_name name fn_CRYPTO_dbg_malloc;
  function  f_CRYPTO_dbg_realloc(addr: Pointer; num: Integer; const _file: PChar; line: Integer):Pointer; external MySSL_DLL_name name fn_CRYPTO_dbg_realloc;
  procedure f_CRYPTO_dbg_free(arg0: Pointer); external MySSL_DLL_name name fn_CRYPTO_dbg_free;
  function  f_CRYPTO_dbg_remalloc(addr: Pointer; num: Integer; const _file: PChar; line: Integer):Pointer; external MySSL_DLL_name name fn_CRYPTO_dbg_remalloc;
  procedure f_CRYPTO_mem_leaks_fp(arg0: PFILE); external MySSL_DLL_name name fn_CRYPTO_mem_leaks_fp;
  procedure f_CRYPTO_mem_leaks(bio: Pbio_st); external MySSL_DLL_name name fn_CRYPTO_mem_leaks;
  procedure f_CRYPTO_mem_leaks_cb(arg0: PFunction); external MySSL_DLL_name name fn_CRYPTO_mem_leaks_cb;
  procedure f_ERR_load_CRYPTO_strings; external MySSL_DLL_name name fn_ERR_load_CRYPTO_strings;
  function  f_lh_new(arg0: PFunction; arg1: PFunction):PLHASH; external MySSL_DLL_name name fn_lh_new;
  procedure f_lh_free(lh: PLHASH); external MySSL_DLL_name name fn_lh_free;
  function  f_lh_insert(lh: PLHASH; data: PChar):PChar; external MySSL_DLL_name name fn_lh_insert;
  function  f_lh_delete(lh: PLHASH; data: PChar):PChar; external MySSL_DLL_name name fn_lh_delete;
  function  f_lh_retrieve(lh: PLHASH; data: PChar):PChar; external MySSL_DLL_name name fn_lh_retrieve;
  procedure f_lh_doall(lh: PLHASH; arg1: PFunction); external MySSL_DLL_name name fn_lh_doall;
  procedure f_lh_doall_arg(lh: PLHASH; arg1: PFunction; arg: PChar); external MySSL_DLL_name name fn_lh_doall_arg;
  function  f_lh_strhash(const c: PChar):Cardinal; external MySSL_DLL_name name fn_lh_strhash;
  procedure f_lh_stats(lh: PLHASH; _out: PFILE); external MySSL_DLL_name name fn_lh_stats;
  procedure f_lh_node_stats(lh: PLHASH; _out: PFILE); external MySSL_DLL_name name fn_lh_node_stats;
  procedure f_lh_node_usage_stats(lh: PLHASH; _out: PFILE); external MySSL_DLL_name name fn_lh_node_usage_stats;
  function  f_BUF_MEM_new:PBUF_MEM; external MySSL_DLL_name name fn_BUF_MEM_new;
  procedure f_BUF_MEM_free(a: PBUF_MEM); external MySSL_DLL_name name fn_BUF_MEM_free;
  function  f_BUF_MEM_grow(str: PBUF_MEM; len: Integer):Integer; external MySSL_DLL_name name fn_BUF_MEM_grow;
  function  f_BUF_strdup(const str: PChar):PChar; external MySSL_DLL_name name fn_BUF_strdup;
  procedure f_ERR_load_BUF_strings; external MySSL_DLL_name name fn_ERR_load_BUF_strings;
  function  f_BIO_ctrl_pending(b: PBIO):size_t; external MySSL_DLL_name name fn_BIO_ctrl_pending;
  function  f_BIO_ctrl_wpending(b: PBIO):size_t; external MySSL_DLL_name name fn_BIO_ctrl_wpending;
  function  f_BIO_ctrl_get_write_guarantee(b: PBIO):size_t; external MySSL_DLL_name name fn_BIO_ctrl_get_write_guarantee;
  function  f_BIO_ctrl_get_read_request(b: PBIO):size_t; external MySSL_DLL_name name fn_BIO_ctrl_get_read_request;
  function  f_BIO_set_ex_data(bio: PBIO; idx: Integer; data: PChar):Integer; external MySSL_DLL_name name fn_BIO_set_ex_data;
  function  f_BIO_get_ex_data(bio: PBIO; idx: Integer):PChar; external MySSL_DLL_name name fn_BIO_get_ex_data;
  function  f_BIO_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; external MySSL_DLL_name name fn_BIO_get_ex_new_index;
  function  f_BIO_s_file:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_s_file;
  function  f_BIO_new_file(const filename: PChar; const mode: PChar):PBIO; external MySSL_DLL_name name fn_BIO_new_file;
  function  f_BIO_new_fp(stream: PFILE; close_flag: Integer):PBIO; external MySSL_DLL_name name fn_BIO_new_fp;
  function  f_BIO_new(_type: PBIO_METHOD):PBIO; external MySSL_DLL_name name fn_BIO_new;
  function  f_BIO_set(a: PBIO; _type: PBIO_METHOD):Integer; external MySSL_DLL_name name fn_BIO_set;
  function  f_BIO_free(a: PBIO):Integer; external MySSL_DLL_name name fn_BIO_free;
  function  f_BIO_read(b: PBIO; data: Pointer; len: Integer):Integer; external MySSL_DLL_name name fn_BIO_read;
  function  f_BIO_gets(bp: PBIO; buf: PChar; size: Integer):Integer; external MySSL_DLL_name name fn_BIO_gets;
  function  f_BIO_write(b: PBIO; const data: PChar; len: Integer):Integer; external MySSL_DLL_name name fn_BIO_write;
  function  f_BIO_puts(bp: PBIO; const buf: PChar):Integer; external MySSL_DLL_name name fn_BIO_puts;
  function  f_BIO_ctrl(bp: PBIO; cmd: Integer; larg: Longint; parg: Pointer):Longint; external MySSL_DLL_name name fn_BIO_ctrl;
  function  f_BIO_ptr_ctrl(bp: PBIO; cmd: Integer; larg: Longint):PChar; external MySSL_DLL_name name fn_BIO_ptr_ctrl;
  function  f_BIO_int_ctrl(bp: PBIO; cmd: Integer; larg: Longint; iarg: Integer):Longint; external MySSL_DLL_name name fn_BIO_int_ctrl;
  function  f_BIO_push(b: PBIO; append: PBIO):PBIO; external MySSL_DLL_name name fn_BIO_push;
  function  f_BIO_pop(b: PBIO):PBIO; external MySSL_DLL_name name fn_BIO_pop;
  procedure f_BIO_free_all(a: PBIO); external MySSL_DLL_name name fn_BIO_free_all;
  function  f_BIO_find_type(b: PBIO; bio_type: Integer):PBIO; external MySSL_DLL_name name fn_BIO_find_type;
  function  f_BIO_get_retry_BIO(bio: PBIO; reason: PInteger):PBIO; external MySSL_DLL_name name fn_BIO_get_retry_BIO;
  function  f_BIO_get_retry_reason(bio: PBIO):Integer; external MySSL_DLL_name name fn_BIO_get_retry_reason;
  function  f_BIO_dup_chain(_in: PBIO):PBIO; external MySSL_DLL_name name fn_BIO_dup_chain;
  function  f_BIO_debug_callback(bio: PBIO; cmd: Integer; const argp: PChar; argi: Integer; argl: Longint; ret: Longint):Longint; external MySSL_DLL_name name fn_BIO_debug_callback;
  function  f_BIO_s_mem:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_s_mem;
  function  f_BIO_s_socket:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_s_socket;
  function  f_BIO_s_connect:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_s_connect;
  function  f_BIO_s_accept:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_s_accept;
  function  f_BIO_s_fd:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_s_fd;
  function  f_BIO_s_bio:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_s_bio;
  function  f_BIO_s_null:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_s_null;
  function  f_BIO_f_null:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_f_null;
  function  f_BIO_f_buffer:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_f_buffer;
  function  f_BIO_f_nbio_test:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_f_nbio_test;
  function  f_BIO_sock_should_retry(i: Integer):Integer; external MySSL_DLL_name name fn_BIO_sock_should_retry;
  function  f_BIO_sock_non_fatal_error(error: Integer):Integer; external MySSL_DLL_name name fn_BIO_sock_non_fatal_error;
  function  f_BIO_fd_should_retry(i: Integer):Integer; external MySSL_DLL_name name fn_BIO_fd_should_retry;
  function  f_BIO_fd_non_fatal_error(error: Integer):Integer; external MySSL_DLL_name name fn_BIO_fd_non_fatal_error;
  function  f_BIO_dump(b: PBIO; const bytes: PChar; len: Integer):Integer; external MySSL_DLL_name name fn_BIO_dump;
  function  f_BIO_gethostbyname(const name: PChar):Phostent2; external MySSL_DLL_name name fn_BIO_gethostbyname;
  function  f_BIO_sock_error(sock: Integer):Integer; external MySSL_DLL_name name fn_BIO_sock_error;
  function  f_BIO_socket_ioctl(fd: Integer; _type: Longint; arg: PULong):Integer; external MySSL_DLL_name name fn_BIO_socket_ioctl;
  function  f_BIO_socket_nbio(fd: Integer; mode: Integer):Integer; external MySSL_DLL_name name fn_BIO_socket_nbio;
  function  f_BIO_get_port(const str: PChar; port_ptr: PUShort):Integer; external MySSL_DLL_name name fn_BIO_get_port;
  function  f_BIO_get_host_ip(const str: PChar; ip: PChar):Integer; external MySSL_DLL_name name fn_BIO_get_host_ip;
  function  f_BIO_get_accept_socket(host_port: PChar; mode: Integer):Integer; external MySSL_DLL_name name fn_BIO_get_accept_socket;
  function  f_BIO_accept(sock: Integer; ip_port: PPChar):Integer; external MySSL_DLL_name name fn_BIO_accept;
  function  f_BIO_sock_init:Integer; external MySSL_DLL_name name fn_BIO_sock_init;
  procedure f_BIO_sock_cleanup; external MySSL_DLL_name name fn_BIO_sock_cleanup;
  function  f_BIO_set_tcp_ndelay(sock: Integer; turn_on: Integer):Integer; external MySSL_DLL_name name fn_BIO_set_tcp_ndelay;
  procedure f_ERR_load_BIO_strings; external MySSL_DLL_name name fn_ERR_load_BIO_strings;
  function  f_BIO_new_socket(sock: Integer; close_flag: Integer):PBIO; external MySSL_DLL_name name fn_BIO_new_socket;
  function  f_BIO_new_fd(fd: Integer; close_flag: Integer):PBIO; external MySSL_DLL_name name fn_BIO_new_fd;
  function  f_BIO_new_connect(host_port: PChar):PBIO; external MySSL_DLL_name name fn_BIO_new_connect;
  function  f_BIO_new_accept(host_port: PChar):PBIO; external MySSL_DLL_name name fn_BIO_new_accept;
  function  f_BIO_new_bio_pair(bio1: PPBIO; writebuf1: size_t; bio2: PPBIO; writebuf2: size_t):Integer; external MySSL_DLL_name name fn_BIO_new_bio_pair;
  procedure f_BIO_copy_next_retry(b: PBIO); external MySSL_DLL_name name fn_BIO_copy_next_retry;
  function  f_BIO_ghbn_ctrl(cmd: Integer; iarg: Integer; parg: PChar):Longint; external MySSL_DLL_name name fn_BIO_ghbn_ctrl;
  function  f_MD2_options:PChar; external MySSL_DLL_name name fn_MD2_options;
  procedure f_MD2_Init(c: PMD2_CTX); external MySSL_DLL_name name fn_MD2_Init;
  procedure f_MD2_Update(c: PMD2_CTX; data: PChar; len: Cardinal); external MySSL_DLL_name name fn_MD2_Update;
  procedure f_MD2_Final(md: PChar; c: PMD2_CTX); external MySSL_DLL_name name fn_MD2_Final;
  function  f_MD2(d: PChar; n: Cardinal; md: PChar):PChar; external MySSL_DLL_name name fn_MD2;
  procedure f_MD5_Init(c: PMD5_CTX); external MySSL_DLL_name name fn_MD5_Init;
  procedure f_MD5_Update(c: PMD5_CTX; const data: PChar; len: Cardinal); external MySSL_DLL_name name fn_MD5_Update;
  procedure f_MD5_Final(md: PChar; c: PMD5_CTX); external MySSL_DLL_name name fn_MD5_Final;
  function  f_MD5(d: PChar; n: Cardinal; md: PChar):PChar; external MySSL_DLL_name name fn_MD5;
  procedure f_MD5_Transform(c: PMD5_CTX; const b: PChar); external MySSL_DLL_name name fn_MD5_Transform;
  procedure f_SHA_Init(c: PSHA_CTX); external MySSL_DLL_name name fn_SHA_Init;
  procedure f_SHA_Update(c: PSHA_CTX; const data: PChar; len: Cardinal); external MySSL_DLL_name name fn_SHA_Update;
  procedure f_SHA_Final(md: PChar; c: PSHA_CTX); external MySSL_DLL_name name fn_SHA_Final;
  function  f_SHA(const d: PChar; n: Cardinal; md: PChar):PChar; external MySSL_DLL_name name fn_SHA;
  procedure f_SHA_Transform(c: PSHA_CTX; data: PChar); external MySSL_DLL_name name fn_SHA_Transform;
  procedure f_SHA1_Init(c: PSHA_CTX); external MySSL_DLL_name name fn_SHA1_Init;
  procedure f_SHA1_Update(c: PSHA_CTX; const data: PChar; len: Cardinal); external MySSL_DLL_name name fn_SHA1_Update;
  procedure f_SHA1_Final(md: PChar; c: PSHA_CTX); external MySSL_DLL_name name fn_SHA1_Final;
  function  f_SHA1(const d: PChar; n: Cardinal; md: PChar):PChar; external MySSL_DLL_name name fn_SHA1;
  procedure f_SHA1_Transform(c: PSHA_CTX; data: PChar); external MySSL_DLL_name name fn_SHA1_Transform;
  procedure f_RIPEMD160_Init(c: PRIPEMD160_CTX); external MySSL_DLL_name name fn_RIPEMD160_Init;
  procedure f_RIPEMD160_Update(c: PRIPEMD160_CTX; data: PChar; len: Cardinal); external MySSL_DLL_name name fn_RIPEMD160_Update;
  procedure f_RIPEMD160_Final(md: PChar; c: PRIPEMD160_CTX); external MySSL_DLL_name name fn_RIPEMD160_Final;
  function  f_RIPEMD160(d: PChar; n: Cardinal; md: PChar):PChar; external MySSL_DLL_name name fn_RIPEMD160;
  procedure f_RIPEMD160_Transform(c: PRIPEMD160_CTX; b: PChar); external MySSL_DLL_name name fn_RIPEMD160_Transform;
  function  f_des_options:PChar; external MySSL_DLL_name name fn_des_options;
  procedure f_des_ecb3_encrypt(const input: P_des_cblock; output: Pdes_cblock; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; enc: Integer); external MySSL_DLL_name name fn_des_ecb3_encrypt;
  function  f_des_cbc_cksum(const input: PChar; output: Pdes_cblock; length: Longint; schedule: des_key_schedule; const ivec: P_des_cblock):Cardinal; external MySSL_DLL_name name fn_des_cbc_cksum;
  procedure f_des_cbc_encrypt(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer); external MySSL_DLL_name name fn_des_cbc_encrypt;
  procedure f_des_ncbc_encrypt(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer); external MySSL_DLL_name name fn_des_ncbc_encrypt;
  procedure f_des_xcbc_encrypt(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; const inw: P_des_cblock; const outw: P_des_cblock; enc: Integer); external MySSL_DLL_name name fn_des_xcbc_encrypt;
  procedure f_des_cfb_encrypt(const _in: PChar; _out: PChar; numbits: Integer; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer); external MySSL_DLL_name name fn_des_cfb_encrypt;
  procedure f_des_ecb_encrypt(const input: P_des_cblock; output: Pdes_cblock; ks: des_key_schedule; enc: Integer); external MySSL_DLL_name name fn_des_ecb_encrypt;
  procedure f_des_encrypt(data: PULong; ks: des_key_schedule; enc: Integer); external MySSL_DLL_name name fn_des_encrypt;
  procedure f_des_encrypt2(data: PULong; ks: des_key_schedule; enc: Integer); external MySSL_DLL_name name fn_des_encrypt2;
  procedure f_des_encrypt3(data: PULong; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule); external MySSL_DLL_name name fn_des_encrypt3;
  procedure f_des_decrypt3(data: PULong; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule); external MySSL_DLL_name name fn_des_decrypt3;
  procedure f_des_ede3_cbc_encrypt(const input: PChar; output: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec: Pdes_cblock; enc: Integer); external MySSL_DLL_name name fn_des_ede3_cbc_encrypt;
  procedure f_des_ede3_cbcm_encrypt(const _in: PChar; _out: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec1: Pdes_cblock; ivec2: Pdes_cblock; enc: Integer); external MySSL_DLL_name name fn_des_ede3_cbcm_encrypt;
  procedure f_des_ede3_cfb64_encrypt(const _in: PChar; _out: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec: Pdes_cblock; num: PInteger; enc: Integer); external MySSL_DLL_name name fn_des_ede3_cfb64_encrypt;
  procedure f_des_ede3_ofb64_encrypt(const _in: PChar; _out: PChar; length: Longint; ks1: des_key_schedule; ks2: des_key_schedule; ks3: des_key_schedule; ivec: Pdes_cblock; num: PInteger); external MySSL_DLL_name name fn_des_ede3_ofb64_encrypt;
  procedure f_des_xwhite_in2out(const des_key: P_des_cblock; const in_white: P_des_cblock; out_white: Pdes_cblock); external MySSL_DLL_name name fn_des_xwhite_in2out;
  function  f_des_enc_read(fd: Integer; buf: Pointer; len: Integer; sched: des_key_schedule; iv: Pdes_cblock):Integer; external MySSL_DLL_name name fn_des_enc_read;
  function  f_des_enc_write(fd: Integer; const buf: Pointer; len: Integer; sched: des_key_schedule; iv: Pdes_cblock):Integer; external MySSL_DLL_name name fn_des_enc_write;
  function  f_des_fcrypt(const buf: PChar; const salt: PChar; ret: PChar):PChar; external MySSL_DLL_name name fn_des_fcrypt;
  function  f_crypt(const buf: PChar; const salt: PChar):PChar; external MySSL_DLL_name name fn_crypt;
  procedure f_des_ofb_encrypt(const _in: PChar; _out: PChar; numbits: Integer; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock); external MySSL_DLL_name name fn_des_ofb_encrypt;
  procedure f_des_pcbc_encrypt(const input: PChar; output: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; enc: Integer); external MySSL_DLL_name name fn_des_pcbc_encrypt;
  function  f_des_quad_cksum(const input: PChar; output: des_cblock; length: Longint; out_count: Integer; seed: Pdes_cblock):Cardinal; external MySSL_DLL_name name fn_des_quad_cksum;
  procedure f_des_random_seed(key: Pdes_cblock); external MySSL_DLL_name name fn_des_random_seed;
  procedure f_des_random_key(ret: Pdes_cblock); external MySSL_DLL_name name fn_des_random_key;
  function  f_des_read_password(key: Pdes_cblock; const prompt: PChar; verify: Integer):Integer; external MySSL_DLL_name name fn_des_read_password;
  function  f_des_read_2passwords(key1: Pdes_cblock; key2: Pdes_cblock; const prompt: PChar; verify: Integer):Integer; external MySSL_DLL_name name fn_des_read_2passwords;
  function  f_des_read_pw_string(buf: PChar; length: Integer; const prompt: PChar; verify: Integer):Integer; external MySSL_DLL_name name fn_des_read_pw_string;
  procedure f_des_set_odd_parity(key: Pdes_cblock); external MySSL_DLL_name name fn_des_set_odd_parity;
  function  f_des_is_weak_key(const key: P_des_cblock):Integer; external MySSL_DLL_name name fn_des_is_weak_key;
  function  f_des_set_key(const key: P_des_cblock; schedule: des_key_schedule):Integer; external MySSL_DLL_name name fn_des_set_key;
  function  f_des_key_sched(const key: P_des_cblock; schedule: des_key_schedule):Integer; external MySSL_DLL_name name fn_des_key_sched;
  procedure f_des_string_to_key(const str: PChar; key: Pdes_cblock); external MySSL_DLL_name name fn_des_string_to_key;
  procedure f_des_string_to_2keys(const str: PChar; key1: Pdes_cblock; key2: Pdes_cblock); external MySSL_DLL_name name fn_des_string_to_2keys;
  procedure f_des_cfb64_encrypt(const _in: PChar; _out: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; num: PInteger; enc: Integer); external MySSL_DLL_name name fn_des_cfb64_encrypt;
  procedure f_des_ofb64_encrypt(const _in: PChar; _out: PChar; length: Longint; schedule: des_key_schedule; ivec: Pdes_cblock; num: PInteger); external MySSL_DLL_name name fn_des_ofb64_encrypt;
  function  f_des_read_pw(buf: PChar; buff: PChar; size: Integer; const prompt: PChar; verify: Integer):Integer; external MySSL_DLL_name name fn_des_read_pw;
  procedure f_des_cblock_print_file(const cb: P_des_cblock; fp: PFILE); external MySSL_DLL_name name fn_des_cblock_print_file;
  function  f_RC4_options:PChar; external MySSL_DLL_name name fn_RC4_options;
  procedure f_RC4_set_key(key: PRC4_KEY; len: Integer; data: PChar); external MySSL_DLL_name name fn_RC4_set_key;
  procedure f_RC4(key: PRC4_KEY; len: Cardinal; indata: PChar; outdata: PChar); external MySSL_DLL_name name fn_RC4;
  procedure f_RC2_set_key(key: PRC2_KEY; len: Integer; data: PChar; bits: Integer); external MySSL_DLL_name name fn_RC2_set_key;
  procedure f_RC2_ecb_encrypt(_in: PChar; _out: PChar; key: PRC2_KEY; enc: Integer); external MySSL_DLL_name name fn_RC2_ecb_encrypt;
  procedure f_RC2_encrypt(data: PULong; key: PRC2_KEY); external MySSL_DLL_name name fn_RC2_encrypt;
  procedure f_RC2_decrypt(data: PULong; key: PRC2_KEY); external MySSL_DLL_name name fn_RC2_decrypt;
  procedure f_RC2_cbc_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PRC2_KEY; iv: PChar; enc: Integer); external MySSL_DLL_name name fn_RC2_cbc_encrypt;
  procedure f_RC2_cfb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PRC2_KEY; ivec: PChar; num: PInteger; enc: Integer); external MySSL_DLL_name name fn_RC2_cfb64_encrypt;
  procedure f_RC2_ofb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PRC2_KEY; ivec: PChar; num: PInteger); external MySSL_DLL_name name fn_RC2_ofb64_encrypt;
  procedure f_RC5_32_set_key(key: PRC5_32_KEY; len: Integer; data: PChar; rounds: Integer); external MySSL_DLL_name name fn_RC5_32_set_key;
  procedure f_RC5_32_ecb_encrypt(_in: PChar; _out: PChar; key: PRC5_32_KEY; enc: Integer); external MySSL_DLL_name name fn_RC5_32_ecb_encrypt;
  procedure f_RC5_32_encrypt(data: PULong; key: PRC5_32_KEY); external MySSL_DLL_name name fn_RC5_32_encrypt;
  procedure f_RC5_32_decrypt(data: PULong; key: PRC5_32_KEY); external MySSL_DLL_name name fn_RC5_32_decrypt;
  procedure f_RC5_32_cbc_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PRC5_32_KEY; iv: PChar; enc: Integer); external MySSL_DLL_name name fn_RC5_32_cbc_encrypt;
  procedure f_RC5_32_cfb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PRC5_32_KEY; ivec: PChar; num: PInteger; enc: Integer); external MySSL_DLL_name name fn_RC5_32_cfb64_encrypt;
  procedure f_RC5_32_ofb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PRC5_32_KEY; ivec: PChar; num: PInteger); external MySSL_DLL_name name fn_RC5_32_ofb64_encrypt;
  procedure f_BF_set_key(key: PBF_KEY; len: Integer; data: PChar); external MySSL_DLL_name name fn_BF_set_key;
  procedure f_BF_ecb_encrypt(_in: PChar; _out: PChar; key: PBF_KEY; enc: Integer); external MySSL_DLL_name name fn_BF_ecb_encrypt;
  procedure f_BF_encrypt(data: PUInteger; key: PBF_KEY); external MySSL_DLL_name name fn_BF_encrypt;
  procedure f_BF_decrypt(data: PUInteger; key: PBF_KEY); external MySSL_DLL_name name fn_BF_decrypt;
  procedure f_BF_cbc_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PBF_KEY; iv: PChar; enc: Integer); external MySSL_DLL_name name fn_BF_cbc_encrypt;
  procedure f_BF_cfb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PBF_KEY; ivec: PChar; num: PInteger; enc: Integer); external MySSL_DLL_name name fn_BF_cfb64_encrypt;
  procedure f_BF_ofb64_encrypt(_in: PChar; _out: PChar; length: Longint; schedule: PBF_KEY; ivec: PChar; num: PInteger); external MySSL_DLL_name name fn_BF_ofb64_encrypt;
  function  f_BF_options:PChar; external MySSL_DLL_name name fn_BF_options;
  procedure f_CAST_set_key(key: PCAST_KEY; len: Integer; data: PChar); external MySSL_DLL_name name fn_CAST_set_key;
  procedure f_CAST_ecb_encrypt(const _in: PChar; _out: PChar; key: PCAST_KEY; enc: Integer); external MySSL_DLL_name name fn_CAST_ecb_encrypt;
  procedure f_CAST_encrypt(data: PULong; key: PCAST_KEY); external MySSL_DLL_name name fn_CAST_encrypt;
  procedure f_CAST_decrypt(data: PULong; key: PCAST_KEY); external MySSL_DLL_name name fn_CAST_decrypt;
  procedure f_CAST_cbc_encrypt(const _in: PChar; _out: PChar; length: Longint; ks: PCAST_KEY; iv: PChar; enc: Integer); external MySSL_DLL_name name fn_CAST_cbc_encrypt;
  procedure f_CAST_cfb64_encrypt(const _in: PChar; _out: PChar; length: Longint; schedule: PCAST_KEY; ivec: PChar; num: PInteger; enc: Integer); external MySSL_DLL_name name fn_CAST_cfb64_encrypt;
  procedure f_CAST_ofb64_encrypt(const _in: PChar; _out: PChar; length: Longint; schedule: PCAST_KEY; ivec: PChar; num: PInteger); external MySSL_DLL_name name fn_CAST_ofb64_encrypt;
  function  f_idea_options:PChar; external MySSL_DLL_name name fn_idea_options;
  procedure f_idea_ecb_encrypt(_in: PChar; _out: PChar; ks: PIDEA_KEY_SCHEDULE); external MySSL_DLL_name name fn_idea_ecb_encrypt;
  procedure f_idea_set_encrypt_key(key: PChar; ks: PIDEA_KEY_SCHEDULE); external MySSL_DLL_name name fn_idea_set_encrypt_key;
  procedure f_idea_set_decrypt_key(ek: PIDEA_KEY_SCHEDULE; dk: PIDEA_KEY_SCHEDULE); external MySSL_DLL_name name fn_idea_set_decrypt_key;
  procedure f_idea_cbc_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PIDEA_KEY_SCHEDULE; iv: PChar; enc: Integer); external MySSL_DLL_name name fn_idea_cbc_encrypt;
  procedure f_idea_cfb64_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PIDEA_KEY_SCHEDULE; iv: PChar; num: PInteger; enc: Integer); external MySSL_DLL_name name fn_idea_cfb64_encrypt;
  procedure f_idea_ofb64_encrypt(_in: PChar; _out: PChar; length: Longint; ks: PIDEA_KEY_SCHEDULE; iv: PChar; num: PInteger); external MySSL_DLL_name name fn_idea_ofb64_encrypt;
  procedure f_idea_encrypt(_in: PULong; ks: PIDEA_KEY_SCHEDULE); external MySSL_DLL_name name fn_idea_encrypt;
  procedure f_MDC2_Init(c: PMDC2_CTX); external MySSL_DLL_name name fn_MDC2_Init;
  procedure f_MDC2_Update(c: PMDC2_CTX; data: PChar; len: Cardinal); external MySSL_DLL_name name fn_MDC2_Update;
  procedure f_MDC2_Final(md: PChar; c: PMDC2_CTX); external MySSL_DLL_name name fn_MDC2_Final;
  function  f_MDC2(d: PChar; n: Cardinal; md: PChar):PChar; external MySSL_DLL_name name fn_MDC2;
  function  f_BN_value_one:PBIGNUM; external MySSL_DLL_name name fn_BN_value_one;
  function  f_BN_options:PChar; external MySSL_DLL_name name fn_BN_options;
  function  f_BN_CTX_new:PBN_CTX; external MySSL_DLL_name name fn_BN_CTX_new;
  procedure f_BN_CTX_init(c: PBN_CTX); external MySSL_DLL_name name fn_BN_CTX_init;
  procedure f_BN_CTX_free(c: PBN_CTX); external MySSL_DLL_name name fn_BN_CTX_free;
  function  f_BN_rand(rnd: PBIGNUM; bits: Integer; top: Integer; bottom: Integer):Integer; external MySSL_DLL_name name fn_BN_rand;
  function  f_BN_num_bits(const a: PBIGNUM):Integer; external MySSL_DLL_name name fn_BN_num_bits;
  function  f_BN_num_bits_word(arg0: Cardinal):Integer; external MySSL_DLL_name name fn_BN_num_bits_word;
  function  f_BN_new:PBIGNUM; external MySSL_DLL_name name fn_BN_new;
  procedure f_BN_init(arg0: PBIGNUM); external MySSL_DLL_name name fn_BN_init;
  procedure f_BN_clear_free(a: PBIGNUM); external MySSL_DLL_name name fn_BN_clear_free;
  function  f_BN_copy(a: PBIGNUM; const b: PBIGNUM):PBIGNUM; external MySSL_DLL_name name fn_BN_copy;
  function  f_BN_bin2bn(const s: PChar; len: Integer; ret: PBIGNUM):PBIGNUM; external MySSL_DLL_name name fn_BN_bin2bn;
  function  f_BN_bn2bin(const a: PBIGNUM; _to: PChar):Integer; external MySSL_DLL_name name fn_BN_bn2bin;
  function  f_BN_mpi2bn(s: PChar; len: Integer; ret: PBIGNUM):PBIGNUM; external MySSL_DLL_name name fn_BN_mpi2bn;
  function  f_BN_bn2mpi(const a: PBIGNUM; _to: PChar):Integer; external MySSL_DLL_name name fn_BN_bn2mpi;
  function  f_BN_sub(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM):Integer; external MySSL_DLL_name name fn_BN_sub;
  function  f_BN_usub(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM):Integer; external MySSL_DLL_name name fn_BN_usub;
  function  f_BN_uadd(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM):Integer; external MySSL_DLL_name name fn_BN_uadd;
  function  f_BN_add(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM):Integer; external MySSL_DLL_name name fn_BN_add;
  function  f_BN_mod(rem: PBIGNUM; const m: PBIGNUM; const d: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_mod;
  function  f_BN_div(dv: PBIGNUM; rem: PBIGNUM; const m: PBIGNUM; const d: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_div;
  function  f_BN_mul(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_mul;
  function  f_BN_sqr(r: PBIGNUM; a: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_sqr;
  function  f_BN_mod_word(a: PBIGNUM; w: Cardinal):Cardinal; external MySSL_DLL_name name fn_BN_mod_word;
  function  f_BN_div_word(a: PBIGNUM; w: Cardinal):Cardinal; external MySSL_DLL_name name fn_BN_div_word;
  function  f_BN_mul_word(a: PBIGNUM; w: Cardinal):Integer; external MySSL_DLL_name name fn_BN_mul_word;
  function  f_BN_add_word(a: PBIGNUM; w: Cardinal):Integer; external MySSL_DLL_name name fn_BN_add_word;
  function  f_BN_sub_word(a: PBIGNUM; w: Cardinal):Integer; external MySSL_DLL_name name fn_BN_sub_word;
  function  f_BN_set_word(a: PBIGNUM; w: Cardinal):Integer; external MySSL_DLL_name name fn_BN_set_word;
  function  f_BN_get_word(a: PBIGNUM):Cardinal; external MySSL_DLL_name name fn_BN_get_word;
  function  f_BN_cmp(const a: PBIGNUM; const b: PBIGNUM):Integer; external MySSL_DLL_name name fn_BN_cmp;
  procedure f_BN_free(a: PBIGNUM); external MySSL_DLL_name name fn_BN_free;
  function  f_BN_is_bit_set(const a: PBIGNUM; n: Integer):Integer; external MySSL_DLL_name name fn_BN_is_bit_set;
  function  f_BN_lshift(r: PBIGNUM; const a: PBIGNUM; n: Integer):Integer; external MySSL_DLL_name name fn_BN_lshift;
  function  f_BN_lshift1(r: PBIGNUM; a: PBIGNUM):Integer; external MySSL_DLL_name name fn_BN_lshift1;
  function  f_BN_exp(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_exp;
  function  f_BN_mod_exp(r: PBIGNUM; a: PBIGNUM; const p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_mod_exp;
  function  f_BN_mod_exp_mont(r: PBIGNUM; a: PBIGNUM; const p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX):Integer; external MySSL_DLL_name name fn_BN_mod_exp_mont;
  function  f_BN_mod_exp2_mont(r: PBIGNUM; a1: PBIGNUM; p1: PBIGNUM; a2: PBIGNUM; p2: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX):Integer; external MySSL_DLL_name name fn_BN_mod_exp2_mont;
  function  f_BN_mod_exp_simple(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_mod_exp_simple;
  function  f_BN_mask_bits(a: PBIGNUM; n: Integer):Integer; external MySSL_DLL_name name fn_BN_mask_bits;
  function  f_BN_mod_mul(ret: PBIGNUM; a: PBIGNUM; b: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_mod_mul;
  function  f_BN_print_fp(fp: PFILE; a: PBIGNUM):Integer; external MySSL_DLL_name name fn_BN_print_fp;
  function  f_BN_print(fp: PBIO; const a: PBIGNUM):Integer; external MySSL_DLL_name name fn_BN_print;
  function  f_BN_reciprocal(r: PBIGNUM; m: PBIGNUM; len: Integer; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_reciprocal;
  function  f_BN_rshift(r: PBIGNUM; a: PBIGNUM; n: Integer):Integer; external MySSL_DLL_name name fn_BN_rshift;
  function  f_BN_rshift1(r: PBIGNUM; a: PBIGNUM):Integer; external MySSL_DLL_name name fn_BN_rshift1;
  procedure f_BN_clear(a: PBIGNUM); external MySSL_DLL_name name fn_BN_clear;
  function  f_bn_expand2(b: PBIGNUM; bits: Integer):PBIGNUM; external MySSL_DLL_name name fn_bn_expand2;
  function  f_BN_dup(const a: PBIGNUM):PBIGNUM; external MySSL_DLL_name name fn_BN_dup;
  function  f_BN_ucmp(const a: PBIGNUM; const b: PBIGNUM):Integer; external MySSL_DLL_name name fn_BN_ucmp;
  function  f_BN_set_bit(a: PBIGNUM; n: Integer):Integer; external MySSL_DLL_name name fn_BN_set_bit;
  function  f_BN_clear_bit(a: PBIGNUM; n: Integer):Integer; external MySSL_DLL_name name fn_BN_clear_bit;
  function  f_BN_bn2hex(const a: PBIGNUM):PChar; external MySSL_DLL_name name fn_BN_bn2hex;
  function  f_BN_bn2dec(const a: PBIGNUM):PChar; external MySSL_DLL_name name fn_BN_bn2dec;
  function  f_BN_hex2bn(a: PPBIGNUM; const str: PChar):Integer; external MySSL_DLL_name name fn_BN_hex2bn;
  function  f_BN_dec2bn(a: PPBIGNUM; const str: PChar):Integer; external MySSL_DLL_name name fn_BN_dec2bn;
  function  f_BN_gcd(r: PBIGNUM; in_a: PBIGNUM; in_b: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_gcd;
  function  f_BN_mod_inverse(ret: PBIGNUM; a: PBIGNUM; const n: PBIGNUM; ctx: PBN_CTX):PBIGNUM; external MySSL_DLL_name name fn_BN_mod_inverse;
  function  f_BN_generate_prime(ret: PBIGNUM; bits: Integer; strong: Integer; add: PBIGNUM; rem: PBIGNUM; arg5: PFunction; cb_arg: Pointer):PBIGNUM; external MySSL_DLL_name name fn_BN_generate_prime;
  function  f_BN_is_prime(p: PBIGNUM; nchecks: Integer; arg2: PFunction; ctx: PBN_CTX; cb_arg: Pointer):Integer; external MySSL_DLL_name name fn_BN_is_prime;
  procedure f_ERR_load_BN_strings; external MySSL_DLL_name name fn_ERR_load_BN_strings;
  function  f_bn_mul_add_words(rp: PULong; ap: PULong; num: Integer; w: Cardinal):Cardinal; external MySSL_DLL_name name fn_bn_mul_add_words;
  function  f_bn_mul_words(rp: PULong; ap: PULong; num: Integer; w: Cardinal):Cardinal; external MySSL_DLL_name name fn_bn_mul_words;
  procedure f_bn_sqr_words(rp: PULong; ap: PULong; num: Integer); external MySSL_DLL_name name fn_bn_sqr_words;
  function  f_bn_div_words(h: Cardinal; l: Cardinal; d: Cardinal):Cardinal; external MySSL_DLL_name name fn_bn_div_words;
  function  f_bn_add_words(rp: PULong; ap: PULong; bp: PULong; num: Integer):Cardinal; external MySSL_DLL_name name fn_bn_add_words;
  function  f_bn_sub_words(rp: PULong; ap: PULong; bp: PULong; num: Integer):Cardinal; external MySSL_DLL_name name fn_bn_sub_words;
  function  f_BN_MONT_CTX_new:PBN_MONT_CTX; external MySSL_DLL_name name fn_BN_MONT_CTX_new;
  procedure f_BN_MONT_CTX_init(ctx: PBN_MONT_CTX); external MySSL_DLL_name name fn_BN_MONT_CTX_init;
  function  f_BN_mod_mul_montgomery(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_mod_mul_montgomery;
  function  f_BN_from_montgomery(r: PBIGNUM; a: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_from_montgomery;
  procedure f_BN_MONT_CTX_free(mont: PBN_MONT_CTX); external MySSL_DLL_name name fn_BN_MONT_CTX_free;
  function  f_BN_MONT_CTX_set(mont: PBN_MONT_CTX; const modulus: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_MONT_CTX_set;
  function  f_BN_MONT_CTX_copy(_to: PBN_MONT_CTX; from: PBN_MONT_CTX):PBN_MONT_CTX; external MySSL_DLL_name name fn_BN_MONT_CTX_copy;
  function  f_BN_BLINDING_new(A: PBIGNUM; Ai: PBIGNUM; _mod: PBIGNUM):PBN_BLINDING; external MySSL_DLL_name name fn_BN_BLINDING_new;
  procedure f_BN_BLINDING_free(b: PBN_BLINDING); external MySSL_DLL_name name fn_BN_BLINDING_free;
  function  f_BN_BLINDING_update(b: PBN_BLINDING; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_BLINDING_update;
  function  f_BN_BLINDING_convert(n: PBIGNUM; r: PBN_BLINDING; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_BLINDING_convert;
  function  f_BN_BLINDING_invert(n: PBIGNUM; b: PBN_BLINDING; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_BLINDING_invert;
  procedure f_BN_set_params(mul: Integer; high: Integer; low: Integer; mont: Integer); external MySSL_DLL_name name fn_BN_set_params;
  function  f_BN_get_params(which: Integer):Integer; external MySSL_DLL_name name fn_BN_get_params;
  procedure f_BN_RECP_CTX_init(recp: PBN_RECP_CTX); external MySSL_DLL_name name fn_BN_RECP_CTX_init;
  function  f_BN_RECP_CTX_new:PBN_RECP_CTX; external MySSL_DLL_name name fn_BN_RECP_CTX_new;
  procedure f_BN_RECP_CTX_free(recp: PBN_RECP_CTX); external MySSL_DLL_name name fn_BN_RECP_CTX_free;
  function  f_BN_RECP_CTX_set(recp: PBN_RECP_CTX; const rdiv: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_RECP_CTX_set;
  function  f_BN_mod_mul_reciprocal(r: PBIGNUM; x: PBIGNUM; y: PBIGNUM; recp: PBN_RECP_CTX; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_mod_mul_reciprocal;
  function  f_BN_mod_exp_recp(r: PBIGNUM; const a: PBIGNUM; const p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_mod_exp_recp;
  function  f_BN_div_recp(dv: PBIGNUM; rem: PBIGNUM; m: PBIGNUM; recp: PBN_RECP_CTX; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_BN_div_recp;
  function  f_RSA_new:PRSA; external MySSL_DLL_name name fn_RSA_new;
  function  f_RSA_new_method(method: PRSA_METHOD):PRSA; external MySSL_DLL_name name fn_RSA_new_method;
  function  f_RSA_size(arg0: PRSA):Integer; external MySSL_DLL_name name fn_RSA_size;
  function  f_RSA_generate_key(bits: Integer; e: Cardinal; arg2: PFunction; cb_arg: Pointer):PRSA; external MySSL_DLL_name name fn_RSA_generate_key;
  function  f_RSA_check_key(arg0: PRSA):Integer; external MySSL_DLL_name name fn_RSA_check_key;
  function  f_RSA_public_encrypt(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer; external MySSL_DLL_name name fn_RSA_public_encrypt;
  function  f_RSA_private_encrypt(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer; external MySSL_DLL_name name fn_RSA_private_encrypt;
  function  f_RSA_public_decrypt(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer; external MySSL_DLL_name name fn_RSA_public_decrypt;
  function  f_RSA_private_decrypt(flen: Integer; from: PChar; _to: PChar; rsa: PRSA; padding: Integer):Integer; external MySSL_DLL_name name fn_RSA_private_decrypt;
  procedure f_RSA_free(r: PRSA); external MySSL_DLL_name name fn_RSA_free;
  function  f_RSA_flags(r: PRSA):Integer; external MySSL_DLL_name name fn_RSA_flags;
  procedure f_RSA_set_default_method(meth: PRSA_METHOD); external MySSL_DLL_name name fn_RSA_set_default_method;
  function  f_RSA_get_default_method:PRSA_METHOD; external MySSL_DLL_name name fn_RSA_get_default_method;
  function  f_RSA_get_method(rsa: PRSA):PRSA_METHOD; external MySSL_DLL_name name fn_RSA_get_method;
  function  f_RSA_set_method(rsa: PRSA; meth: PRSA_METHOD):PRSA_METHOD; external MySSL_DLL_name name fn_RSA_set_method;
  function  f_RSA_memory_lock(r: PRSA):Integer; external MySSL_DLL_name name fn_RSA_memory_lock;
  function  f_RSA_PKCS1_SSLeay:PRSA_METHOD; external MySSL_DLL_name name fn_RSA_PKCS1_SSLeay;
  procedure f_ERR_load_RSA_strings; external MySSL_DLL_name name fn_ERR_load_RSA_strings;
  function  f_d2i_RSAPublicKey(a: PPRSA; pp: PPChar; length: Longint):PRSA; external MySSL_DLL_name name fn_d2i_RSAPublicKey;
  function  f_i2d_RSAPublicKey(a: PRSA; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_RSAPublicKey;
  function  f_d2i_RSAPrivateKey(a: PPRSA; pp: PPChar; length: Longint):PRSA; external MySSL_DLL_name name fn_d2i_RSAPrivateKey;
  function  f_i2d_RSAPrivateKey(a: PRSA; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_RSAPrivateKey;
  function  f_RSA_print_fp(fp: PFILE; r: PRSA; offset: Integer):Integer; external MySSL_DLL_name name fn_RSA_print_fp;
  function  f_RSA_print(bp: PBIO; r: PRSA; offset: Integer):Integer; external MySSL_DLL_name name fn_RSA_print;
  function  f_i2d_Netscape_RSA(a: PRSA; pp: PPChar; arg2: PFunction):Integer; external MySSL_DLL_name name fn_i2d_Netscape_RSA;
  function  f_d2i_Netscape_RSA(a: PPRSA; pp: PPChar; length: Longint; arg3: PFunction):PRSA; external MySSL_DLL_name name fn_d2i_Netscape_RSA;
  function  f_d2i_Netscape_RSA_2(a: PPRSA; pp: PPChar; length: Longint; arg3: PFunction):PRSA; external MySSL_DLL_name name fn_d2i_Netscape_RSA_2;
  function  f_RSA_sign(_type: Integer; m: PChar; m_len: UInteger; sigret: PChar; siglen: PUInteger; rsa: PRSA):Integer; external MySSL_DLL_name name fn_RSA_sign;
  function  f_RSA_verify(_type: Integer; m: PChar; m_len: UInteger; sigbuf: PChar; siglen: UInteger; rsa: PRSA):Integer; external MySSL_DLL_name name fn_RSA_verify;
  function  f_RSA_sign_ASN1_OCTET_STRING(_type: Integer; m: PChar; m_len: UInteger; sigret: PChar; siglen: PUInteger; rsa: PRSA):Integer; external MySSL_DLL_name name fn_RSA_sign_ASN1_OCTET_STRING;
  function  f_RSA_verify_ASN1_OCTET_STRING(_type: Integer; m: PChar; m_len: UInteger; sigbuf: PChar; siglen: UInteger; rsa: PRSA):Integer; external MySSL_DLL_name name fn_RSA_verify_ASN1_OCTET_STRING;
  function  f_RSA_blinding_on(rsa: PRSA; ctx: PBN_CTX):Integer; external MySSL_DLL_name name fn_RSA_blinding_on;
  procedure f_RSA_blinding_off(rsa: PRSA); external MySSL_DLL_name name fn_RSA_blinding_off;
  function  f_RSA_padding_add_PKCS1_type_1(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer; external MySSL_DLL_name name fn_RSA_padding_add_PKCS1_type_1;
  function  f_RSA_padding_check_PKCS1_type_1(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer; external MySSL_DLL_name name fn_RSA_padding_check_PKCS1_type_1;
  function  f_RSA_padding_add_PKCS1_type_2(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer; external MySSL_DLL_name name fn_RSA_padding_add_PKCS1_type_2;
  function  f_RSA_padding_check_PKCS1_type_2(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer; external MySSL_DLL_name name fn_RSA_padding_check_PKCS1_type_2;
  function  f_RSA_padding_add_PKCS1_OAEP(_to: PChar; tlen: Integer; f: PChar; fl: Integer; p: PChar; pl: Integer):Integer; external MySSL_DLL_name name fn_RSA_padding_add_PKCS1_OAEP;
  function  f_RSA_padding_check_PKCS1_OAEP(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer; p: PChar; pl: Integer):Integer; external MySSL_DLL_name name fn_RSA_padding_check_PKCS1_OAEP;
  function  f_RSA_padding_add_SSLv23(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer; external MySSL_DLL_name name fn_RSA_padding_add_SSLv23;
  function  f_RSA_padding_check_SSLv23(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer; external MySSL_DLL_name name fn_RSA_padding_check_SSLv23;
  function  f_RSA_padding_add_none(_to: PChar; tlen: Integer; f: PChar; fl: Integer):Integer; external MySSL_DLL_name name fn_RSA_padding_add_none;
  function  f_RSA_padding_check_none(_to: PChar; tlen: Integer; f: PChar; fl: Integer; rsa_len: Integer):Integer; external MySSL_DLL_name name fn_RSA_padding_check_none;
  function  f_RSA_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; external MySSL_DLL_name name fn_RSA_get_ex_new_index;
  function  f_RSA_set_ex_data(r: PRSA; idx: Integer; arg: PChar):Integer; external MySSL_DLL_name name fn_RSA_set_ex_data;
  function  f_RSA_get_ex_data(r: PRSA; idx: Integer):PChar; external MySSL_DLL_name name fn_RSA_get_ex_data;
  function  f_DH_new:PDH; external MySSL_DLL_name name fn_DH_new;
  procedure f_DH_free(dh: PDH); external MySSL_DLL_name name fn_DH_free;
  function  f_DH_size(dh: PDH):Integer; external MySSL_DLL_name name fn_DH_size;
  function  f_DH_generate_parameters(prime_len: Integer; generator: Integer; arg2: PFunction; cb_arg: Pointer):PDH; external MySSL_DLL_name name fn_DH_generate_parameters;
  function  f_DH_check(dh: PDH; codes: PInteger):Integer; external MySSL_DLL_name name fn_DH_check;
  function  f_DH_generate_key(dh: PDH):Integer; external MySSL_DLL_name name fn_DH_generate_key;
  function  f_DH_compute_key(key: PChar; pub_key: PBIGNUM; dh: PDH):Integer; external MySSL_DLL_name name fn_DH_compute_key;
  function  f_d2i_DHparams(a: PPDH; pp: PPChar; length: Longint):PDH; external MySSL_DLL_name name fn_d2i_DHparams;
  function  f_i2d_DHparams(a: PDH; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_DHparams;
  function  f_DHparams_print_fp(fp: PFILE; x: PDH):Integer; external MySSL_DLL_name name fn_DHparams_print_fp;
  function  f_DHparams_print(bp: PBIO; x: PDH):Integer; external MySSL_DLL_name name fn_DHparams_print;
  procedure f_ERR_load_DH_strings; external MySSL_DLL_name name fn_ERR_load_DH_strings;
  function  f_DSA_SIG_new:PDSA_SIG; external MySSL_DLL_name name fn_DSA_SIG_new;
  procedure f_DSA_SIG_free(a: PDSA_SIG); external MySSL_DLL_name name fn_DSA_SIG_free;
  function  f_i2d_DSA_SIG(a: PDSA_SIG; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_DSA_SIG;
  function  f_d2i_DSA_SIG(v: PPDSA_SIG; pp: PPChar; length: Longint):PDSA_SIG; external MySSL_DLL_name name fn_d2i_DSA_SIG;
  function  f_DSA_do_sign(const dgst: PChar; dlen: Integer; dsa: PDSA):PDSA_SIG; external MySSL_DLL_name name fn_DSA_do_sign;
  function  f_DSA_do_verify(const dgst: PChar; dgst_len: Integer; sig: PDSA_SIG; dsa: PDSA):Integer; external MySSL_DLL_name name fn_DSA_do_verify;
  function  f_DSA_new:PDSA; external MySSL_DLL_name name fn_DSA_new;
  function  f_DSA_size(arg0: PDSA):Integer; external MySSL_DLL_name name fn_DSA_size;
  function  f_DSA_sign_setup(dsa: PDSA; ctx_in: PBN_CTX; kinvp: PPBIGNUM; rp: PPBIGNUM):Integer; external MySSL_DLL_name name fn_DSA_sign_setup;
  function  f_DSA_sign(_type: Integer; const dgst: PChar; dlen: Integer; sig: PChar; siglen: PUInteger; dsa: PDSA):Integer; external MySSL_DLL_name name fn_DSA_sign;
  function  f_DSA_verify(_type: Integer; const dgst: PChar; dgst_len: Integer; sigbuf: PChar; siglen: Integer; dsa: PDSA):Integer; external MySSL_DLL_name name fn_DSA_verify;
  procedure f_DSA_free(r: PDSA); external MySSL_DLL_name name fn_DSA_free;
  procedure f_ERR_load_DSA_strings; external MySSL_DLL_name name fn_ERR_load_DSA_strings;
  function  f_d2i_DSAPublicKey(a: PPDSA; pp: PPChar; length: Longint):PDSA; external MySSL_DLL_name name fn_d2i_DSAPublicKey;
  function  f_d2i_DSAPrivateKey(a: PPDSA; pp: PPChar; length: Longint):PDSA; external MySSL_DLL_name name fn_d2i_DSAPrivateKey;
  function  f_d2i_DSAparams(a: PPDSA; pp: PPChar; length: Longint):PDSA; external MySSL_DLL_name name fn_d2i_DSAparams;
  function  f_DSA_generate_parameters(bits: Integer; seed: PChar; seed_len: Integer; counter_ret: PInteger; h_ret: PULong; arg5: PFunction; cb_arg: PChar):PDSA; external MySSL_DLL_name name fn_DSA_generate_parameters;
  function  f_DSA_generate_key(a: PDSA):Integer; external MySSL_DLL_name name fn_DSA_generate_key;
  function  f_i2d_DSAPublicKey(a: PDSA; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_DSAPublicKey;
  function  f_i2d_DSAPrivateKey(a: PDSA; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_DSAPrivateKey;
  function  f_i2d_DSAparams(a: PDSA; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_DSAparams;
  function  f_DSAparams_print(bp: PBIO; x: PDSA):Integer; external MySSL_DLL_name name fn_DSAparams_print;
  function  f_DSA_print(bp: PBIO; x: PDSA; off: Integer):Integer; external MySSL_DLL_name name fn_DSA_print;
  function  f_DSAparams_print_fp(fp: PFILE; x: PDSA):Integer; external MySSL_DLL_name name fn_DSAparams_print_fp;
  function  f_DSA_print_fp(bp: PFILE; x: PDSA; off: Integer):Integer; external MySSL_DLL_name name fn_DSA_print_fp;
  function  f_DSA_is_prime(q: PBIGNUM; arg1: PFunction; cb_arg: PChar):Integer; external MySSL_DLL_name name fn_DSA_is_prime;
  function  f_DSA_dup_DH(r: PDSA):PDH; external MySSL_DLL_name name fn_DSA_dup_DH;
  function  f_sk_ASN1_TYPE_new(arg0: PFunction):PSTACK_ASN1_TYPE; external MySSL_DLL_name name fn_sk_ASN1_TYPE_new;
  function  f_sk_ASN1_TYPE_new_null:PSTACK_ASN1_TYPE; external MySSL_DLL_name name fn_sk_ASN1_TYPE_new_null;
  procedure f_sk_ASN1_TYPE_free(sk: PSTACK_ASN1_TYPE); external MySSL_DLL_name name fn_sk_ASN1_TYPE_free;
  function  f_sk_ASN1_TYPE_num(const sk: PSTACK_ASN1_TYPE):Integer; external MySSL_DLL_name name fn_sk_ASN1_TYPE_num;
  function  f_sk_ASN1_TYPE_value(const sk: PSTACK_ASN1_TYPE; n: Integer):PASN1_TYPE; external MySSL_DLL_name name fn_sk_ASN1_TYPE_value;
  function  f_sk_ASN1_TYPE_set(sk: PSTACK_ASN1_TYPE; n: Integer; v: PASN1_TYPE):PASN1_TYPE; external MySSL_DLL_name name fn_sk_ASN1_TYPE_set;
  procedure f_sk_ASN1_TYPE_zero(sk: PSTACK_ASN1_TYPE); external MySSL_DLL_name name fn_sk_ASN1_TYPE_zero;
  function  f_sk_ASN1_TYPE_push(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE):Integer; external MySSL_DLL_name name fn_sk_ASN1_TYPE_push;
  function  f_sk_ASN1_TYPE_unshift(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE):Integer; external MySSL_DLL_name name fn_sk_ASN1_TYPE_unshift;
  function  f_sk_ASN1_TYPE_find(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE):Integer; external MySSL_DLL_name name fn_sk_ASN1_TYPE_find;
  function  f_sk_ASN1_TYPE_delete(sk: PSTACK_ASN1_TYPE; n: Integer):PASN1_TYPE; external MySSL_DLL_name name fn_sk_ASN1_TYPE_delete;
  procedure f_sk_ASN1_TYPE_delete_ptr(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE); external MySSL_DLL_name name fn_sk_ASN1_TYPE_delete_ptr;
  function  f_sk_ASN1_TYPE_insert(sk: PSTACK_ASN1_TYPE; v: PASN1_TYPE; n: Integer):Integer; external MySSL_DLL_name name fn_sk_ASN1_TYPE_insert;
  function  f_sk_ASN1_TYPE_dup(sk: PSTACK_ASN1_TYPE):PSTACK_ASN1_TYPE; external MySSL_DLL_name name fn_sk_ASN1_TYPE_dup;
  procedure f_sk_ASN1_TYPE_pop_free(sk: PSTACK_ASN1_TYPE; arg1: PFunction); external MySSL_DLL_name name fn_sk_ASN1_TYPE_pop_free;
  function  f_sk_ASN1_TYPE_shift(sk: PSTACK_ASN1_TYPE):PASN1_TYPE; external MySSL_DLL_name name fn_sk_ASN1_TYPE_shift;
  function  f_sk_ASN1_TYPE_pop(sk: PSTACK_ASN1_TYPE):PASN1_TYPE; external MySSL_DLL_name name fn_sk_ASN1_TYPE_pop;
  procedure f_sk_ASN1_TYPE_sort(sk: PSTACK_ASN1_TYPE); external MySSL_DLL_name name fn_sk_ASN1_TYPE_sort;
  function  f_i2d_ASN1_SET_OF_ASN1_TYPE(a: PSTACK_ASN1_TYPE; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET_OF_ASN1_TYPE;
  function  f_d2i_ASN1_SET_OF_ASN1_TYPE(a: PPSTACK_ASN1_TYPE; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_ASN1_TYPE; external MySSL_DLL_name name fn_d2i_ASN1_SET_OF_ASN1_TYPE;
  function  f_ASN1_TYPE_new:PASN1_TYPE; external MySSL_DLL_name name fn_ASN1_TYPE_new;
  procedure f_ASN1_TYPE_free(a: PASN1_TYPE); external MySSL_DLL_name name fn_ASN1_TYPE_free;
  function  f_i2d_ASN1_TYPE(a: PASN1_TYPE; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_TYPE;
  function  f_d2i_ASN1_TYPE(a: PPASN1_TYPE; pp: PPChar; length: Longint):PASN1_TYPE; external MySSL_DLL_name name fn_d2i_ASN1_TYPE;
  function  f_ASN1_TYPE_get(a: PASN1_TYPE):Integer; external MySSL_DLL_name name fn_ASN1_TYPE_get;
  procedure f_ASN1_TYPE_set(a: PASN1_TYPE; _type: Integer; value: Pointer); external MySSL_DLL_name name fn_ASN1_TYPE_set;
  function  f_ASN1_OBJECT_new:PASN1_OBJECT; external MySSL_DLL_name name fn_ASN1_OBJECT_new;
  procedure f_ASN1_OBJECT_free(a: PASN1_OBJECT); external MySSL_DLL_name name fn_ASN1_OBJECT_free;
  function  f_i2d_ASN1_OBJECT(a: PASN1_OBJECT; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_OBJECT;
  function  f_d2i_ASN1_OBJECT(a: PPASN1_OBJECT; pp: PPChar; length: Longint):PASN1_OBJECT; external MySSL_DLL_name name fn_d2i_ASN1_OBJECT;
  function  f_sk_ASN1_OBJECT_new(arg0: PFunction):PSTACK_ASN1_OBJECT; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_new;
  function  f_sk_ASN1_OBJECT_new_null:PSTACK_ASN1_OBJECT; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_new_null;
  procedure f_sk_ASN1_OBJECT_free(sk: PSTACK_ASN1_OBJECT); external MySSL_DLL_name name fn_sk_ASN1_OBJECT_free;
  function  f_sk_ASN1_OBJECT_num(const sk: PSTACK_ASN1_OBJECT):Integer; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_num;
  function  f_sk_ASN1_OBJECT_value(const sk: PSTACK_ASN1_OBJECT; n: Integer):PASN1_OBJECT; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_value;
  function  f_sk_ASN1_OBJECT_set(sk: PSTACK_ASN1_OBJECT; n: Integer; v: PASN1_OBJECT):PASN1_OBJECT; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_set;
  procedure f_sk_ASN1_OBJECT_zero(sk: PSTACK_ASN1_OBJECT); external MySSL_DLL_name name fn_sk_ASN1_OBJECT_zero;
  function  f_sk_ASN1_OBJECT_push(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT):Integer; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_push;
  function  f_sk_ASN1_OBJECT_unshift(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT):Integer; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_unshift;
  function  f_sk_ASN1_OBJECT_find(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT):Integer; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_find;
  function  f_sk_ASN1_OBJECT_delete(sk: PSTACK_ASN1_OBJECT; n: Integer):PASN1_OBJECT; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_delete;
  procedure f_sk_ASN1_OBJECT_delete_ptr(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT); external MySSL_DLL_name name fn_sk_ASN1_OBJECT_delete_ptr;
  function  f_sk_ASN1_OBJECT_insert(sk: PSTACK_ASN1_OBJECT; v: PASN1_OBJECT; n: Integer):Integer; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_insert;
  function  f_sk_ASN1_OBJECT_dup(sk: PSTACK_ASN1_OBJECT):PSTACK_ASN1_OBJECT; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_dup;
  procedure f_sk_ASN1_OBJECT_pop_free(sk: PSTACK_ASN1_OBJECT; arg1: PFunction); external MySSL_DLL_name name fn_sk_ASN1_OBJECT_pop_free;
  function  f_sk_ASN1_OBJECT_shift(sk: PSTACK_ASN1_OBJECT):PASN1_OBJECT; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_shift;
  function  f_sk_ASN1_OBJECT_pop(sk: PSTACK_ASN1_OBJECT):PASN1_OBJECT; external MySSL_DLL_name name fn_sk_ASN1_OBJECT_pop;
  procedure f_sk_ASN1_OBJECT_sort(sk: PSTACK_ASN1_OBJECT); external MySSL_DLL_name name fn_sk_ASN1_OBJECT_sort;
  function  f_i2d_ASN1_SET_OF_ASN1_OBJECT(a: PSTACK_ASN1_OBJECT; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET_OF_ASN1_OBJECT;
  function  f_d2i_ASN1_SET_OF_ASN1_OBJECT(a: PPSTACK_ASN1_OBJECT; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_ASN1_OBJECT; external MySSL_DLL_name name fn_d2i_ASN1_SET_OF_ASN1_OBJECT;
  function  f_ASN1_STRING_new:PASN1_STRING; external MySSL_DLL_name name fn_ASN1_STRING_new;
  procedure f_ASN1_STRING_free(a: PASN1_STRING); external MySSL_DLL_name name fn_ASN1_STRING_free;
  function  f_ASN1_STRING_dup(a: PASN1_STRING):PASN1_STRING; external MySSL_DLL_name name fn_ASN1_STRING_dup;
  function  f_ASN1_STRING_type_new(_type: Integer):PASN1_STRING; external MySSL_DLL_name name fn_ASN1_STRING_type_new;
  function  f_ASN1_STRING_cmp(a: PASN1_STRING; b: PASN1_STRING):Integer; external MySSL_DLL_name name fn_ASN1_STRING_cmp;
  function  f_ASN1_STRING_set(str: PASN1_STRING; const data: Pointer; len: Integer):Integer; external MySSL_DLL_name name fn_ASN1_STRING_set;
  function  f_i2d_ASN1_BIT_STRING(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_BIT_STRING;
  function  f_d2i_ASN1_BIT_STRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_BIT_STRING;
  function  f_ASN1_BIT_STRING_set_bit(a: PASN1_STRING; n: Integer; value: Integer):Integer; external MySSL_DLL_name name fn_ASN1_BIT_STRING_set_bit;
  function  f_ASN1_BIT_STRING_get_bit(a: PASN1_STRING; n: Integer):Integer; external MySSL_DLL_name name fn_ASN1_BIT_STRING_get_bit;
  function  f_i2d_ASN1_BOOLEAN(a: Integer; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_BOOLEAN;
  function  f_d2i_ASN1_BOOLEAN(a: PInteger; pp: PPChar; length: Longint):Integer; external MySSL_DLL_name name fn_d2i_ASN1_BOOLEAN;
  function  f_i2d_ASN1_INTEGER(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_INTEGER;
  function  f_d2i_ASN1_INTEGER(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_INTEGER;
  function  f_d2i_ASN1_UINTEGER(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_UINTEGER;
  function  f_i2d_ASN1_ENUMERATED(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_ENUMERATED;
  function  f_d2i_ASN1_ENUMERATED(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_ENUMERATED;
  function  f_ASN1_UTCTIME_check(a: PASN1_STRING):Integer; external MySSL_DLL_name name fn_ASN1_UTCTIME_check;
  function  f_ASN1_UTCTIME_set(s: PASN1_STRING; t: time_t):PASN1_STRING; external MySSL_DLL_name name fn_ASN1_UTCTIME_set;
  function  f_ASN1_UTCTIME_set_string(s: PASN1_STRING; str: PChar):Integer; external MySSL_DLL_name name fn_ASN1_UTCTIME_set_string;
  function  f_ASN1_GENERALIZEDTIME_check(a: PASN1_STRING):Integer; external MySSL_DLL_name name fn_ASN1_GENERALIZEDTIME_check;
  function  f_ASN1_GENERALIZEDTIME_set(s: PASN1_STRING; t: time_t):PASN1_STRING; external MySSL_DLL_name name fn_ASN1_GENERALIZEDTIME_set;
  function  f_ASN1_GENERALIZEDTIME_set_string(s: PASN1_STRING; str: PChar):Integer; external MySSL_DLL_name name fn_ASN1_GENERALIZEDTIME_set_string;
  function  f_i2d_ASN1_OCTET_STRING(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_OCTET_STRING;
  function  f_d2i_ASN1_OCTET_STRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_OCTET_STRING;
  function  f_i2d_ASN1_VISIBLESTRING(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_VISIBLESTRING;
  function  f_d2i_ASN1_VISIBLESTRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_VISIBLESTRING;
  function  f_i2d_ASN1_UTF8STRING(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_UTF8STRING;
  function  f_d2i_ASN1_UTF8STRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_UTF8STRING;
  function  f_i2d_ASN1_BMPSTRING(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_BMPSTRING;
  function  f_d2i_ASN1_BMPSTRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_BMPSTRING;
  function  f_i2d_ASN1_PRINTABLE(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_PRINTABLE;
  function  f_d2i_ASN1_PRINTABLE(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_PRINTABLE;
  function  f_d2i_ASN1_PRINTABLESTRING(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_PRINTABLESTRING;
  function  f_i2d_DIRECTORYSTRING(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_DIRECTORYSTRING;
  function  f_d2i_DIRECTORYSTRING(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_DIRECTORYSTRING;
  function  f_i2d_DISPLAYTEXT(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_DISPLAYTEXT;
  function  f_d2i_DISPLAYTEXT(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_DISPLAYTEXT;
  function  f_d2i_ASN1_T61STRING(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_T61STRING;
  function  f_i2d_ASN1_IA5STRING(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_IA5STRING;
  function  f_d2i_ASN1_IA5STRING(a: PPASN1_STRING; pp: PPChar; l: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_IA5STRING;
  function  f_i2d_ASN1_UTCTIME(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_UTCTIME;
  function  f_d2i_ASN1_UTCTIME(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_UTCTIME;
  function  f_i2d_ASN1_GENERALIZEDTIME(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_GENERALIZEDTIME;
  function  f_d2i_ASN1_GENERALIZEDTIME(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_GENERALIZEDTIME;
  function  f_i2d_ASN1_TIME(a: PASN1_STRING; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_TIME;
  function  f_d2i_ASN1_TIME(a: PPASN1_STRING; pp: PPChar; length: Longint):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_TIME;
  function  f_ASN1_TIME_set(s: PASN1_STRING; t: time_t):PASN1_STRING; external MySSL_DLL_name name fn_ASN1_TIME_set;
  function  f_i2d_ASN1_SET(a: PSTACK; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET;
  function  f_d2i_ASN1_SET(a: PPSTACK; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK; external MySSL_DLL_name name fn_d2i_ASN1_SET;
  function  f_i2a_ASN1_INTEGER(bp: PBIO; a: PASN1_STRING):Integer; external MySSL_DLL_name name fn_i2a_ASN1_INTEGER;
  function  f_a2i_ASN1_INTEGER(bp: PBIO; bs: PASN1_STRING; buf: PChar; size: Integer):Integer; external MySSL_DLL_name name fn_a2i_ASN1_INTEGER;
  function  f_i2a_ASN1_ENUMERATED(bp: PBIO; a: PASN1_STRING):Integer; external MySSL_DLL_name name fn_i2a_ASN1_ENUMERATED;
  function  f_a2i_ASN1_ENUMERATED(bp: PBIO; bs: PASN1_STRING; buf: PChar; size: Integer):Integer; external MySSL_DLL_name name fn_a2i_ASN1_ENUMERATED;
  function  f_i2a_ASN1_OBJECT(bp: PBIO; a: PASN1_OBJECT):Integer; external MySSL_DLL_name name fn_i2a_ASN1_OBJECT;
  function  f_a2i_ASN1_STRING(bp: PBIO; bs: PASN1_STRING; buf: PChar; size: Integer):Integer; external MySSL_DLL_name name fn_a2i_ASN1_STRING;
  function  f_i2a_ASN1_STRING(bp: PBIO; a: PASN1_STRING; _type: Integer):Integer; external MySSL_DLL_name name fn_i2a_ASN1_STRING;
  function  f_i2t_ASN1_OBJECT(buf: PChar; buf_len: Integer; a: PASN1_OBJECT):Integer; external MySSL_DLL_name name fn_i2t_ASN1_OBJECT;
  function  f_a2d_ASN1_OBJECT(_out: PChar; olen: Integer; const buf: PChar; num: Integer):Integer; external MySSL_DLL_name name fn_a2d_ASN1_OBJECT;
  function  f_ASN1_OBJECT_create(nid: Integer; data: PChar; len: Integer; sn: PChar; ln: PChar):PASN1_OBJECT; external MySSL_DLL_name name fn_ASN1_OBJECT_create;
  function  f_ASN1_INTEGER_set(a: PASN1_STRING; v: Longint):Integer; external MySSL_DLL_name name fn_ASN1_INTEGER_set;
  function  f_ASN1_INTEGER_get(a: PASN1_STRING):Longint; external MySSL_DLL_name name fn_ASN1_INTEGER_get;
  function  f_BN_to_ASN1_INTEGER(bn: PBIGNUM; ai: PASN1_STRING):PASN1_STRING; external MySSL_DLL_name name fn_BN_to_ASN1_INTEGER;
  function  f_ASN1_INTEGER_to_BN(ai: PASN1_STRING; bn: PBIGNUM):PBIGNUM; external MySSL_DLL_name name fn_ASN1_INTEGER_to_BN;
  function  f_ASN1_ENUMERATED_set(a: PASN1_STRING; v: Longint):Integer; external MySSL_DLL_name name fn_ASN1_ENUMERATED_set;
  function  f_ASN1_ENUMERATED_get(a: PASN1_STRING):Longint; external MySSL_DLL_name name fn_ASN1_ENUMERATED_get;
  function  f_BN_to_ASN1_ENUMERATED(bn: PBIGNUM; ai: PASN1_STRING):PASN1_STRING; external MySSL_DLL_name name fn_BN_to_ASN1_ENUMERATED;
  function  f_ASN1_ENUMERATED_to_BN(ai: PASN1_STRING; bn: PBIGNUM):PBIGNUM; external MySSL_DLL_name name fn_ASN1_ENUMERATED_to_BN;
  function  f_ASN1_PRINTABLE_type(s: PChar; max: Integer):Integer; external MySSL_DLL_name name fn_ASN1_PRINTABLE_type;
  function  f_i2d_ASN1_bytes(a: PASN1_STRING; pp: PPChar; tag: Integer; xclass: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_bytes;
  function  f_d2i_ASN1_bytes(a: PPASN1_STRING; pp: PPChar; length: Longint; Ptag: Integer; Pclass: Integer):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_bytes;
  function  f_d2i_ASN1_type_bytes(a: PPASN1_STRING; pp: PPChar; length: Longint; _type: Integer):PASN1_STRING; external MySSL_DLL_name name fn_d2i_ASN1_type_bytes;
  function  f_asn1_Finish(c: PASN1_CTX):Integer; external MySSL_DLL_name name fn_asn1_Finish;
  function  f_ASN1_get_object(pp: PPChar; plength: PLong; ptag: PInteger; pclass: PInteger; omax: Longint):Integer; external MySSL_DLL_name name fn_ASN1_get_object;
  function  f_ASN1_check_infinite_end(p: PPChar; len: Longint):Integer; external MySSL_DLL_name name fn_ASN1_check_infinite_end;
  procedure f_ASN1_put_object(pp: PPChar; constructed: Integer; length: Integer; tag: Integer; xclass: Integer); external MySSL_DLL_name name fn_ASN1_put_object;
  function  f_ASN1_object_size(constructed: Integer; length: Integer; tag: Integer):Integer; external MySSL_DLL_name name fn_ASN1_object_size;
  function  f_ASN1_dup(arg0: PFunction; arg1: PFunction; x: PChar):PChar; external MySSL_DLL_name name fn_ASN1_dup;
  function  f_ASN1_d2i_fp(arg0: PFunction; arg1: PFunction; fp: PFILE; x: PPChar):PChar; external MySSL_DLL_name name fn_ASN1_d2i_fp;
  function  f_ASN1_i2d_fp(arg0: PFunction; _out: PFILE; x: PChar):Integer; external MySSL_DLL_name name fn_ASN1_i2d_fp;
  function  f_ASN1_d2i_bio(arg0: PFunction; arg1: PFunction; bp: PBIO; x: PPChar):PChar; external MySSL_DLL_name name fn_ASN1_d2i_bio;
  function  f_ASN1_i2d_bio(arg0: PFunction; _out: PBIO; x: PChar):Integer; external MySSL_DLL_name name fn_ASN1_i2d_bio;
  function  f_ASN1_UTCTIME_print(fp: PBIO; a: PASN1_STRING):Integer; external MySSL_DLL_name name fn_ASN1_UTCTIME_print;
  function  f_ASN1_GENERALIZEDTIME_print(fp: PBIO; a: PASN1_STRING):Integer; external MySSL_DLL_name name fn_ASN1_GENERALIZEDTIME_print;
  function  f_ASN1_TIME_print(fp: PBIO; a: PASN1_STRING):Integer; external MySSL_DLL_name name fn_ASN1_TIME_print;
  function  f_ASN1_STRING_print(bp: PBIO; v: PASN1_STRING):Integer; external MySSL_DLL_name name fn_ASN1_STRING_print;
  function  f_ASN1_parse(bp: PBIO; pp: PChar; len: Longint; indent: Integer):Integer; external MySSL_DLL_name name fn_ASN1_parse;
  function  f_i2d_ASN1_HEADER(a: PASN1_HEADER; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_ASN1_HEADER;
  function  f_d2i_ASN1_HEADER(a: PPASN1_HEADER; pp: PPChar; length: Longint):PASN1_HEADER; external MySSL_DLL_name name fn_d2i_ASN1_HEADER;
  function  f_ASN1_HEADER_new:PASN1_HEADER; external MySSL_DLL_name name fn_ASN1_HEADER_new;
  procedure f_ASN1_HEADER_free(a: PASN1_HEADER); external MySSL_DLL_name name fn_ASN1_HEADER_free;
  function  f_ASN1_UNIVERSALSTRING_to_string(s: PASN1_STRING):Integer; external MySSL_DLL_name name fn_ASN1_UNIVERSALSTRING_to_string;
  procedure f_ERR_load_ASN1_strings; external MySSL_DLL_name name fn_ERR_load_ASN1_strings;
  function  f_X509_asn1_meth:PASN1_METHOD; external MySSL_DLL_name name fn_X509_asn1_meth;
  function  f_RSAPrivateKey_asn1_meth:PASN1_METHOD; external MySSL_DLL_name name fn_RSAPrivateKey_asn1_meth;
  function  f_ASN1_IA5STRING_asn1_meth:PASN1_METHOD; external MySSL_DLL_name name fn_ASN1_IA5STRING_asn1_meth;
  function  f_ASN1_BIT_STRING_asn1_meth:PASN1_METHOD; external MySSL_DLL_name name fn_ASN1_BIT_STRING_asn1_meth;
  function  f_ASN1_TYPE_set_octetstring(a: PASN1_TYPE; data: PChar; len: Integer):Integer; external MySSL_DLL_name name fn_ASN1_TYPE_set_octetstring;
  function  f_ASN1_TYPE_get_octetstring(a: PASN1_TYPE; data: PChar; max_len: Integer):Integer; external MySSL_DLL_name name fn_ASN1_TYPE_get_octetstring;
  function  f_ASN1_TYPE_set_int_octetstring(a: PASN1_TYPE; num: Longint; data: PChar; len: Integer):Integer; external MySSL_DLL_name name fn_ASN1_TYPE_set_int_octetstring;
  function  f_ASN1_TYPE_get_int_octetstring(a: PASN1_TYPE; num: PLong; data: PChar; max_len: Integer):Integer; external MySSL_DLL_name name fn_ASN1_TYPE_get_int_octetstring;
  function  f_ASN1_seq_unpack(buf: PChar; len: Integer; arg2: PFunction; arg3: PFunction):PSTACK; external MySSL_DLL_name name fn_ASN1_seq_unpack;
  function  f_ASN1_seq_pack(safes: PSTACK; arg1: PFunction; buf: PPChar; len: PInteger):PChar; external MySSL_DLL_name name fn_ASN1_seq_pack;
  function  f_ASN1_unpack_string(oct: PASN1_STRING; arg1: PFunction):Pointer; external MySSL_DLL_name name fn_ASN1_unpack_string;
  function  f_ASN1_pack_string(obj: Pointer; arg1: PFunction; oct: PPASN1_STRING):PASN1_STRING; external MySSL_DLL_name name fn_ASN1_pack_string;
  function  f_OBJ_NAME_init:Integer; external MySSL_DLL_name name fn_OBJ_NAME_init;
  function  f_OBJ_NAME_new_index(arg0: PFunction; arg1: PFunction; arg2: PFunction):Integer; external MySSL_DLL_name name fn_OBJ_NAME_new_index;
  function  f_OBJ_NAME_get(const name: PChar; _type: Integer):PChar; external MySSL_DLL_name name fn_OBJ_NAME_get;
  function  f_OBJ_NAME_add(const name: PChar; _type: Integer; const data: PChar):Integer; external MySSL_DLL_name name fn_OBJ_NAME_add;
  function  f_OBJ_NAME_remove(const name: PChar; _type: Integer):Integer; external MySSL_DLL_name name fn_OBJ_NAME_remove;
  procedure f_OBJ_NAME_cleanup(_type: Integer); external MySSL_DLL_name name fn_OBJ_NAME_cleanup;
  function  f_OBJ_dup(o: PASN1_OBJECT):PASN1_OBJECT; external MySSL_DLL_name name fn_OBJ_dup;
  function  f_OBJ_nid2obj(n: Integer):PASN1_OBJECT; external MySSL_DLL_name name fn_OBJ_nid2obj;
  function  f_OBJ_nid2ln(n: Integer):PChar; external MySSL_DLL_name name fn_OBJ_nid2ln;
  function  f_OBJ_nid2sn(n: Integer):PChar; external MySSL_DLL_name name fn_OBJ_nid2sn;
  function  f_OBJ_obj2nid(o: PASN1_OBJECT):Integer; external MySSL_DLL_name name fn_OBJ_obj2nid;
  function  f_OBJ_txt2obj(const s: PChar; no_name: Integer):PASN1_OBJECT; external MySSL_DLL_name name fn_OBJ_txt2obj;
  function  f_OBJ_obj2txt(buf: PChar; buf_len: Integer; a: PASN1_OBJECT; no_name: Integer):Integer; external MySSL_DLL_name name fn_OBJ_obj2txt;
  function  f_OBJ_txt2nid(s: PChar):Integer; external MySSL_DLL_name name fn_OBJ_txt2nid;
  function  f_OBJ_ln2nid(const s: PChar):Integer; external MySSL_DLL_name name fn_OBJ_ln2nid;
  function  f_OBJ_sn2nid(const s: PChar):Integer; external MySSL_DLL_name name fn_OBJ_sn2nid;
  function  f_OBJ_cmp(a: PASN1_OBJECT; b: PASN1_OBJECT):Integer; external MySSL_DLL_name name fn_OBJ_cmp;
  function  f_OBJ_bsearch(key: PChar; base: PChar; num: Integer; size: Integer; arg4: PFunction):PChar; external MySSL_DLL_name name fn_OBJ_bsearch;
  procedure f_ERR_load_OBJ_strings; external MySSL_DLL_name name fn_ERR_load_OBJ_strings;
  function  f_OBJ_new_nid(num: Integer):Integer; external MySSL_DLL_name name fn_OBJ_new_nid;
  function  f_OBJ_add_object(obj: PASN1_OBJECT):Integer; external MySSL_DLL_name name fn_OBJ_add_object;
  function  f_OBJ_create(oid: PChar; sn: PChar; ln: PChar):Integer; external MySSL_DLL_name name fn_OBJ_create;
  procedure f_OBJ_cleanup; external MySSL_DLL_name name fn_OBJ_cleanup;
  function  f_OBJ_create_objects(_in: PBIO):Integer; external MySSL_DLL_name name fn_OBJ_create_objects;
  function  f_EVP_MD_CTX_copy(_out: PEVP_MD_CTX; _in: PEVP_MD_CTX):Integer; external MySSL_DLL_name name fn_EVP_MD_CTX_copy;
  procedure f_EVP_DigestInit(ctx: PEVP_MD_CTX; const _type: PEVP_MD); external MySSL_DLL_name name fn_EVP_DigestInit;
  procedure f_EVP_DigestUpdate(ctx: PEVP_MD_CTX; const d: Pointer; cnt: UInteger); external MySSL_DLL_name name fn_EVP_DigestUpdate;
  procedure f_EVP_DigestFinal(ctx: PEVP_MD_CTX; md: PChar; s: PUInteger); external MySSL_DLL_name name fn_EVP_DigestFinal;
  function  f_EVP_read_pw_string(buf: PChar; length: Integer; const prompt: PChar; verify: Integer):Integer; external MySSL_DLL_name name fn_EVP_read_pw_string;
  procedure f_EVP_set_pw_prompt(prompt: PChar); external MySSL_DLL_name name fn_EVP_set_pw_prompt;
  function  f_EVP_get_pw_prompt:PChar; external MySSL_DLL_name name fn_EVP_get_pw_prompt;
  function  f_EVP_BytesToKey(const _type: PEVP_CIPHER; md: PEVP_MD; salt: PChar; data: PChar; datal: Integer; count: Integer; key: PChar; iv: PChar):Integer; external MySSL_DLL_name name fn_EVP_BytesToKey;
  procedure f_EVP_EncryptInit(ctx: PEVP_CIPHER_CTX; const _type: PEVP_CIPHER; key: PChar; iv: PChar); external MySSL_DLL_name name fn_EVP_EncryptInit;
  procedure f_EVP_EncryptUpdate(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer); external MySSL_DLL_name name fn_EVP_EncryptUpdate;
  procedure f_EVP_EncryptFinal(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger); external MySSL_DLL_name name fn_EVP_EncryptFinal;
  procedure f_EVP_DecryptInit(ctx: PEVP_CIPHER_CTX; const _type: PEVP_CIPHER; key: PChar; iv: PChar); external MySSL_DLL_name name fn_EVP_DecryptInit;
  procedure f_EVP_DecryptUpdate(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer); external MySSL_DLL_name name fn_EVP_DecryptUpdate;
  function  f_EVP_DecryptFinal(ctx: PEVP_CIPHER_CTX; outm: PChar; outl: PInteger):Integer; external MySSL_DLL_name name fn_EVP_DecryptFinal;
  procedure f_EVP_CipherInit(ctx: PEVP_CIPHER_CTX; const _type: PEVP_CIPHER; key: PChar; iv: PChar; enc: Integer); external MySSL_DLL_name name fn_EVP_CipherInit;
  procedure f_EVP_CipherUpdate(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer); external MySSL_DLL_name name fn_EVP_CipherUpdate;
  function  f_EVP_CipherFinal(ctx: PEVP_CIPHER_CTX; outm: PChar; outl: PInteger):Integer; external MySSL_DLL_name name fn_EVP_CipherFinal;
  function  f_EVP_SignFinal(ctx: PEVP_MD_CTX; md: PChar; s: PUInteger; pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_EVP_SignFinal;
  function  f_EVP_VerifyFinal(ctx: PEVP_MD_CTX; sigbuf: PChar; siglen: UInteger; pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_EVP_VerifyFinal;
  function  f_EVP_OpenInit(ctx: PEVP_CIPHER_CTX; _type: PEVP_CIPHER; ek: PChar; ekl: Integer; iv: PChar; priv: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_EVP_OpenInit;
  function  f_EVP_OpenFinal(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger):Integer; external MySSL_DLL_name name fn_EVP_OpenFinal;
  function  f_EVP_SealInit(ctx: PEVP_CIPHER_CTX; _type: PEVP_CIPHER; ek: PPChar; ekl: PInteger; iv: PChar; pubk: PPEVP_PKEY; npubk: Integer):Integer; external MySSL_DLL_name name fn_EVP_SealInit;
  procedure f_EVP_SealFinal(ctx: PEVP_CIPHER_CTX; _out: PChar; outl: PInteger); external MySSL_DLL_name name fn_EVP_SealFinal;
  procedure f_EVP_EncodeInit(ctx: PEVP_ENCODE_CTX); external MySSL_DLL_name name fn_EVP_EncodeInit;
  procedure f_EVP_EncodeUpdate(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer); external MySSL_DLL_name name fn_EVP_EncodeUpdate;
  procedure f_EVP_EncodeFinal(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger); external MySSL_DLL_name name fn_EVP_EncodeFinal;
  function  f_EVP_EncodeBlock(t: PChar; f: PChar; n: Integer):Integer; external MySSL_DLL_name name fn_EVP_EncodeBlock;
  procedure f_EVP_DecodeInit(ctx: PEVP_ENCODE_CTX); external MySSL_DLL_name name fn_EVP_DecodeInit;
  function  f_EVP_DecodeUpdate(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer):Integer; external MySSL_DLL_name name fn_EVP_DecodeUpdate;
  function  f_EVP_DecodeFinal(ctx: PEVP_ENCODE_CTX; _out: PChar; outl: PInteger):Integer; external MySSL_DLL_name name fn_EVP_DecodeFinal;
  function  f_EVP_DecodeBlock(t: PChar; f: PChar; n: Integer):Integer; external MySSL_DLL_name name fn_EVP_DecodeBlock;
  procedure f_ERR_load_EVP_strings; external MySSL_DLL_name name fn_ERR_load_EVP_strings;
  procedure f_EVP_CIPHER_CTX_init(a: PEVP_CIPHER_CTX); external MySSL_DLL_name name fn_EVP_CIPHER_CTX_init;
  procedure f_EVP_CIPHER_CTX_cleanup(a: PEVP_CIPHER_CTX); external MySSL_DLL_name name fn_EVP_CIPHER_CTX_cleanup;
  function  f_BIO_f_md:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_f_md;
  function  f_BIO_f_base64:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_f_base64;
  function  f_BIO_f_cipher:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_f_cipher;
  function  f_BIO_f_reliable:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_f_reliable;
  procedure f_BIO_set_cipher(b: PBIO; const c: PEVP_CIPHER; k: PChar; i: PChar; enc: Integer); external MySSL_DLL_name name fn_BIO_set_cipher;
  function  f_EVP_md_null:PEVP_MD; external MySSL_DLL_name name fn_EVP_md_null;
  function  f_EVP_md2:PEVP_MD; external MySSL_DLL_name name fn_EVP_md2;
  function  f_EVP_md5:PEVP_MD; external MySSL_DLL_name name fn_EVP_md5;
  function  f_EVP_sha:PEVP_MD; external MySSL_DLL_name name fn_EVP_sha;
  function  f_EVP_sha1:PEVP_MD; external MySSL_DLL_name name fn_EVP_sha1;
  function  f_EVP_dss:PEVP_MD; external MySSL_DLL_name name fn_EVP_dss;
  function  f_EVP_dss1:PEVP_MD; external MySSL_DLL_name name fn_EVP_dss1;
  function  f_EVP_mdc2:PEVP_MD; external MySSL_DLL_name name fn_EVP_mdc2;
  function  f_EVP_ripemd160:PEVP_MD; external MySSL_DLL_name name fn_EVP_ripemd160;
  function  f_EVP_enc_null:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_enc_null;
  function  f_EVP_des_ecb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_ecb;
  function  f_EVP_des_ede:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_ede;
  function  f_EVP_des_ede3:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_ede3;
  function  f_EVP_des_cfb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_cfb;
  function  f_EVP_des_ede_cfb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_ede_cfb;
  function  f_EVP_des_ede3_cfb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_ede3_cfb;
  function  f_EVP_des_ofb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_ofb;
  function  f_EVP_des_ede_ofb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_ede_ofb;
  function  f_EVP_des_ede3_ofb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_ede3_ofb;
  function  f_EVP_des_cbc:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_cbc;
  function  f_EVP_des_ede_cbc:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_ede_cbc;
  function  f_EVP_des_ede3_cbc:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_des_ede3_cbc;
  function  f_EVP_desx_cbc:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_desx_cbc;
  function  f_EVP_rc4:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc4;
  function  f_EVP_rc4_40:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc4_40;
  function  f_EVP_idea_ecb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_idea_ecb;
  function  f_EVP_idea_cfb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_idea_cfb;
  function  f_EVP_idea_ofb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_idea_ofb;
  function  f_EVP_idea_cbc:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_idea_cbc;
  function  f_EVP_rc2_ecb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc2_ecb;
  function  f_EVP_rc2_cbc:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc2_cbc;
  function  f_EVP_rc2_40_cbc:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc2_40_cbc;
  function  f_EVP_rc2_64_cbc:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc2_64_cbc;
  function  f_EVP_rc2_cfb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc2_cfb;
  function  f_EVP_rc2_ofb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc2_ofb;
  function  f_EVP_bf_ecb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_bf_ecb;
  function  f_EVP_bf_cbc:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_bf_cbc;
  function  f_EVP_bf_cfb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_bf_cfb;
  function  f_EVP_bf_ofb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_bf_ofb;
  function  f_EVP_cast5_ecb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_cast5_ecb;
  function  f_EVP_cast5_cbc:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_cast5_cbc;
  function  f_EVP_cast5_cfb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_cast5_cfb;
  function  f_EVP_cast5_ofb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_cast5_ofb;
  function  f_EVP_rc5_32_12_16_cbc:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc5_32_12_16_cbc;
  function  f_EVP_rc5_32_12_16_ecb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc5_32_12_16_ecb;
  function  f_EVP_rc5_32_12_16_cfb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc5_32_12_16_cfb;
  function  f_EVP_rc5_32_12_16_ofb:PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_rc5_32_12_16_ofb;
  procedure f_SSLeay_add_all_algorithms; external MySSL_DLL_name name fn_SSLeay_add_all_algorithms;
  procedure f_SSLeay_add_all_ciphers; external MySSL_DLL_name name fn_SSLeay_add_all_ciphers;
  procedure f_SSLeay_add_all_digests; external MySSL_DLL_name name fn_SSLeay_add_all_digests;
  function  f_EVP_add_cipher(cipher: PEVP_CIPHER):Integer; external MySSL_DLL_name name fn_EVP_add_cipher;
  function  f_EVP_add_digest(digest: PEVP_MD):Integer; external MySSL_DLL_name name fn_EVP_add_digest;
  function  f_EVP_get_cipherbyname(const name: PChar):PEVP_CIPHER; external MySSL_DLL_name name fn_EVP_get_cipherbyname;
  function  f_EVP_get_digestbyname(const name: PChar):PEVP_MD; external MySSL_DLL_name name fn_EVP_get_digestbyname;
  procedure f_EVP_cleanup; external MySSL_DLL_name name fn_EVP_cleanup;
  function  f_EVP_PKEY_decrypt(dec_key: PChar; enc_key: PChar; enc_key_len: Integer; private_key: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_EVP_PKEY_decrypt;
  function  f_EVP_PKEY_encrypt(enc_key: PChar; key: PChar; key_len: Integer; pub_key: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_EVP_PKEY_encrypt;
  function  f_EVP_PKEY_type(_type: Integer):Integer; external MySSL_DLL_name name fn_EVP_PKEY_type;
  function  f_EVP_PKEY_bits(pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_EVP_PKEY_bits;
  function  f_EVP_PKEY_size(pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_EVP_PKEY_size;
  function  f_EVP_PKEY_assign(pkey: PEVP_PKEY; _type: Integer; key: PChar):Integer; external MySSL_DLL_name name fn_EVP_PKEY_assign;
  function  f_EVP_PKEY_new:PEVP_PKEY; external MySSL_DLL_name name fn_EVP_PKEY_new;
  procedure f_EVP_PKEY_free(pkey: PEVP_PKEY); external MySSL_DLL_name name fn_EVP_PKEY_free;
  function  f_d2i_PublicKey(_type: Integer; a: PPEVP_PKEY; pp: PPChar; length: Longint):PEVP_PKEY; external MySSL_DLL_name name fn_d2i_PublicKey;
  function  f_i2d_PublicKey(a: PEVP_PKEY; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PublicKey;
  function  f_d2i_PrivateKey(_type: Integer; a: PPEVP_PKEY; pp: PPChar; length: Longint):PEVP_PKEY; external MySSL_DLL_name name fn_d2i_PrivateKey;
  function  f_i2d_PrivateKey(a: PEVP_PKEY; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PrivateKey;
  function  f_EVP_PKEY_copy_parameters(_to: PEVP_PKEY; from: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_EVP_PKEY_copy_parameters;
  function  f_EVP_PKEY_missing_parameters(pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_EVP_PKEY_missing_parameters;
  function  f_EVP_PKEY_save_parameters(pkey: PEVP_PKEY; mode: Integer):Integer; external MySSL_DLL_name name fn_EVP_PKEY_save_parameters;
  function  f_EVP_PKEY_cmp_parameters(a: PEVP_PKEY; b: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_EVP_PKEY_cmp_parameters;
  function  f_EVP_CIPHER_type(const ctx: PEVP_CIPHER):Integer; external MySSL_DLL_name name fn_EVP_CIPHER_type;
  function  f_EVP_CIPHER_param_to_asn1(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer; external MySSL_DLL_name name fn_EVP_CIPHER_param_to_asn1;
  function  f_EVP_CIPHER_asn1_to_param(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer; external MySSL_DLL_name name fn_EVP_CIPHER_asn1_to_param;
  function  f_EVP_CIPHER_set_asn1_iv(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer; external MySSL_DLL_name name fn_EVP_CIPHER_set_asn1_iv;
  function  f_EVP_CIPHER_get_asn1_iv(c: PEVP_CIPHER_CTX; _type: PASN1_TYPE):Integer; external MySSL_DLL_name name fn_EVP_CIPHER_get_asn1_iv;
  function  f_PKCS5_PBE_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PChar; passlen: Integer; param: PASN1_TYPE; cipher: PEVP_CIPHER; md: PEVP_MD; en_de: Integer):Integer; external MySSL_DLL_name name fn_PKCS5_PBE_keyivgen;
  function  f_PKCS5_PBKDF2_HMAC_SHA1(const pass: PChar; passlen: Integer; salt: PChar; saltlen: Integer; iter: Integer; keylen: Integer; _out: PChar):Integer; external MySSL_DLL_name name fn_PKCS5_PBKDF2_HMAC_SHA1;
  function  f_PKCS5_v2_PBE_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PChar; passlen: Integer; param: PASN1_TYPE; cipher: PEVP_CIPHER; md: PEVP_MD; en_de: Integer):Integer; external MySSL_DLL_name name fn_PKCS5_v2_PBE_keyivgen;
  procedure f_PKCS5_PBE_add; external MySSL_DLL_name name fn_PKCS5_PBE_add;
  function  f_EVP_PBE_CipherInit(pbe_obj: PASN1_OBJECT; const pass: PChar; passlen: Integer; param: PASN1_TYPE; ctx: PEVP_CIPHER_CTX; en_de: Integer):Integer; external MySSL_DLL_name name fn_EVP_PBE_CipherInit;
  function  f_EVP_PBE_alg_add(nid: Integer; cipher: PEVP_CIPHER; md: PEVP_MD; keygen: PEVP_PBE_KEYGEN):Integer; external MySSL_DLL_name name fn_EVP_PBE_alg_add;
  procedure f_EVP_PBE_cleanup; external MySSL_DLL_name name fn_EVP_PBE_cleanup;
  function  f_sk_X509_ALGOR_new(arg0: PFunction):PSTACK_X509_ALGOR; external MySSL_DLL_name name fn_sk_X509_ALGOR_new;
  function  f_sk_X509_ALGOR_new_null:PSTACK_X509_ALGOR; external MySSL_DLL_name name fn_sk_X509_ALGOR_new_null;
  procedure f_sk_X509_ALGOR_free(sk: PSTACK_X509_ALGOR); external MySSL_DLL_name name fn_sk_X509_ALGOR_free;
  function  f_sk_X509_ALGOR_num(const sk: PSTACK_X509_ALGOR):Integer; external MySSL_DLL_name name fn_sk_X509_ALGOR_num;
  function  f_sk_X509_ALGOR_value(const sk: PSTACK_X509_ALGOR; n: Integer):PX509_ALGOR; external MySSL_DLL_name name fn_sk_X509_ALGOR_value;
  function  f_sk_X509_ALGOR_set(sk: PSTACK_X509_ALGOR; n: Integer; v: PX509_ALGOR):PX509_ALGOR; external MySSL_DLL_name name fn_sk_X509_ALGOR_set;
  procedure f_sk_X509_ALGOR_zero(sk: PSTACK_X509_ALGOR); external MySSL_DLL_name name fn_sk_X509_ALGOR_zero;
  function  f_sk_X509_ALGOR_push(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR):Integer; external MySSL_DLL_name name fn_sk_X509_ALGOR_push;
  function  f_sk_X509_ALGOR_unshift(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR):Integer; external MySSL_DLL_name name fn_sk_X509_ALGOR_unshift;
  function  f_sk_X509_ALGOR_find(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR):Integer; external MySSL_DLL_name name fn_sk_X509_ALGOR_find;
  function  f_sk_X509_ALGOR_delete(sk: PSTACK_X509_ALGOR; n: Integer):PX509_ALGOR; external MySSL_DLL_name name fn_sk_X509_ALGOR_delete;
  procedure f_sk_X509_ALGOR_delete_ptr(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR); external MySSL_DLL_name name fn_sk_X509_ALGOR_delete_ptr;
  function  f_sk_X509_ALGOR_insert(sk: PSTACK_X509_ALGOR; v: PX509_ALGOR; n: Integer):Integer; external MySSL_DLL_name name fn_sk_X509_ALGOR_insert;
  function  f_sk_X509_ALGOR_dup(sk: PSTACK_X509_ALGOR):PSTACK_X509_ALGOR; external MySSL_DLL_name name fn_sk_X509_ALGOR_dup;
  procedure f_sk_X509_ALGOR_pop_free(sk: PSTACK_X509_ALGOR; arg1: PFunction); external MySSL_DLL_name name fn_sk_X509_ALGOR_pop_free;
  function  f_sk_X509_ALGOR_shift(sk: PSTACK_X509_ALGOR):PX509_ALGOR; external MySSL_DLL_name name fn_sk_X509_ALGOR_shift;
  function  f_sk_X509_ALGOR_pop(sk: PSTACK_X509_ALGOR):PX509_ALGOR; external MySSL_DLL_name name fn_sk_X509_ALGOR_pop;
  procedure f_sk_X509_ALGOR_sort(sk: PSTACK_X509_ALGOR); external MySSL_DLL_name name fn_sk_X509_ALGOR_sort;
  function  f_i2d_ASN1_SET_OF_X509_ALGOR(a: PSTACK_X509_ALGOR; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET_OF_X509_ALGOR;
  function  f_d2i_ASN1_SET_OF_X509_ALGOR(a: PPSTACK_X509_ALGOR; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_ALGOR; external MySSL_DLL_name name fn_d2i_ASN1_SET_OF_X509_ALGOR;
  function  f_sk_X509_NAME_ENTRY_new(arg0: PFunction):PSTACK_X509_NAME_ENTRY; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_new;
  function  f_sk_X509_NAME_ENTRY_new_null:PSTACK_X509_NAME_ENTRY; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_new_null;
  procedure f_sk_X509_NAME_ENTRY_free(sk: PSTACK_X509_NAME_ENTRY); external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_free;
  function  f_sk_X509_NAME_ENTRY_num(const sk: PSTACK_X509_NAME_ENTRY):Integer; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_num;
  function  f_sk_X509_NAME_ENTRY_value(const sk: PSTACK_X509_NAME_ENTRY; n: Integer):PX509_NAME_ENTRY; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_value;
  function  f_sk_X509_NAME_ENTRY_set(sk: PSTACK_X509_NAME_ENTRY; n: Integer; v: PX509_NAME_ENTRY):PX509_NAME_ENTRY; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_set;
  procedure f_sk_X509_NAME_ENTRY_zero(sk: PSTACK_X509_NAME_ENTRY); external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_zero;
  function  f_sk_X509_NAME_ENTRY_push(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY):Integer; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_push;
  function  f_sk_X509_NAME_ENTRY_unshift(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY):Integer; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_unshift;
  function  f_sk_X509_NAME_ENTRY_find(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY):Integer; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_find;
  function  f_sk_X509_NAME_ENTRY_delete(sk: PSTACK_X509_NAME_ENTRY; n: Integer):PX509_NAME_ENTRY; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_delete;
  procedure f_sk_X509_NAME_ENTRY_delete_ptr(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY); external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_delete_ptr;
  function  f_sk_X509_NAME_ENTRY_insert(sk: PSTACK_X509_NAME_ENTRY; v: PX509_NAME_ENTRY; n: Integer):Integer; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_insert;
  function  f_sk_X509_NAME_ENTRY_dup(sk: PSTACK_X509_NAME_ENTRY):PSTACK_X509_NAME_ENTRY; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_dup;
  procedure f_sk_X509_NAME_ENTRY_pop_free(sk: PSTACK_X509_NAME_ENTRY; arg1: PFunction); external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_pop_free;
  function  f_sk_X509_NAME_ENTRY_shift(sk: PSTACK_X509_NAME_ENTRY):PX509_NAME_ENTRY; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_shift;
  function  f_sk_X509_NAME_ENTRY_pop(sk: PSTACK_X509_NAME_ENTRY):PX509_NAME_ENTRY; external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_pop;
  procedure f_sk_X509_NAME_ENTRY_sort(sk: PSTACK_X509_NAME_ENTRY); external MySSL_DLL_name name fn_sk_X509_NAME_ENTRY_sort;
  function  f_i2d_ASN1_SET_OF_X509_NAME_ENTRY(a: PSTACK_X509_NAME_ENTRY; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET_OF_X509_NAME_ENTRY;
  function  f_d2i_ASN1_SET_OF_X509_NAME_ENTRY(a: PPSTACK_X509_NAME_ENTRY; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_NAME_ENTRY; external MySSL_DLL_name name fn_d2i_ASN1_SET_OF_X509_NAME_ENTRY;
  function  f_sk_X509_NAME_new(arg0: PFunction):PSTACK_X509_NAME; external MySSL_DLL_name name fn_sk_X509_NAME_new;
  function  f_sk_X509_NAME_new_null:PSTACK_X509_NAME; external MySSL_DLL_name name fn_sk_X509_NAME_new_null;
  procedure f_sk_X509_NAME_free(sk: PSTACK_X509_NAME); external MySSL_DLL_name name fn_sk_X509_NAME_free;
  function  f_sk_X509_NAME_num(const sk: PSTACK_X509_NAME):Integer; external MySSL_DLL_name name fn_sk_X509_NAME_num;
  function  f_sk_X509_NAME_value(const sk: PSTACK_X509_NAME; n: Integer):PX509_NAME; external MySSL_DLL_name name fn_sk_X509_NAME_value;
  function  f_sk_X509_NAME_set(sk: PSTACK_X509_NAME; n: Integer; v: PX509_NAME):PX509_NAME; external MySSL_DLL_name name fn_sk_X509_NAME_set;
  procedure f_sk_X509_NAME_zero(sk: PSTACK_X509_NAME); external MySSL_DLL_name name fn_sk_X509_NAME_zero;
  function  f_sk_X509_NAME_push(sk: PSTACK_X509_NAME; v: PX509_NAME):Integer; external MySSL_DLL_name name fn_sk_X509_NAME_push;
  function  f_sk_X509_NAME_unshift(sk: PSTACK_X509_NAME; v: PX509_NAME):Integer; external MySSL_DLL_name name fn_sk_X509_NAME_unshift;
  function  f_sk_X509_NAME_find(sk: PSTACK_X509_NAME; v: PX509_NAME):Integer; external MySSL_DLL_name name fn_sk_X509_NAME_find;
  function  f_sk_X509_NAME_delete(sk: PSTACK_X509_NAME; n: Integer):PX509_NAME; external MySSL_DLL_name name fn_sk_X509_NAME_delete;
  procedure f_sk_X509_NAME_delete_ptr(sk: PSTACK_X509_NAME; v: PX509_NAME); external MySSL_DLL_name name fn_sk_X509_NAME_delete_ptr;
  function  f_sk_X509_NAME_insert(sk: PSTACK_X509_NAME; v: PX509_NAME; n: Integer):Integer; external MySSL_DLL_name name fn_sk_X509_NAME_insert;
  function  f_sk_X509_NAME_dup(sk: PSTACK_X509_NAME):PSTACK_X509_NAME; external MySSL_DLL_name name fn_sk_X509_NAME_dup;
  procedure f_sk_X509_NAME_pop_free(sk: PSTACK_X509_NAME; arg1: PFunction); external MySSL_DLL_name name fn_sk_X509_NAME_pop_free;
  function  f_sk_X509_NAME_shift(sk: PSTACK_X509_NAME):PX509_NAME; external MySSL_DLL_name name fn_sk_X509_NAME_shift;
  function  f_sk_X509_NAME_pop(sk: PSTACK_X509_NAME):PX509_NAME; external MySSL_DLL_name name fn_sk_X509_NAME_pop;
  procedure f_sk_X509_NAME_sort(sk: PSTACK_X509_NAME); external MySSL_DLL_name name fn_sk_X509_NAME_sort;
  function  f_sk_X509_EXTENSION_new(arg0: PFunction):PSTACK_X509_EXTENSION; external MySSL_DLL_name name fn_sk_X509_EXTENSION_new;
  function  f_sk_X509_EXTENSION_new_null:PSTACK_X509_EXTENSION; external MySSL_DLL_name name fn_sk_X509_EXTENSION_new_null;
  procedure f_sk_X509_EXTENSION_free(sk: PSTACK_X509_EXTENSION); external MySSL_DLL_name name fn_sk_X509_EXTENSION_free;
  function  f_sk_X509_EXTENSION_num(const sk: PSTACK_X509_EXTENSION):Integer; external MySSL_DLL_name name fn_sk_X509_EXTENSION_num;
  function  f_sk_X509_EXTENSION_value(const sk: PSTACK_X509_EXTENSION; n: Integer):PX509_EXTENSION; external MySSL_DLL_name name fn_sk_X509_EXTENSION_value;
  function  f_sk_X509_EXTENSION_set(sk: PSTACK_X509_EXTENSION; n: Integer; v: PX509_EXTENSION):PX509_EXTENSION; external MySSL_DLL_name name fn_sk_X509_EXTENSION_set;
  procedure f_sk_X509_EXTENSION_zero(sk: PSTACK_X509_EXTENSION); external MySSL_DLL_name name fn_sk_X509_EXTENSION_zero;
  function  f_sk_X509_EXTENSION_push(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION):Integer; external MySSL_DLL_name name fn_sk_X509_EXTENSION_push;
  function  f_sk_X509_EXTENSION_unshift(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION):Integer; external MySSL_DLL_name name fn_sk_X509_EXTENSION_unshift;
  function  f_sk_X509_EXTENSION_find(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION):Integer; external MySSL_DLL_name name fn_sk_X509_EXTENSION_find;
  function  f_sk_X509_EXTENSION_delete(sk: PSTACK_X509_EXTENSION; n: Integer):PX509_EXTENSION; external MySSL_DLL_name name fn_sk_X509_EXTENSION_delete;
  procedure f_sk_X509_EXTENSION_delete_ptr(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION); external MySSL_DLL_name name fn_sk_X509_EXTENSION_delete_ptr;
  function  f_sk_X509_EXTENSION_insert(sk: PSTACK_X509_EXTENSION; v: PX509_EXTENSION; n: Integer):Integer; external MySSL_DLL_name name fn_sk_X509_EXTENSION_insert;
  function  f_sk_X509_EXTENSION_dup(sk: PSTACK_X509_EXTENSION):PSTACK_X509_EXTENSION; external MySSL_DLL_name name fn_sk_X509_EXTENSION_dup;
  procedure f_sk_X509_EXTENSION_pop_free(sk: PSTACK_X509_EXTENSION; arg1: PFunction); external MySSL_DLL_name name fn_sk_X509_EXTENSION_pop_free;
  function  f_sk_X509_EXTENSION_shift(sk: PSTACK_X509_EXTENSION):PX509_EXTENSION; external MySSL_DLL_name name fn_sk_X509_EXTENSION_shift;
  function  f_sk_X509_EXTENSION_pop(sk: PSTACK_X509_EXTENSION):PX509_EXTENSION; external MySSL_DLL_name name fn_sk_X509_EXTENSION_pop;
  procedure f_sk_X509_EXTENSION_sort(sk: PSTACK_X509_EXTENSION); external MySSL_DLL_name name fn_sk_X509_EXTENSION_sort;
  function  f_i2d_ASN1_SET_OF_X509_EXTENSION(a: PSTACK_X509_EXTENSION; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET_OF_X509_EXTENSION;
  function  f_d2i_ASN1_SET_OF_X509_EXTENSION(a: PPSTACK_X509_EXTENSION; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_EXTENSION; external MySSL_DLL_name name fn_d2i_ASN1_SET_OF_X509_EXTENSION;
  function  f_sk_X509_ATTRIBUTE_new(arg0: PFunction):PSTACK_X509_ATTRIBUTE; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_new;
  function  f_sk_X509_ATTRIBUTE_new_null:PSTACK_X509_ATTRIBUTE; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_new_null;
  procedure f_sk_X509_ATTRIBUTE_free(sk: PSTACK_X509_ATTRIBUTE); external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_free;
  function  f_sk_X509_ATTRIBUTE_num(const sk: PSTACK_X509_ATTRIBUTE):Integer; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_num;
  function  f_sk_X509_ATTRIBUTE_value(const sk: PSTACK_X509_ATTRIBUTE; n: Integer):PX509_ATTRIBUTE; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_value;
  function  f_sk_X509_ATTRIBUTE_set(sk: PSTACK_X509_ATTRIBUTE; n: Integer; v: PX509_ATTRIBUTE):PX509_ATTRIBUTE; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_set;
  procedure f_sk_X509_ATTRIBUTE_zero(sk: PSTACK_X509_ATTRIBUTE); external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_zero;
  function  f_sk_X509_ATTRIBUTE_push(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE):Integer; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_push;
  function  f_sk_X509_ATTRIBUTE_unshift(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE):Integer; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_unshift;
  function  f_sk_X509_ATTRIBUTE_find(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE):Integer; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_find;
  function  f_sk_X509_ATTRIBUTE_delete(sk: PSTACK_X509_ATTRIBUTE; n: Integer):PX509_ATTRIBUTE; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_delete;
  procedure f_sk_X509_ATTRIBUTE_delete_ptr(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE); external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_delete_ptr;
  function  f_sk_X509_ATTRIBUTE_insert(sk: PSTACK_X509_ATTRIBUTE; v: PX509_ATTRIBUTE; n: Integer):Integer; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_insert;
  function  f_sk_X509_ATTRIBUTE_dup(sk: PSTACK_X509_ATTRIBUTE):PSTACK_X509_ATTRIBUTE; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_dup;
  procedure f_sk_X509_ATTRIBUTE_pop_free(sk: PSTACK_X509_ATTRIBUTE; arg1: PFunction); external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_pop_free;
  function  f_sk_X509_ATTRIBUTE_shift(sk: PSTACK_X509_ATTRIBUTE):PX509_ATTRIBUTE; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_shift;
  function  f_sk_X509_ATTRIBUTE_pop(sk: PSTACK_X509_ATTRIBUTE):PX509_ATTRIBUTE; external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_pop;
  procedure f_sk_X509_ATTRIBUTE_sort(sk: PSTACK_X509_ATTRIBUTE); external MySSL_DLL_name name fn_sk_X509_ATTRIBUTE_sort;
  function  f_i2d_ASN1_SET_OF_X509_ATTRIBUTE(a: PSTACK_X509_ATTRIBUTE; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET_OF_X509_ATTRIBUTE;
  function  f_d2i_ASN1_SET_OF_X509_ATTRIBUTE(a: PPSTACK_X509_ATTRIBUTE; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_ATTRIBUTE; external MySSL_DLL_name name fn_d2i_ASN1_SET_OF_X509_ATTRIBUTE;
  function  f_sk_X509_new(arg0: PFunction):PSTACK_X509; external MySSL_DLL_name name fn_sk_X509_new;
  function  f_sk_X509_new_null:PSTACK_X509; external MySSL_DLL_name name fn_sk_X509_new_null;
  procedure f_sk_X509_free(sk: PSTACK_X509); external MySSL_DLL_name name fn_sk_X509_free;
  function  f_sk_X509_num(const sk: PSTACK_X509):Integer; external MySSL_DLL_name name fn_sk_X509_num;
  function  f_sk_X509_value(const sk: PSTACK_X509; n: Integer):PX509; external MySSL_DLL_name name fn_sk_X509_value;
  function  f_sk_X509_set(sk: PSTACK_X509; n: Integer; v: PX509):PX509; external MySSL_DLL_name name fn_sk_X509_set;
  procedure f_sk_X509_zero(sk: PSTACK_X509); external MySSL_DLL_name name fn_sk_X509_zero;
  function  f_sk_X509_push(sk: PSTACK_X509; v: PX509):Integer; external MySSL_DLL_name name fn_sk_X509_push;
  function  f_sk_X509_unshift(sk: PSTACK_X509; v: PX509):Integer; external MySSL_DLL_name name fn_sk_X509_unshift;
  function  f_sk_X509_find(sk: PSTACK_X509; v: PX509):Integer; external MySSL_DLL_name name fn_sk_X509_find;
  function  f_sk_X509_delete(sk: PSTACK_X509; n: Integer):PX509; external MySSL_DLL_name name fn_sk_X509_delete;
  procedure f_sk_X509_delete_ptr(sk: PSTACK_X509; v: PX509); external MySSL_DLL_name name fn_sk_X509_delete_ptr;
  function  f_sk_X509_insert(sk: PSTACK_X509; v: PX509; n: Integer):Integer; external MySSL_DLL_name name fn_sk_X509_insert;
  function  f_sk_X509_dup(sk: PSTACK_X509):PSTACK_X509; external MySSL_DLL_name name fn_sk_X509_dup;
  procedure f_sk_X509_pop_free(sk: PSTACK_X509; arg1: PFunction); external MySSL_DLL_name name fn_sk_X509_pop_free;
  function  f_sk_X509_shift(sk: PSTACK_X509):PX509; external MySSL_DLL_name name fn_sk_X509_shift;
  function  f_sk_X509_pop(sk: PSTACK_X509):PX509; external MySSL_DLL_name name fn_sk_X509_pop;
  procedure f_sk_X509_sort(sk: PSTACK_X509); external MySSL_DLL_name name fn_sk_X509_sort;
  function  f_i2d_ASN1_SET_OF_X509(a: PSTACK_X509; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET_OF_X509;
  function  f_d2i_ASN1_SET_OF_X509(a: PPSTACK_X509; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509; external MySSL_DLL_name name fn_d2i_ASN1_SET_OF_X509;
  function  f_sk_X509_REVOKED_new(arg0: PFunction):PSTACK_X509_REVOKED; external MySSL_DLL_name name fn_sk_X509_REVOKED_new;
  function  f_sk_X509_REVOKED_new_null:PSTACK_X509_REVOKED; external MySSL_DLL_name name fn_sk_X509_REVOKED_new_null;
  procedure f_sk_X509_REVOKED_free(sk: PSTACK_X509_REVOKED); external MySSL_DLL_name name fn_sk_X509_REVOKED_free;
  function  f_sk_X509_REVOKED_num(const sk: PSTACK_X509_REVOKED):Integer; external MySSL_DLL_name name fn_sk_X509_REVOKED_num;
  function  f_sk_X509_REVOKED_value(const sk: PSTACK_X509_REVOKED; n: Integer):PX509_REVOKED; external MySSL_DLL_name name fn_sk_X509_REVOKED_value;
  function  f_sk_X509_REVOKED_set(sk: PSTACK_X509_REVOKED; n: Integer; v: PX509_REVOKED):PX509_REVOKED; external MySSL_DLL_name name fn_sk_X509_REVOKED_set;
  procedure f_sk_X509_REVOKED_zero(sk: PSTACK_X509_REVOKED); external MySSL_DLL_name name fn_sk_X509_REVOKED_zero;
  function  f_sk_X509_REVOKED_push(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED):Integer; external MySSL_DLL_name name fn_sk_X509_REVOKED_push;
  function  f_sk_X509_REVOKED_unshift(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED):Integer; external MySSL_DLL_name name fn_sk_X509_REVOKED_unshift;
  function  f_sk_X509_REVOKED_find(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED):Integer; external MySSL_DLL_name name fn_sk_X509_REVOKED_find;
  function  f_sk_X509_REVOKED_delete(sk: PSTACK_X509_REVOKED; n: Integer):PX509_REVOKED; external MySSL_DLL_name name fn_sk_X509_REVOKED_delete;
  procedure f_sk_X509_REVOKED_delete_ptr(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED); external MySSL_DLL_name name fn_sk_X509_REVOKED_delete_ptr;
  function  f_sk_X509_REVOKED_insert(sk: PSTACK_X509_REVOKED; v: PX509_REVOKED; n: Integer):Integer; external MySSL_DLL_name name fn_sk_X509_REVOKED_insert;
  function  f_sk_X509_REVOKED_dup(sk: PSTACK_X509_REVOKED):PSTACK_X509_REVOKED; external MySSL_DLL_name name fn_sk_X509_REVOKED_dup;
  procedure f_sk_X509_REVOKED_pop_free(sk: PSTACK_X509_REVOKED; arg1: PFunction); external MySSL_DLL_name name fn_sk_X509_REVOKED_pop_free;
  function  f_sk_X509_REVOKED_shift(sk: PSTACK_X509_REVOKED):PX509_REVOKED; external MySSL_DLL_name name fn_sk_X509_REVOKED_shift;
  function  f_sk_X509_REVOKED_pop(sk: PSTACK_X509_REVOKED):PX509_REVOKED; external MySSL_DLL_name name fn_sk_X509_REVOKED_pop;
  procedure f_sk_X509_REVOKED_sort(sk: PSTACK_X509_REVOKED); external MySSL_DLL_name name fn_sk_X509_REVOKED_sort;
  function  f_i2d_ASN1_SET_OF_X509_REVOKED(a: PSTACK_X509_REVOKED; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET_OF_X509_REVOKED;
  function  f_d2i_ASN1_SET_OF_X509_REVOKED(a: PPSTACK_X509_REVOKED; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_REVOKED; external MySSL_DLL_name name fn_d2i_ASN1_SET_OF_X509_REVOKED;
  function  f_sk_X509_CRL_new(arg0: PFunction):PSTACK_X509_CRL; external MySSL_DLL_name name fn_sk_X509_CRL_new;
  function  f_sk_X509_CRL_new_null:PSTACK_X509_CRL; external MySSL_DLL_name name fn_sk_X509_CRL_new_null;
  procedure f_sk_X509_CRL_free(sk: PSTACK_X509_CRL); external MySSL_DLL_name name fn_sk_X509_CRL_free;
  function  f_sk_X509_CRL_num(const sk: PSTACK_X509_CRL):Integer; external MySSL_DLL_name name fn_sk_X509_CRL_num;
  function  f_sk_X509_CRL_value(const sk: PSTACK_X509_CRL; n: Integer):PX509_CRL; external MySSL_DLL_name name fn_sk_X509_CRL_value;
  function  f_sk_X509_CRL_set(sk: PSTACK_X509_CRL; n: Integer; v: PX509_CRL):PX509_CRL; external MySSL_DLL_name name fn_sk_X509_CRL_set;
  procedure f_sk_X509_CRL_zero(sk: PSTACK_X509_CRL); external MySSL_DLL_name name fn_sk_X509_CRL_zero;
  function  f_sk_X509_CRL_push(sk: PSTACK_X509_CRL; v: PX509_CRL):Integer; external MySSL_DLL_name name fn_sk_X509_CRL_push;
  function  f_sk_X509_CRL_unshift(sk: PSTACK_X509_CRL; v: PX509_CRL):Integer; external MySSL_DLL_name name fn_sk_X509_CRL_unshift;
  function  f_sk_X509_CRL_find(sk: PSTACK_X509_CRL; v: PX509_CRL):Integer; external MySSL_DLL_name name fn_sk_X509_CRL_find;
  function  f_sk_X509_CRL_delete(sk: PSTACK_X509_CRL; n: Integer):PX509_CRL; external MySSL_DLL_name name fn_sk_X509_CRL_delete;
  procedure f_sk_X509_CRL_delete_ptr(sk: PSTACK_X509_CRL; v: PX509_CRL); external MySSL_DLL_name name fn_sk_X509_CRL_delete_ptr;
  function  f_sk_X509_CRL_insert(sk: PSTACK_X509_CRL; v: PX509_CRL; n: Integer):Integer; external MySSL_DLL_name name fn_sk_X509_CRL_insert;
  function  f_sk_X509_CRL_dup(sk: PSTACK_X509_CRL):PSTACK_X509_CRL; external MySSL_DLL_name name fn_sk_X509_CRL_dup;
  procedure f_sk_X509_CRL_pop_free(sk: PSTACK_X509_CRL; arg1: PFunction); external MySSL_DLL_name name fn_sk_X509_CRL_pop_free;
  function  f_sk_X509_CRL_shift(sk: PSTACK_X509_CRL):PX509_CRL; external MySSL_DLL_name name fn_sk_X509_CRL_shift;
  function  f_sk_X509_CRL_pop(sk: PSTACK_X509_CRL):PX509_CRL; external MySSL_DLL_name name fn_sk_X509_CRL_pop;
  procedure f_sk_X509_CRL_sort(sk: PSTACK_X509_CRL); external MySSL_DLL_name name fn_sk_X509_CRL_sort;
  function  f_i2d_ASN1_SET_OF_X509_CRL(a: PSTACK_X509_CRL; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET_OF_X509_CRL;
  function  f_d2i_ASN1_SET_OF_X509_CRL(a: PPSTACK_X509_CRL; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_X509_CRL; external MySSL_DLL_name name fn_d2i_ASN1_SET_OF_X509_CRL;
  function  f_sk_X509_INFO_new(arg0: PFunction):PSTACK_X509_INFO; external MySSL_DLL_name name fn_sk_X509_INFO_new;
  function  f_sk_X509_INFO_new_null:PSTACK_X509_INFO; external MySSL_DLL_name name fn_sk_X509_INFO_new_null;
  procedure f_sk_X509_INFO_free(sk: PSTACK_X509_INFO); external MySSL_DLL_name name fn_sk_X509_INFO_free;
  function  f_sk_X509_INFO_num(const sk: PSTACK_X509_INFO):Integer; external MySSL_DLL_name name fn_sk_X509_INFO_num;
  function  f_sk_X509_INFO_value(const sk: PSTACK_X509_INFO; n: Integer):PX509_INFO; external MySSL_DLL_name name fn_sk_X509_INFO_value;
  function  f_sk_X509_INFO_set(sk: PSTACK_X509_INFO; n: Integer; v: PX509_INFO):PX509_INFO; external MySSL_DLL_name name fn_sk_X509_INFO_set;
  procedure f_sk_X509_INFO_zero(sk: PSTACK_X509_INFO); external MySSL_DLL_name name fn_sk_X509_INFO_zero;
  function  f_sk_X509_INFO_push(sk: PSTACK_X509_INFO; v: PX509_INFO):Integer; external MySSL_DLL_name name fn_sk_X509_INFO_push;
  function  f_sk_X509_INFO_unshift(sk: PSTACK_X509_INFO; v: PX509_INFO):Integer; external MySSL_DLL_name name fn_sk_X509_INFO_unshift;
  function  f_sk_X509_INFO_find(sk: PSTACK_X509_INFO; v: PX509_INFO):Integer; external MySSL_DLL_name name fn_sk_X509_INFO_find;
  function  f_sk_X509_INFO_delete(sk: PSTACK_X509_INFO; n: Integer):PX509_INFO; external MySSL_DLL_name name fn_sk_X509_INFO_delete;
  procedure f_sk_X509_INFO_delete_ptr(sk: PSTACK_X509_INFO; v: PX509_INFO); external MySSL_DLL_name name fn_sk_X509_INFO_delete_ptr;
  function  f_sk_X509_INFO_insert(sk: PSTACK_X509_INFO; v: PX509_INFO; n: Integer):Integer; external MySSL_DLL_name name fn_sk_X509_INFO_insert;
  function  f_sk_X509_INFO_dup(sk: PSTACK_X509_INFO):PSTACK_X509_INFO; external MySSL_DLL_name name fn_sk_X509_INFO_dup;
  procedure f_sk_X509_INFO_pop_free(sk: PSTACK_X509_INFO; arg1: PFunction); external MySSL_DLL_name name fn_sk_X509_INFO_pop_free;
  function  f_sk_X509_INFO_shift(sk: PSTACK_X509_INFO):PX509_INFO; external MySSL_DLL_name name fn_sk_X509_INFO_shift;
  function  f_sk_X509_INFO_pop(sk: PSTACK_X509_INFO):PX509_INFO; external MySSL_DLL_name name fn_sk_X509_INFO_pop;
  procedure f_sk_X509_INFO_sort(sk: PSTACK_X509_INFO); external MySSL_DLL_name name fn_sk_X509_INFO_sort;
  function  f_sk_X509_LOOKUP_new(arg0: PFunction):PSTACK_X509_LOOKUP; external MySSL_DLL_name name fn_sk_X509_LOOKUP_new;
  function  f_sk_X509_LOOKUP_new_null:PSTACK_X509_LOOKUP; external MySSL_DLL_name name fn_sk_X509_LOOKUP_new_null;
  procedure f_sk_X509_LOOKUP_free(sk: PSTACK_X509_LOOKUP); external MySSL_DLL_name name fn_sk_X509_LOOKUP_free;
  function  f_sk_X509_LOOKUP_num(const sk: PSTACK_X509_LOOKUP):Integer; external MySSL_DLL_name name fn_sk_X509_LOOKUP_num;
  function  f_sk_X509_LOOKUP_value(const sk: PSTACK_X509_LOOKUP; n: Integer):PX509_LOOKUP; external MySSL_DLL_name name fn_sk_X509_LOOKUP_value;
  function  f_sk_X509_LOOKUP_set(sk: PSTACK_X509_LOOKUP; n: Integer; v: PX509_LOOKUP):PX509_LOOKUP; external MySSL_DLL_name name fn_sk_X509_LOOKUP_set;
  procedure f_sk_X509_LOOKUP_zero(sk: PSTACK_X509_LOOKUP); external MySSL_DLL_name name fn_sk_X509_LOOKUP_zero;
  function  f_sk_X509_LOOKUP_push(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP):Integer; external MySSL_DLL_name name fn_sk_X509_LOOKUP_push;
  function  f_sk_X509_LOOKUP_unshift(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP):Integer; external MySSL_DLL_name name fn_sk_X509_LOOKUP_unshift;
  function  f_sk_X509_LOOKUP_find(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP):Integer; external MySSL_DLL_name name fn_sk_X509_LOOKUP_find;
  function  f_sk_X509_LOOKUP_delete(sk: PSTACK_X509_LOOKUP; n: Integer):PX509_LOOKUP; external MySSL_DLL_name name fn_sk_X509_LOOKUP_delete;
  procedure f_sk_X509_LOOKUP_delete_ptr(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP); external MySSL_DLL_name name fn_sk_X509_LOOKUP_delete_ptr;
  function  f_sk_X509_LOOKUP_insert(sk: PSTACK_X509_LOOKUP; v: PX509_LOOKUP; n: Integer):Integer; external MySSL_DLL_name name fn_sk_X509_LOOKUP_insert;
  function  f_sk_X509_LOOKUP_dup(sk: PSTACK_X509_LOOKUP):PSTACK_X509_LOOKUP; external MySSL_DLL_name name fn_sk_X509_LOOKUP_dup;
  procedure f_sk_X509_LOOKUP_pop_free(sk: PSTACK_X509_LOOKUP; arg1: PFunction); external MySSL_DLL_name name fn_sk_X509_LOOKUP_pop_free;
  function  f_sk_X509_LOOKUP_shift(sk: PSTACK_X509_LOOKUP):PX509_LOOKUP; external MySSL_DLL_name name fn_sk_X509_LOOKUP_shift;
  function  f_sk_X509_LOOKUP_pop(sk: PSTACK_X509_LOOKUP):PX509_LOOKUP; external MySSL_DLL_name name fn_sk_X509_LOOKUP_pop;
  procedure f_sk_X509_LOOKUP_sort(sk: PSTACK_X509_LOOKUP); external MySSL_DLL_name name fn_sk_X509_LOOKUP_sort;
  function  f_X509_OBJECT_retrieve_by_subject(h: PLHASH; _type: Integer; name: PX509_NAME):PX509_OBJECT; external MySSL_DLL_name name fn_X509_OBJECT_retrieve_by_subject;
  procedure f_X509_OBJECT_up_ref_count(a: PX509_OBJECT); external MySSL_DLL_name name fn_X509_OBJECT_up_ref_count;
  procedure f_X509_OBJECT_free_contents(a: PX509_OBJECT); external MySSL_DLL_name name fn_X509_OBJECT_free_contents;
  function  f_X509_STORE_new:PX509_STORE; external MySSL_DLL_name name fn_X509_STORE_new;
  procedure f_X509_STORE_free(v: PX509_STORE); external MySSL_DLL_name name fn_X509_STORE_free;
  procedure f_X509_STORE_CTX_init(ctx: PX509_STORE_CTX; store: PX509_STORE; x509: PX509; chain: PSTACK_X509); external MySSL_DLL_name name fn_X509_STORE_CTX_init;
  procedure f_X509_STORE_CTX_cleanup(ctx: PX509_STORE_CTX); external MySSL_DLL_name name fn_X509_STORE_CTX_cleanup;
  function  f_X509_STORE_add_lookup(v: PX509_STORE; m: PX509_LOOKUP_METHOD):PX509_LOOKUP; external MySSL_DLL_name name fn_X509_STORE_add_lookup;
  function  f_X509_LOOKUP_hash_dir:PX509_LOOKUP_METHOD; external MySSL_DLL_name name fn_X509_LOOKUP_hash_dir;
  function  f_X509_LOOKUP_file:PX509_LOOKUP_METHOD; external MySSL_DLL_name name fn_X509_LOOKUP_file;
  function  f_X509_STORE_add_cert(ctx: PX509_STORE; x: PX509):Integer; external MySSL_DLL_name name fn_X509_STORE_add_cert;
  function  f_X509_STORE_add_crl(ctx: PX509_STORE; x: PX509_CRL):Integer; external MySSL_DLL_name name fn_X509_STORE_add_crl;
  function  f_X509_STORE_get_by_subject(vs: PX509_STORE_CTX; _type: Integer; name: PX509_NAME; ret: PX509_OBJECT):Integer; external MySSL_DLL_name name fn_X509_STORE_get_by_subject;
  function  f_X509_LOOKUP_ctrl(ctx: PX509_LOOKUP; cmd: Integer; const argc: PChar; argl: Longint; ret: PPChar):Integer; external MySSL_DLL_name name fn_X509_LOOKUP_ctrl;
  function  f_X509_load_cert_file(ctx: PX509_LOOKUP; const _file: PChar; _type: Integer):Integer; external MySSL_DLL_name name fn_X509_load_cert_file;
  function  f_X509_load_crl_file(ctx: PX509_LOOKUP; const _file: PChar; _type: Integer):Integer; external MySSL_DLL_name name fn_X509_load_crl_file;
  function  f_X509_LOOKUP_new(method: PX509_LOOKUP_METHOD):PX509_LOOKUP; external MySSL_DLL_name name fn_X509_LOOKUP_new;
  procedure f_X509_LOOKUP_free(ctx: PX509_LOOKUP); external MySSL_DLL_name name fn_X509_LOOKUP_free;
  function  f_X509_LOOKUP_init(ctx: PX509_LOOKUP):Integer; external MySSL_DLL_name name fn_X509_LOOKUP_init;
  function  f_X509_LOOKUP_by_subject(ctx: PX509_LOOKUP; _type: Integer; name: PX509_NAME; ret: PX509_OBJECT):Integer; external MySSL_DLL_name name fn_X509_LOOKUP_by_subject;
  function  f_X509_LOOKUP_by_issuer_serial(ctx: PX509_LOOKUP; _type: Integer; name: PX509_NAME; serial: PASN1_STRING; ret: PX509_OBJECT):Integer; external MySSL_DLL_name name fn_X509_LOOKUP_by_issuer_serial;
  function  f_X509_LOOKUP_by_fingerprint(ctx: PX509_LOOKUP; _type: Integer; bytes: PChar; len: Integer; ret: PX509_OBJECT):Integer; external MySSL_DLL_name name fn_X509_LOOKUP_by_fingerprint;
  function  f_X509_LOOKUP_by_alias(ctx: PX509_LOOKUP; _type: Integer; str: PChar; len: Integer; ret: PX509_OBJECT):Integer; external MySSL_DLL_name name fn_X509_LOOKUP_by_alias;
  function  f_X509_LOOKUP_shutdown(ctx: PX509_LOOKUP):Integer; external MySSL_DLL_name name fn_X509_LOOKUP_shutdown;
  function  f_X509_STORE_load_locations(ctx: PX509_STORE; const _file: PChar; const dir: PChar):Integer; external MySSL_DLL_name name fn_X509_STORE_load_locations;
  function  f_X509_STORE_set_default_paths(ctx: PX509_STORE):Integer; external MySSL_DLL_name name fn_X509_STORE_set_default_paths;
  function  f_X509_STORE_CTX_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; external MySSL_DLL_name name fn_X509_STORE_CTX_get_ex_new_index;
  function  f_X509_STORE_CTX_set_ex_data(ctx: PX509_STORE_CTX; idx: Integer; data: Pointer):Integer; external MySSL_DLL_name name fn_X509_STORE_CTX_set_ex_data;
  function  f_X509_STORE_CTX_get_ex_data(ctx: PX509_STORE_CTX; idx: Integer):Pointer; external MySSL_DLL_name name fn_X509_STORE_CTX_get_ex_data;
  function  f_X509_STORE_CTX_get_error(ctx: PX509_STORE_CTX):Integer; external MySSL_DLL_name name fn_X509_STORE_CTX_get_error;
  procedure f_X509_STORE_CTX_set_error(ctx: PX509_STORE_CTX; s: Integer); external MySSL_DLL_name name fn_X509_STORE_CTX_set_error;
  function  f_X509_STORE_CTX_get_error_depth(ctx: PX509_STORE_CTX):Integer; external MySSL_DLL_name name fn_X509_STORE_CTX_get_error_depth;
  function  f_X509_STORE_CTX_get_current_cert(ctx: PX509_STORE_CTX):PX509; external MySSL_DLL_name name fn_X509_STORE_CTX_get_current_cert;
  function  f_X509_STORE_CTX_get_chain(ctx: PX509_STORE_CTX):PSTACK_X509; external MySSL_DLL_name name fn_X509_STORE_CTX_get_chain;
  procedure f_X509_STORE_CTX_set_cert(c: PX509_STORE_CTX; x: PX509); external MySSL_DLL_name name fn_X509_STORE_CTX_set_cert;
  procedure f_X509_STORE_CTX_set_chain(c: PX509_STORE_CTX; sk: PSTACK_X509); external MySSL_DLL_name name fn_X509_STORE_CTX_set_chain;
  function  f_sk_PKCS7_SIGNER_INFO_new(arg0: PFunction):PSTACK_PKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_new;
  function  f_sk_PKCS7_SIGNER_INFO_new_null:PSTACK_PKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_new_null;
  procedure f_sk_PKCS7_SIGNER_INFO_free(sk: PSTACK_PKCS7_SIGNER_INFO); external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_free;
  function  f_sk_PKCS7_SIGNER_INFO_num(const sk: PSTACK_PKCS7_SIGNER_INFO):Integer; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_num;
  function  f_sk_PKCS7_SIGNER_INFO_value(const sk: PSTACK_PKCS7_SIGNER_INFO; n: Integer):PPKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_value;
  function  f_sk_PKCS7_SIGNER_INFO_set(sk: PSTACK_PKCS7_SIGNER_INFO; n: Integer; v: PPKCS7_SIGNER_INFO):PPKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_set;
  procedure f_sk_PKCS7_SIGNER_INFO_zero(sk: PSTACK_PKCS7_SIGNER_INFO); external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_zero;
  function  f_sk_PKCS7_SIGNER_INFO_push(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO):Integer; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_push;
  function  f_sk_PKCS7_SIGNER_INFO_unshift(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO):Integer; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_unshift;
  function  f_sk_PKCS7_SIGNER_INFO_find(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO):Integer; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_find;
  function  f_sk_PKCS7_SIGNER_INFO_delete(sk: PSTACK_PKCS7_SIGNER_INFO; n: Integer):PPKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_delete;
  procedure f_sk_PKCS7_SIGNER_INFO_delete_ptr(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO); external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_delete_ptr;
  function  f_sk_PKCS7_SIGNER_INFO_insert(sk: PSTACK_PKCS7_SIGNER_INFO; v: PPKCS7_SIGNER_INFO; n: Integer):Integer; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_insert;
  function  f_sk_PKCS7_SIGNER_INFO_dup(sk: PSTACK_PKCS7_SIGNER_INFO):PSTACK_PKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_dup;
  procedure f_sk_PKCS7_SIGNER_INFO_pop_free(sk: PSTACK_PKCS7_SIGNER_INFO; arg1: PFunction); external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_pop_free;
  function  f_sk_PKCS7_SIGNER_INFO_shift(sk: PSTACK_PKCS7_SIGNER_INFO):PPKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_shift;
  function  f_sk_PKCS7_SIGNER_INFO_pop(sk: PSTACK_PKCS7_SIGNER_INFO):PPKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_pop;
  procedure f_sk_PKCS7_SIGNER_INFO_sort(sk: PSTACK_PKCS7_SIGNER_INFO); external MySSL_DLL_name name fn_sk_PKCS7_SIGNER_INFO_sort;
  function  f_i2d_ASN1_SET_OF_PKCS7_SIGNER_INFO(a: PSTACK_PKCS7_SIGNER_INFO; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET_OF_PKCS7_SIGNER_INFO;
  function  f_d2i_ASN1_SET_OF_PKCS7_SIGNER_INFO(a: PPSTACK_PKCS7_SIGNER_INFO; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_PKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_d2i_ASN1_SET_OF_PKCS7_SIGNER_INFO;
  function  f_sk_PKCS7_RECIP_INFO_new(arg0: PFunction):PSTACK_PKCS7_RECIP_INFO; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_new;
  function  f_sk_PKCS7_RECIP_INFO_new_null:PSTACK_PKCS7_RECIP_INFO; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_new_null;
  procedure f_sk_PKCS7_RECIP_INFO_free(sk: PSTACK_PKCS7_RECIP_INFO); external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_free;
  function  f_sk_PKCS7_RECIP_INFO_num(const sk: PSTACK_PKCS7_RECIP_INFO):Integer; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_num;
  function  f_sk_PKCS7_RECIP_INFO_value(const sk: PSTACK_PKCS7_RECIP_INFO; n: Integer):PPKCS7_RECIP_INFO; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_value;
  function  f_sk_PKCS7_RECIP_INFO_set(sk: PSTACK_PKCS7_RECIP_INFO; n: Integer; v: PPKCS7_RECIP_INFO):PPKCS7_RECIP_INFO; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_set;
  procedure f_sk_PKCS7_RECIP_INFO_zero(sk: PSTACK_PKCS7_RECIP_INFO); external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_zero;
  function  f_sk_PKCS7_RECIP_INFO_push(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO):Integer; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_push;
  function  f_sk_PKCS7_RECIP_INFO_unshift(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO):Integer; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_unshift;
  function  f_sk_PKCS7_RECIP_INFO_find(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO):Integer; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_find;
  function  f_sk_PKCS7_RECIP_INFO_delete(sk: PSTACK_PKCS7_RECIP_INFO; n: Integer):PPKCS7_RECIP_INFO; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_delete;
  procedure f_sk_PKCS7_RECIP_INFO_delete_ptr(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO); external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_delete_ptr;
  function  f_sk_PKCS7_RECIP_INFO_insert(sk: PSTACK_PKCS7_RECIP_INFO; v: PPKCS7_RECIP_INFO; n: Integer):Integer; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_insert;
  function  f_sk_PKCS7_RECIP_INFO_dup(sk: PSTACK_PKCS7_RECIP_INFO):PSTACK_PKCS7_RECIP_INFO; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_dup;
  procedure f_sk_PKCS7_RECIP_INFO_pop_free(sk: PSTACK_PKCS7_RECIP_INFO; arg1: PFunction); external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_pop_free;
  function  f_sk_PKCS7_RECIP_INFO_shift(sk: PSTACK_PKCS7_RECIP_INFO):PPKCS7_RECIP_INFO; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_shift;
  function  f_sk_PKCS7_RECIP_INFO_pop(sk: PSTACK_PKCS7_RECIP_INFO):PPKCS7_RECIP_INFO; external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_pop;
  procedure f_sk_PKCS7_RECIP_INFO_sort(sk: PSTACK_PKCS7_RECIP_INFO); external MySSL_DLL_name name fn_sk_PKCS7_RECIP_INFO_sort;
  function  f_i2d_ASN1_SET_OF_PKCS7_RECIP_INFO(a: PSTACK_PKCS7_RECIP_INFO; pp: PPChar; arg2: PFunction; ex_tag: Integer; ex_class: Integer; is_set: Integer):Integer; external MySSL_DLL_name name fn_i2d_ASN1_SET_OF_PKCS7_RECIP_INFO;
  function  f_d2i_ASN1_SET_OF_PKCS7_RECIP_INFO(a: PPSTACK_PKCS7_RECIP_INFO; pp: PPChar; length: Longint; arg3: PFunction; arg4: PFunction; ex_tag: Integer; ex_class: Integer):PSTACK_PKCS7_RECIP_INFO; external MySSL_DLL_name name fn_d2i_ASN1_SET_OF_PKCS7_RECIP_INFO;
  function  f_PKCS7_ISSUER_AND_SERIAL_new:PPKCS7_ISSUER_AND_SERIAL; external MySSL_DLL_name name fn_PKCS7_ISSUER_AND_SERIAL_new;
  procedure f_PKCS7_ISSUER_AND_SERIAL_free(a: PPKCS7_ISSUER_AND_SERIAL); external MySSL_DLL_name name fn_PKCS7_ISSUER_AND_SERIAL_free;
  function  f_i2d_PKCS7_ISSUER_AND_SERIAL(a: PPKCS7_ISSUER_AND_SERIAL; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PKCS7_ISSUER_AND_SERIAL;
  function  f_d2i_PKCS7_ISSUER_AND_SERIAL(a: PPPKCS7_ISSUER_AND_SERIAL; pp: PPChar; length: Longint):PPKCS7_ISSUER_AND_SERIAL; external MySSL_DLL_name name fn_d2i_PKCS7_ISSUER_AND_SERIAL;
  function  f_PKCS7_ISSUER_AND_SERIAL_digest(data: PPKCS7_ISSUER_AND_SERIAL; _type: PEVP_MD; md: PChar; len: PUInteger):Integer; external MySSL_DLL_name name fn_PKCS7_ISSUER_AND_SERIAL_digest;
  function  f_d2i_PKCS7_fp(fp: PFILE; p7: PPPKCS7):PPKCS7; external MySSL_DLL_name name fn_d2i_PKCS7_fp;
  function  f_i2d_PKCS7_fp(fp: PFILE; p7: PPKCS7):Integer; external MySSL_DLL_name name fn_i2d_PKCS7_fp;
  function  f_PKCS7_dup(p7: PPKCS7):PPKCS7; external MySSL_DLL_name name fn_PKCS7_dup;
  function  f_d2i_PKCS7_bio(bp: PBIO; p7: PPPKCS7):PPKCS7; external MySSL_DLL_name name fn_d2i_PKCS7_bio;
  function  f_i2d_PKCS7_bio(bp: PBIO; p7: PPKCS7):Integer; external MySSL_DLL_name name fn_i2d_PKCS7_bio;
  function  f_PKCS7_SIGNER_INFO_new:PPKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_PKCS7_SIGNER_INFO_new;
  procedure f_PKCS7_SIGNER_INFO_free(a: PPKCS7_SIGNER_INFO); external MySSL_DLL_name name fn_PKCS7_SIGNER_INFO_free;
  function  f_i2d_PKCS7_SIGNER_INFO(a: PPKCS7_SIGNER_INFO; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PKCS7_SIGNER_INFO;
  function  f_d2i_PKCS7_SIGNER_INFO(a: PPPKCS7_SIGNER_INFO; pp: PPChar; length: Longint):PPKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_d2i_PKCS7_SIGNER_INFO;
  function  f_PKCS7_RECIP_INFO_new:PPKCS7_RECIP_INFO; external MySSL_DLL_name name fn_PKCS7_RECIP_INFO_new;
  procedure f_PKCS7_RECIP_INFO_free(a: PPKCS7_RECIP_INFO); external MySSL_DLL_name name fn_PKCS7_RECIP_INFO_free;
  function  f_i2d_PKCS7_RECIP_INFO(a: PPKCS7_RECIP_INFO; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PKCS7_RECIP_INFO;
  function  f_d2i_PKCS7_RECIP_INFO(a: PPPKCS7_RECIP_INFO; pp: PPChar; length: Longint):PPKCS7_RECIP_INFO; external MySSL_DLL_name name fn_d2i_PKCS7_RECIP_INFO;
  function  f_PKCS7_SIGNED_new:PPKCS7_SIGNED; external MySSL_DLL_name name fn_PKCS7_SIGNED_new;
  procedure f_PKCS7_SIGNED_free(a: PPKCS7_SIGNED); external MySSL_DLL_name name fn_PKCS7_SIGNED_free;
  function  f_i2d_PKCS7_SIGNED(a: PPKCS7_SIGNED; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PKCS7_SIGNED;
  function  f_d2i_PKCS7_SIGNED(a: PPPKCS7_SIGNED; pp: PPChar; length: Longint):PPKCS7_SIGNED; external MySSL_DLL_name name fn_d2i_PKCS7_SIGNED;
  function  f_PKCS7_ENC_CONTENT_new:PPKCS7_ENC_CONTENT; external MySSL_DLL_name name fn_PKCS7_ENC_CONTENT_new;
  procedure f_PKCS7_ENC_CONTENT_free(a: PPKCS7_ENC_CONTENT); external MySSL_DLL_name name fn_PKCS7_ENC_CONTENT_free;
  function  f_i2d_PKCS7_ENC_CONTENT(a: PPKCS7_ENC_CONTENT; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PKCS7_ENC_CONTENT;
  function  f_d2i_PKCS7_ENC_CONTENT(a: PPPKCS7_ENC_CONTENT; pp: PPChar; length: Longint):PPKCS7_ENC_CONTENT; external MySSL_DLL_name name fn_d2i_PKCS7_ENC_CONTENT;
  function  f_PKCS7_ENVELOPE_new:PPKCS7_ENVELOPE; external MySSL_DLL_name name fn_PKCS7_ENVELOPE_new;
  procedure f_PKCS7_ENVELOPE_free(a: PPKCS7_ENVELOPE); external MySSL_DLL_name name fn_PKCS7_ENVELOPE_free;
  function  f_i2d_PKCS7_ENVELOPE(a: PPKCS7_ENVELOPE; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PKCS7_ENVELOPE;
  function  f_d2i_PKCS7_ENVELOPE(a: PPPKCS7_ENVELOPE; pp: PPChar; length: Longint):PPKCS7_ENVELOPE; external MySSL_DLL_name name fn_d2i_PKCS7_ENVELOPE;
  function  f_PKCS7_SIGN_ENVELOPE_new:PPKCS7_SIGN_ENVELOPE; external MySSL_DLL_name name fn_PKCS7_SIGN_ENVELOPE_new;
  procedure f_PKCS7_SIGN_ENVELOPE_free(a: PPKCS7_SIGN_ENVELOPE); external MySSL_DLL_name name fn_PKCS7_SIGN_ENVELOPE_free;
  function  f_i2d_PKCS7_SIGN_ENVELOPE(a: PPKCS7_SIGN_ENVELOPE; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PKCS7_SIGN_ENVELOPE;
  function  f_d2i_PKCS7_SIGN_ENVELOPE(a: PPPKCS7_SIGN_ENVELOPE; pp: PPChar; length: Longint):PPKCS7_SIGN_ENVELOPE; external MySSL_DLL_name name fn_d2i_PKCS7_SIGN_ENVELOPE;
  function  f_PKCS7_DIGEST_new:PPKCS7_DIGEST; external MySSL_DLL_name name fn_PKCS7_DIGEST_new;
  procedure f_PKCS7_DIGEST_free(a: PPKCS7_DIGEST); external MySSL_DLL_name name fn_PKCS7_DIGEST_free;
  function  f_i2d_PKCS7_DIGEST(a: PPKCS7_DIGEST; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PKCS7_DIGEST;
  function  f_d2i_PKCS7_DIGEST(a: PPPKCS7_DIGEST; pp: PPChar; length: Longint):PPKCS7_DIGEST; external MySSL_DLL_name name fn_d2i_PKCS7_DIGEST;
  function  f_PKCS7_ENCRYPT_new:PPKCS7_ENCRYPT; external MySSL_DLL_name name fn_PKCS7_ENCRYPT_new;
  procedure f_PKCS7_ENCRYPT_free(a: PPKCS7_ENCRYPT); external MySSL_DLL_name name fn_PKCS7_ENCRYPT_free;
  function  f_i2d_PKCS7_ENCRYPT(a: PPKCS7_ENCRYPT; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PKCS7_ENCRYPT;
  function  f_d2i_PKCS7_ENCRYPT(a: PPPKCS7_ENCRYPT; pp: PPChar; length: Longint):PPKCS7_ENCRYPT; external MySSL_DLL_name name fn_d2i_PKCS7_ENCRYPT;
  function  f_PKCS7_new:PPKCS7; external MySSL_DLL_name name fn_PKCS7_new;
  procedure f_PKCS7_free(a: PPKCS7); external MySSL_DLL_name name fn_PKCS7_free;
  procedure f_PKCS7_content_free(a: PPKCS7); external MySSL_DLL_name name fn_PKCS7_content_free;
  function  f_i2d_PKCS7(a: PPKCS7; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PKCS7;
  function  f_d2i_PKCS7(a: PPPKCS7; pp: PPChar; length: Longint):PPKCS7; external MySSL_DLL_name name fn_d2i_PKCS7;
  procedure f_ERR_load_PKCS7_strings; external MySSL_DLL_name name fn_ERR_load_PKCS7_strings;
  function  f_PKCS7_ctrl(p7: PPKCS7; cmd: Integer; larg: Longint; parg: PChar):Longint; external MySSL_DLL_name name fn_PKCS7_ctrl;
  function  f_PKCS7_set_type(p7: PPKCS7; _type: Integer):Integer; external MySSL_DLL_name name fn_PKCS7_set_type;
  function  f_PKCS7_set_content(p7: PPKCS7; p7_data: PPKCS7):Integer; external MySSL_DLL_name name fn_PKCS7_set_content;
  function  f_PKCS7_SIGNER_INFO_set(p7i: PPKCS7_SIGNER_INFO; x509: PX509; pkey: PEVP_PKEY; dgst: PEVP_MD):Integer; external MySSL_DLL_name name fn_PKCS7_SIGNER_INFO_set;
  function  f_PKCS7_add_signer(p7: PPKCS7; p7i: PPKCS7_SIGNER_INFO):Integer; external MySSL_DLL_name name fn_PKCS7_add_signer;
  function  f_PKCS7_add_certificate(p7: PPKCS7; x509: PX509):Integer; external MySSL_DLL_name name fn_PKCS7_add_certificate;
  function  f_PKCS7_add_crl(p7: PPKCS7; x509: PX509_CRL):Integer; external MySSL_DLL_name name fn_PKCS7_add_crl;
  function  f_PKCS7_content_new(p7: PPKCS7; nid: Integer):Integer; external MySSL_DLL_name name fn_PKCS7_content_new;
  function  f_PKCS7_dataVerify(cert_store: PX509_STORE; ctx: PX509_STORE_CTX; bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO):Integer; external MySSL_DLL_name name fn_PKCS7_dataVerify;
  function  f_PKCS7_signatureVerify(bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO; x509: PX509):Integer; external MySSL_DLL_name name fn_PKCS7_signatureVerify;
  function  f_PKCS7_dataInit(p7: PPKCS7; bio: PBIO):PBIO; external MySSL_DLL_name name fn_PKCS7_dataInit;
  function  f_PKCS7_dataFinal(p7: PPKCS7; bio: PBIO):Integer; external MySSL_DLL_name name fn_PKCS7_dataFinal;
  function  f_PKCS7_dataDecode(p7: PPKCS7; pkey: PEVP_PKEY; in_bio: PBIO; pcert: PX509):PBIO; external MySSL_DLL_name name fn_PKCS7_dataDecode;
  function  f_PKCS7_add_signature(p7: PPKCS7; x509: PX509; pkey: PEVP_PKEY; dgst: PEVP_MD):PPKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_PKCS7_add_signature;
  function  f_PKCS7_cert_from_signer_info(p7: PPKCS7; si: PPKCS7_SIGNER_INFO):PX509; external MySSL_DLL_name name fn_PKCS7_cert_from_signer_info;
  function  f_PKCS7_get_signer_info(p7: PPKCS7):PSTACK_PKCS7_SIGNER_INFO; external MySSL_DLL_name name fn_PKCS7_get_signer_info;
  function  f_PKCS7_add_recipient(p7: PPKCS7; x509: PX509):PPKCS7_RECIP_INFO; external MySSL_DLL_name name fn_PKCS7_add_recipient;
  function  f_PKCS7_add_recipient_info(p7: PPKCS7; ri: PPKCS7_RECIP_INFO):Integer; external MySSL_DLL_name name fn_PKCS7_add_recipient_info;
  function  f_PKCS7_RECIP_INFO_set(p7i: PPKCS7_RECIP_INFO; x509: PX509):Integer; external MySSL_DLL_name name fn_PKCS7_RECIP_INFO_set;
  function  f_PKCS7_set_cipher(p7: PPKCS7; const cipher: PEVP_CIPHER):Integer; external MySSL_DLL_name name fn_PKCS7_set_cipher;
  function  f_PKCS7_get_issuer_and_serial(p7: PPKCS7; idx: Integer):PPKCS7_ISSUER_AND_SERIAL; external MySSL_DLL_name name fn_PKCS7_get_issuer_and_serial;
  function  f_PKCS7_digest_from_attributes(sk: PSTACK_X509_ATTRIBUTE):PASN1_STRING; external MySSL_DLL_name name fn_PKCS7_digest_from_attributes;
  function  f_PKCS7_add_signed_attribute(p7si: PPKCS7_SIGNER_INFO; nid: Integer; _type: Integer; data: Pointer):Integer; external MySSL_DLL_name name fn_PKCS7_add_signed_attribute;
  function  f_PKCS7_add_attribute(p7si: PPKCS7_SIGNER_INFO; nid: Integer; atrtype: Integer; value: Pointer):Integer; external MySSL_DLL_name name fn_PKCS7_add_attribute;
  function  f_PKCS7_get_attribute(si: PPKCS7_SIGNER_INFO; nid: Integer):PASN1_TYPE; external MySSL_DLL_name name fn_PKCS7_get_attribute;
  function  f_PKCS7_get_signed_attribute(si: PPKCS7_SIGNER_INFO; nid: Integer):PASN1_TYPE; external MySSL_DLL_name name fn_PKCS7_get_signed_attribute;
  function  f_PKCS7_set_signed_attributes(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_X509_ATTRIBUTE):Integer; external MySSL_DLL_name name fn_PKCS7_set_signed_attributes;
  function  f_PKCS7_set_attributes(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_X509_ATTRIBUTE):Integer; external MySSL_DLL_name name fn_PKCS7_set_attributes;
  function  f_X509_verify_cert_error_string(n: Longint):PChar; external MySSL_DLL_name name fn_X509_verify_cert_error_string;
  function  f_X509_verify(a: PX509; r: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_X509_verify;
  function  f_X509_REQ_verify(a: PX509_REQ; r: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_X509_REQ_verify;
  function  f_X509_CRL_verify(a: PX509_CRL; r: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_X509_CRL_verify;
  function  f_NETSCAPE_SPKI_verify(a: PNETSCAPE_SPKI; r: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_NETSCAPE_SPKI_verify;
  function  f_X509_sign(x: PX509; pkey: PEVP_PKEY; const md: PEVP_MD):Integer; external MySSL_DLL_name name fn_X509_sign;
  function  f_X509_REQ_sign(x: PX509_REQ; pkey: PEVP_PKEY; const md: PEVP_MD):Integer; external MySSL_DLL_name name fn_X509_REQ_sign;
  function  f_X509_CRL_sign(x: PX509_CRL; pkey: PEVP_PKEY; const md: PEVP_MD):Integer; external MySSL_DLL_name name fn_X509_CRL_sign;
  function  f_NETSCAPE_SPKI_sign(x: PNETSCAPE_SPKI; pkey: PEVP_PKEY; const md: PEVP_MD):Integer; external MySSL_DLL_name name fn_NETSCAPE_SPKI_sign;
  function  f_X509_digest(data: PX509; _type: PEVP_MD; md: PChar; len: PUInteger):Integer; external MySSL_DLL_name name fn_X509_digest;
  function  f_X509_NAME_digest(data: PX509_NAME; _type: PEVP_MD; md: PChar; len: PUInteger):Integer; external MySSL_DLL_name name fn_X509_NAME_digest;
  function  f_d2i_X509_fp(fp: PFILE; x509: PPX509):PX509; external MySSL_DLL_name name fn_d2i_X509_fp;
  function  f_i2d_X509_fp(fp: PFILE; x509: PX509):Integer; external MySSL_DLL_name name fn_i2d_X509_fp;
  function  f_d2i_X509_CRL_fp(fp: PFILE; crl: PPX509_CRL):PX509_CRL; external MySSL_DLL_name name fn_d2i_X509_CRL_fp;
  function  f_i2d_X509_CRL_fp(fp: PFILE; crl: PX509_CRL):Integer; external MySSL_DLL_name name fn_i2d_X509_CRL_fp;
  function  f_d2i_X509_REQ_fp(fp: PFILE; req: PPX509_REQ):PX509_REQ; external MySSL_DLL_name name fn_d2i_X509_REQ_fp;
  function  f_i2d_X509_REQ_fp(fp: PFILE; req: PX509_REQ):Integer; external MySSL_DLL_name name fn_i2d_X509_REQ_fp;
  function  f_d2i_RSAPrivateKey_fp(fp: PFILE; rsa: PPRSA):PRSA; external MySSL_DLL_name name fn_d2i_RSAPrivateKey_fp;
  function  f_i2d_RSAPrivateKey_fp(fp: PFILE; rsa: PRSA):Integer; external MySSL_DLL_name name fn_i2d_RSAPrivateKey_fp;
  function  f_d2i_RSAPublicKey_fp(fp: PFILE; rsa: PPRSA):PRSA; external MySSL_DLL_name name fn_d2i_RSAPublicKey_fp;
  function  f_i2d_RSAPublicKey_fp(fp: PFILE; rsa: PRSA):Integer; external MySSL_DLL_name name fn_i2d_RSAPublicKey_fp;
  function  f_d2i_DSAPrivateKey_fp(fp: PFILE; dsa: PPDSA):PDSA; external MySSL_DLL_name name fn_d2i_DSAPrivateKey_fp;
  function  f_i2d_DSAPrivateKey_fp(fp: PFILE; dsa: PDSA):Integer; external MySSL_DLL_name name fn_i2d_DSAPrivateKey_fp;
  function  f_d2i_PKCS8_fp(fp: PFILE; p8: PPX509_SIG):PX509_SIG; external MySSL_DLL_name name fn_d2i_PKCS8_fp;
  function  f_i2d_PKCS8_fp(fp: PFILE; p8: PX509_SIG):Integer; external MySSL_DLL_name name fn_i2d_PKCS8_fp;
  function  f_d2i_PKCS8_PRIV_KEY_INFO_fp(fp: PFILE; p8inf: PPPKCS8_PRIV_KEY_INFO):PPKCS8_PRIV_KEY_INFO; external MySSL_DLL_name name fn_d2i_PKCS8_PRIV_KEY_INFO_fp;
  function  f_i2d_PKCS8_PRIV_KEY_INFO_fp(fp: PFILE; p8inf: PPKCS8_PRIV_KEY_INFO):Integer; external MySSL_DLL_name name fn_i2d_PKCS8_PRIV_KEY_INFO_fp;
  function  f_d2i_X509_bio(bp: PBIO; x509: PPX509):PX509; external MySSL_DLL_name name fn_d2i_X509_bio;
  function  f_i2d_X509_bio(bp: PBIO; x509: PX509):Integer; external MySSL_DLL_name name fn_i2d_X509_bio;
  function  f_d2i_X509_CRL_bio(bp: PBIO; crl: PPX509_CRL):PX509_CRL; external MySSL_DLL_name name fn_d2i_X509_CRL_bio;
  function  f_i2d_X509_CRL_bio(bp: PBIO; crl: PX509_CRL):Integer; external MySSL_DLL_name name fn_i2d_X509_CRL_bio;
  function  f_d2i_X509_REQ_bio(bp: PBIO; req: PPX509_REQ):PX509_REQ; external MySSL_DLL_name name fn_d2i_X509_REQ_bio;
  function  f_i2d_X509_REQ_bio(bp: PBIO; req: PX509_REQ):Integer; external MySSL_DLL_name name fn_i2d_X509_REQ_bio;
  function  f_d2i_RSAPrivateKey_bio(bp: PBIO; rsa: PPRSA):PRSA; external MySSL_DLL_name name fn_d2i_RSAPrivateKey_bio;
  function  f_i2d_RSAPrivateKey_bio(bp: PBIO; rsa: PRSA):Integer; external MySSL_DLL_name name fn_i2d_RSAPrivateKey_bio;
  function  f_d2i_RSAPublicKey_bio(bp: PBIO; rsa: PPRSA):PRSA; external MySSL_DLL_name name fn_d2i_RSAPublicKey_bio;
  function  f_i2d_RSAPublicKey_bio(bp: PBIO; rsa: PRSA):Integer; external MySSL_DLL_name name fn_i2d_RSAPublicKey_bio;
  function  f_d2i_DSAPrivateKey_bio(bp: PBIO; dsa: PPDSA):PDSA; external MySSL_DLL_name name fn_d2i_DSAPrivateKey_bio;
  function  f_i2d_DSAPrivateKey_bio(bp: PBIO; dsa: PDSA):Integer; external MySSL_DLL_name name fn_i2d_DSAPrivateKey_bio;
  function  f_d2i_PKCS8_bio(bp: PBIO; p8: PPX509_SIG):PX509_SIG; external MySSL_DLL_name name fn_d2i_PKCS8_bio;
  function  f_i2d_PKCS8_bio(bp: PBIO; p8: PX509_SIG):Integer; external MySSL_DLL_name name fn_i2d_PKCS8_bio;
  function  f_d2i_PKCS8_PRIV_KEY_INFO_bio(bp: PBIO; p8inf: PPPKCS8_PRIV_KEY_INFO):PPKCS8_PRIV_KEY_INFO; external MySSL_DLL_name name fn_d2i_PKCS8_PRIV_KEY_INFO_bio;
  function  f_i2d_PKCS8_PRIV_KEY_INFO_bio(bp: PBIO; p8inf: PPKCS8_PRIV_KEY_INFO):Integer; external MySSL_DLL_name name fn_i2d_PKCS8_PRIV_KEY_INFO_bio;
  function  f_X509_dup(x509: PX509):PX509; external MySSL_DLL_name name fn_X509_dup;
  function  f_X509_ATTRIBUTE_dup(xa: PX509_ATTRIBUTE):PX509_ATTRIBUTE; external MySSL_DLL_name name fn_X509_ATTRIBUTE_dup;
  function  f_X509_EXTENSION_dup(ex: PX509_EXTENSION):PX509_EXTENSION; external MySSL_DLL_name name fn_X509_EXTENSION_dup;
  function  f_X509_CRL_dup(crl: PX509_CRL):PX509_CRL; external MySSL_DLL_name name fn_X509_CRL_dup;
  function  f_X509_REQ_dup(req: PX509_REQ):PX509_REQ; external MySSL_DLL_name name fn_X509_REQ_dup;
  function  f_X509_ALGOR_dup(xn: PX509_ALGOR):PX509_ALGOR; external MySSL_DLL_name name fn_X509_ALGOR_dup;
  function  f_X509_NAME_dup(xn: PX509_NAME):PX509_NAME; external MySSL_DLL_name name fn_X509_NAME_dup;
  function  f_X509_NAME_ENTRY_dup(ne: PX509_NAME_ENTRY):PX509_NAME_ENTRY; external MySSL_DLL_name name fn_X509_NAME_ENTRY_dup;
  function  f_RSAPublicKey_dup(rsa: PRSA):PRSA; external MySSL_DLL_name name fn_RSAPublicKey_dup;
  function  f_RSAPrivateKey_dup(rsa: PRSA):PRSA; external MySSL_DLL_name name fn_RSAPrivateKey_dup;
  function  f_X509_cmp_current_time(s: PASN1_STRING):Integer; external MySSL_DLL_name name fn_X509_cmp_current_time;
  function  f_X509_gmtime_adj(s: PASN1_STRING; adj: Longint):PASN1_STRING; external MySSL_DLL_name name fn_X509_gmtime_adj;
  function  f_X509_get_default_cert_area:PChar; external MySSL_DLL_name name fn_X509_get_default_cert_area;
  function  f_X509_get_default_cert_dir:PChar; external MySSL_DLL_name name fn_X509_get_default_cert_dir;
  function  f_X509_get_default_cert_file:PChar; external MySSL_DLL_name name fn_X509_get_default_cert_file;
  function  f_X509_get_default_cert_dir_env:PChar; external MySSL_DLL_name name fn_X509_get_default_cert_dir_env;
  function  f_X509_get_default_cert_file_env:PChar; external MySSL_DLL_name name fn_X509_get_default_cert_file_env;
  function  f_X509_get_default_private_dir:PChar; external MySSL_DLL_name name fn_X509_get_default_private_dir;
  function  f_X509_to_X509_REQ(x: PX509; pkey: PEVP_PKEY; md: PEVP_MD):PX509_REQ; external MySSL_DLL_name name fn_X509_to_X509_REQ;
  function  f_X509_REQ_to_X509(r: PX509_REQ; days: Integer; pkey: PEVP_PKEY):PX509; external MySSL_DLL_name name fn_X509_REQ_to_X509;
  procedure f_ERR_load_X509_strings; external MySSL_DLL_name name fn_ERR_load_X509_strings;
  function  f_X509_ALGOR_new:PX509_ALGOR; external MySSL_DLL_name name fn_X509_ALGOR_new;
  procedure f_X509_ALGOR_free(a: PX509_ALGOR); external MySSL_DLL_name name fn_X509_ALGOR_free;
  function  f_i2d_X509_ALGOR(a: PX509_ALGOR; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_ALGOR;
  function  f_d2i_X509_ALGOR(a: PPX509_ALGOR; pp: PPChar; length: Longint):PX509_ALGOR; external MySSL_DLL_name name fn_d2i_X509_ALGOR;
  function  f_X509_VAL_new:PX509_VAL; external MySSL_DLL_name name fn_X509_VAL_new;
  procedure f_X509_VAL_free(a: PX509_VAL); external MySSL_DLL_name name fn_X509_VAL_free;
  function  f_i2d_X509_VAL(a: PX509_VAL; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_VAL;
  function  f_d2i_X509_VAL(a: PPX509_VAL; pp: PPChar; length: Longint):PX509_VAL; external MySSL_DLL_name name fn_d2i_X509_VAL;
  function  f_X509_PUBKEY_new:PX509_PUBKEY; external MySSL_DLL_name name fn_X509_PUBKEY_new;
  procedure f_X509_PUBKEY_free(a: PX509_PUBKEY); external MySSL_DLL_name name fn_X509_PUBKEY_free;
  function  f_i2d_X509_PUBKEY(a: PX509_PUBKEY; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_PUBKEY;
  function  f_d2i_X509_PUBKEY(a: PPX509_PUBKEY; pp: PPChar; length: Longint):PX509_PUBKEY; external MySSL_DLL_name name fn_d2i_X509_PUBKEY;
  function  f_X509_PUBKEY_set(x: PPX509_PUBKEY; pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_X509_PUBKEY_set;
  function  f_X509_PUBKEY_get(key: PX509_PUBKEY):PEVP_PKEY; external MySSL_DLL_name name fn_X509_PUBKEY_get;
  function  f_X509_get_pubkey_parameters(pkey: PEVP_PKEY; chain: PSTACK_X509):Integer; external MySSL_DLL_name name fn_X509_get_pubkey_parameters;
  function  f_X509_SIG_new:PX509_SIG; external MySSL_DLL_name name fn_X509_SIG_new;
  procedure f_X509_SIG_free(a: PX509_SIG); external MySSL_DLL_name name fn_X509_SIG_free;
  function  f_i2d_X509_SIG(a: PX509_SIG; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_SIG;
  function  f_d2i_X509_SIG(a: PPX509_SIG; pp: PPChar; length: Longint):PX509_SIG; external MySSL_DLL_name name fn_d2i_X509_SIG;
  function  f_X509_REQ_INFO_new:PX509_REQ_INFO; external MySSL_DLL_name name fn_X509_REQ_INFO_new;
  procedure f_X509_REQ_INFO_free(a: PX509_REQ_INFO); external MySSL_DLL_name name fn_X509_REQ_INFO_free;
  function  f_i2d_X509_REQ_INFO(a: PX509_REQ_INFO; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_REQ_INFO;
  function  f_d2i_X509_REQ_INFO(a: PPX509_REQ_INFO; pp: PPChar; length: Longint):PX509_REQ_INFO; external MySSL_DLL_name name fn_d2i_X509_REQ_INFO;
  function  f_X509_REQ_new:PX509_REQ; external MySSL_DLL_name name fn_X509_REQ_new;
  procedure f_X509_REQ_free(a: PX509_REQ); external MySSL_DLL_name name fn_X509_REQ_free;
  function  f_i2d_X509_REQ(a: PX509_REQ; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_REQ;
  function  f_d2i_X509_REQ(a: PPX509_REQ; pp: PPChar; length: Longint):PX509_REQ; external MySSL_DLL_name name fn_d2i_X509_REQ;
  function  f_X509_ATTRIBUTE_new:PX509_ATTRIBUTE; external MySSL_DLL_name name fn_X509_ATTRIBUTE_new;
  procedure f_X509_ATTRIBUTE_free(a: PX509_ATTRIBUTE); external MySSL_DLL_name name fn_X509_ATTRIBUTE_free;
  function  f_i2d_X509_ATTRIBUTE(a: PX509_ATTRIBUTE; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_ATTRIBUTE;
  function  f_d2i_X509_ATTRIBUTE(a: PPX509_ATTRIBUTE; pp: PPChar; length: Longint):PX509_ATTRIBUTE; external MySSL_DLL_name name fn_d2i_X509_ATTRIBUTE;
  function  f_X509_ATTRIBUTE_create(nid: Integer; atrtype: Integer; value: Pointer):PX509_ATTRIBUTE; external MySSL_DLL_name name fn_X509_ATTRIBUTE_create;
  function  f_X509_EXTENSION_new:PX509_EXTENSION; external MySSL_DLL_name name fn_X509_EXTENSION_new;
  procedure f_X509_EXTENSION_free(a: PX509_EXTENSION); external MySSL_DLL_name name fn_X509_EXTENSION_free;
  function  f_i2d_X509_EXTENSION(a: PX509_EXTENSION; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_EXTENSION;
  function  f_d2i_X509_EXTENSION(a: PPX509_EXTENSION; pp: PPChar; length: Longint):PX509_EXTENSION; external MySSL_DLL_name name fn_d2i_X509_EXTENSION;
  function  f_X509_NAME_ENTRY_new:PX509_NAME_ENTRY; external MySSL_DLL_name name fn_X509_NAME_ENTRY_new;
  procedure f_X509_NAME_ENTRY_free(a: PX509_NAME_ENTRY); external MySSL_DLL_name name fn_X509_NAME_ENTRY_free;
  function  f_i2d_X509_NAME_ENTRY(a: PX509_NAME_ENTRY; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_NAME_ENTRY;
  function  f_d2i_X509_NAME_ENTRY(a: PPX509_NAME_ENTRY; pp: PPChar; length: Longint):PX509_NAME_ENTRY; external MySSL_DLL_name name fn_d2i_X509_NAME_ENTRY;
  function  f_X509_NAME_new:PX509_NAME; external MySSL_DLL_name name fn_X509_NAME_new;
  procedure f_X509_NAME_free(a: PX509_NAME); external MySSL_DLL_name name fn_X509_NAME_free;
  function  f_i2d_X509_NAME(a: PX509_NAME; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_NAME;
  function  f_d2i_X509_NAME(a: PPX509_NAME; pp: PPChar; length: Longint):PX509_NAME; external MySSL_DLL_name name fn_d2i_X509_NAME;
  function  f_X509_NAME_set(xn: PPX509_NAME; name: PX509_NAME):Integer; external MySSL_DLL_name name fn_X509_NAME_set;
  function  f_X509_CINF_new:PX509_CINF; external MySSL_DLL_name name fn_X509_CINF_new;
  procedure f_X509_CINF_free(a: PX509_CINF); external MySSL_DLL_name name fn_X509_CINF_free;
  function  f_i2d_X509_CINF(a: PX509_CINF; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_CINF;
  function  f_d2i_X509_CINF(a: PPX509_CINF; pp: PPChar; length: Longint):PX509_CINF; external MySSL_DLL_name name fn_d2i_X509_CINF;
  function  f_X509_new:PX509; external MySSL_DLL_name name fn_X509_new;
  procedure f_X509_free(a: PX509); external MySSL_DLL_name name fn_X509_free;
  function  f_i2d_X509(a: PX509; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509;
  function  f_d2i_X509(a: PPX509; pp: PPChar; length: Longint):PX509; external MySSL_DLL_name name fn_d2i_X509;
  function  f_X509_REVOKED_new:PX509_REVOKED; external MySSL_DLL_name name fn_X509_REVOKED_new;
  procedure f_X509_REVOKED_free(a: PX509_REVOKED); external MySSL_DLL_name name fn_X509_REVOKED_free;
  function  f_i2d_X509_REVOKED(a: PX509_REVOKED; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_REVOKED;
  function  f_d2i_X509_REVOKED(a: PPX509_REVOKED; pp: PPChar; length: Longint):PX509_REVOKED; external MySSL_DLL_name name fn_d2i_X509_REVOKED;
  function  f_X509_CRL_INFO_new:PX509_CRL_INFO; external MySSL_DLL_name name fn_X509_CRL_INFO_new;
  procedure f_X509_CRL_INFO_free(a: PX509_CRL_INFO); external MySSL_DLL_name name fn_X509_CRL_INFO_free;
  function  f_i2d_X509_CRL_INFO(a: PX509_CRL_INFO; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_CRL_INFO;
  function  f_d2i_X509_CRL_INFO(a: PPX509_CRL_INFO; pp: PPChar; length: Longint):PX509_CRL_INFO; external MySSL_DLL_name name fn_d2i_X509_CRL_INFO;
  function  f_X509_CRL_new:PX509_CRL; external MySSL_DLL_name name fn_X509_CRL_new;
  procedure f_X509_CRL_free(a: PX509_CRL); external MySSL_DLL_name name fn_X509_CRL_free;
  function  f_i2d_X509_CRL(a: PX509_CRL; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_CRL;
  function  f_d2i_X509_CRL(a: PPX509_CRL; pp: PPChar; length: Longint):PX509_CRL; external MySSL_DLL_name name fn_d2i_X509_CRL;
  function  f_X509_PKEY_new:PX509_PKEY; external MySSL_DLL_name name fn_X509_PKEY_new;
  procedure f_X509_PKEY_free(a: PX509_PKEY); external MySSL_DLL_name name fn_X509_PKEY_free;
  function  f_i2d_X509_PKEY(a: PX509_PKEY; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_X509_PKEY;
  function  f_d2i_X509_PKEY(a: PPX509_PKEY; pp: PPChar; length: Longint):PX509_PKEY; external MySSL_DLL_name name fn_d2i_X509_PKEY;
  function  f_NETSCAPE_SPKI_new:PNETSCAPE_SPKI; external MySSL_DLL_name name fn_NETSCAPE_SPKI_new;
  procedure f_NETSCAPE_SPKI_free(a: PNETSCAPE_SPKI); external MySSL_DLL_name name fn_NETSCAPE_SPKI_free;
  function  f_i2d_NETSCAPE_SPKI(a: PNETSCAPE_SPKI; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_NETSCAPE_SPKI;
  function  f_d2i_NETSCAPE_SPKI(a: PPNETSCAPE_SPKI; pp: PPChar; length: Longint):PNETSCAPE_SPKI; external MySSL_DLL_name name fn_d2i_NETSCAPE_SPKI;
  function  f_NETSCAPE_SPKAC_new:PNETSCAPE_SPKAC; external MySSL_DLL_name name fn_NETSCAPE_SPKAC_new;
  procedure f_NETSCAPE_SPKAC_free(a: PNETSCAPE_SPKAC); external MySSL_DLL_name name fn_NETSCAPE_SPKAC_free;
  function  f_i2d_NETSCAPE_SPKAC(a: PNETSCAPE_SPKAC; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_NETSCAPE_SPKAC;
  function  f_d2i_NETSCAPE_SPKAC(a: PPNETSCAPE_SPKAC; pp: PPChar; length: Longint):PNETSCAPE_SPKAC; external MySSL_DLL_name name fn_d2i_NETSCAPE_SPKAC;
  function  f_i2d_NETSCAPE_CERT_SEQUENCE(a: PNETSCAPE_CERT_SEQUENCE; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_NETSCAPE_CERT_SEQUENCE;
  function  f_NETSCAPE_CERT_SEQUENCE_new:PNETSCAPE_CERT_SEQUENCE; external MySSL_DLL_name name fn_NETSCAPE_CERT_SEQUENCE_new;
  function  f_d2i_NETSCAPE_CERT_SEQUENCE(a: PPNETSCAPE_CERT_SEQUENCE; pp: PPChar; length: Longint):PNETSCAPE_CERT_SEQUENCE; external MySSL_DLL_name name fn_d2i_NETSCAPE_CERT_SEQUENCE;
  procedure f_NETSCAPE_CERT_SEQUENCE_free(a: PNETSCAPE_CERT_SEQUENCE); external MySSL_DLL_name name fn_NETSCAPE_CERT_SEQUENCE_free;
  function  f_X509_INFO_new:PX509_INFO; external MySSL_DLL_name name fn_X509_INFO_new;
  procedure f_X509_INFO_free(a: PX509_INFO); external MySSL_DLL_name name fn_X509_INFO_free;
  function  f_X509_NAME_oneline(a: PX509_NAME; buf: PChar; size: Integer):PChar; external MySSL_DLL_name name fn_X509_NAME_oneline;
  function  f_ASN1_verify(arg0: PFunction; algor1: PX509_ALGOR; signature: PASN1_STRING; data: PChar; pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_ASN1_verify;
  function  f_ASN1_digest(arg0: PFunction; _type: PEVP_MD; data: PChar; md: PChar; len: PUInteger):Integer; external MySSL_DLL_name name fn_ASN1_digest;
  function  f_ASN1_sign(arg0: PFunction; algor1: PX509_ALGOR; algor2: PX509_ALGOR; signature: PASN1_STRING; data: PChar; pkey: PEVP_PKEY; const _type: PEVP_MD):Integer; external MySSL_DLL_name name fn_ASN1_sign;
  function  f_X509_set_version(x: PX509; version: Longint):Integer; external MySSL_DLL_name name fn_X509_set_version;
  function  f_X509_set_serialNumber(x: PX509; serial: PASN1_STRING):Integer; external MySSL_DLL_name name fn_X509_set_serialNumber;
  function  f_X509_get_serialNumber(x: PX509):PASN1_STRING; external MySSL_DLL_name name fn_X509_get_serialNumber;
  function  f_X509_set_issuer_name(x: PX509; name: PX509_NAME):Integer; external MySSL_DLL_name name fn_X509_set_issuer_name;
  function  f_X509_get_issuer_name(a: PX509):PX509_NAME; external MySSL_DLL_name name fn_X509_get_issuer_name;
  function  f_X509_set_subject_name(x: PX509; name: PX509_NAME):Integer; external MySSL_DLL_name name fn_X509_set_subject_name;
  function  f_X509_get_subject_name(a: PX509):PX509_NAME; external MySSL_DLL_name name fn_X509_get_subject_name;
  function  f_X509_set_notBefore(x: PX509; tm: PASN1_STRING):Integer; external MySSL_DLL_name name fn_X509_set_notBefore;
  function  f_X509_set_notAfter(x: PX509; tm: PASN1_STRING):Integer; external MySSL_DLL_name name fn_X509_set_notAfter;
  function  f_X509_set_pubkey(x: PX509; pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_X509_set_pubkey;
  function  f_X509_get_pubkey(x: PX509):PEVP_PKEY; external MySSL_DLL_name name fn_X509_get_pubkey;
  function  f_X509_certificate_type(x: PX509; pubkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_X509_certificate_type;
  function  f_X509_REQ_set_version(x: PX509_REQ; version: Longint):Integer; external MySSL_DLL_name name fn_X509_REQ_set_version;
  function  f_X509_REQ_set_subject_name(req: PX509_REQ; name: PX509_NAME):Integer; external MySSL_DLL_name name fn_X509_REQ_set_subject_name;
  function  f_X509_REQ_set_pubkey(x: PX509_REQ; pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_X509_REQ_set_pubkey;
  function  f_X509_REQ_get_pubkey(req: PX509_REQ):PEVP_PKEY; external MySSL_DLL_name name fn_X509_REQ_get_pubkey;
  function  f_X509_check_private_key(x509: PX509; pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_X509_check_private_key;
  function  f_X509_issuer_and_serial_cmp(a: PX509; b: PX509):Integer; external MySSL_DLL_name name fn_X509_issuer_and_serial_cmp;
  function  f_X509_issuer_and_serial_hash(a: PX509):Cardinal; external MySSL_DLL_name name fn_X509_issuer_and_serial_hash;
  function  f_X509_issuer_name_cmp(a: PX509; b: PX509):Integer; external MySSL_DLL_name name fn_X509_issuer_name_cmp;
  function  f_X509_issuer_name_hash(a: PX509):Cardinal; external MySSL_DLL_name name fn_X509_issuer_name_hash;
  function  f_X509_subject_name_cmp(a: PX509; b: PX509):Integer; external MySSL_DLL_name name fn_X509_subject_name_cmp;
  function  f_X509_subject_name_hash(x: PX509):Cardinal; external MySSL_DLL_name name fn_X509_subject_name_hash;
  function  f_X509_NAME_cmp(a: PX509_NAME; b: PX509_NAME):Integer; external MySSL_DLL_name name fn_X509_NAME_cmp;
  function  f_X509_NAME_hash(x: PX509_NAME):Cardinal; external MySSL_DLL_name name fn_X509_NAME_hash;
  function  f_X509_CRL_cmp(a: PX509_CRL; b: PX509_CRL):Integer; external MySSL_DLL_name name fn_X509_CRL_cmp;
  function  f_X509_print_fp(bp: PFILE; x: PX509):Integer; external MySSL_DLL_name name fn_X509_print_fp;
  function  f_X509_CRL_print_fp(bp: PFILE; x: PX509_CRL):Integer; external MySSL_DLL_name name fn_X509_CRL_print_fp;
  function  f_X509_REQ_print_fp(bp: PFILE; req: PX509_REQ):Integer; external MySSL_DLL_name name fn_X509_REQ_print_fp;
  function  f_X509_NAME_print(bp: PBIO; name: PX509_NAME; obase: Integer):Integer; external MySSL_DLL_name name fn_X509_NAME_print;
  function  f_X509_print(bp: PBIO; x: PX509):Integer; external MySSL_DLL_name name fn_X509_print;
  function  f_X509_CRL_print(bp: PBIO; x: PX509_CRL):Integer; external MySSL_DLL_name name fn_X509_CRL_print;
  function  f_X509_REQ_print(bp: PBIO; req: PX509_REQ):Integer; external MySSL_DLL_name name fn_X509_REQ_print;
  function  f_X509_NAME_entry_count(name: PX509_NAME):Integer; external MySSL_DLL_name name fn_X509_NAME_entry_count;
  function  f_X509_NAME_get_text_by_NID(name: PX509_NAME; nid: Integer; buf: PChar; len: Integer):Integer; external MySSL_DLL_name name fn_X509_NAME_get_text_by_NID;
  function  f_X509_NAME_get_text_by_OBJ(name: PX509_NAME; obj: PASN1_OBJECT; buf: PChar; len: Integer):Integer; external MySSL_DLL_name name fn_X509_NAME_get_text_by_OBJ;
  function  f_X509_NAME_get_index_by_NID(name: PX509_NAME; nid: Integer; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509_NAME_get_index_by_NID;
  function  f_X509_NAME_get_index_by_OBJ(name: PX509_NAME; obj: PASN1_OBJECT; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509_NAME_get_index_by_OBJ;
  function  f_X509_NAME_get_entry(name: PX509_NAME; loc: Integer):PX509_NAME_ENTRY; external MySSL_DLL_name name fn_X509_NAME_get_entry;
  function  f_X509_NAME_delete_entry(name: PX509_NAME; loc: Integer):PX509_NAME_ENTRY; external MySSL_DLL_name name fn_X509_NAME_delete_entry;
  function  f_X509_NAME_add_entry(name: PX509_NAME; ne: PX509_NAME_ENTRY; loc: Integer; _set: Integer):Integer; external MySSL_DLL_name name fn_X509_NAME_add_entry;
  function  f_X509_NAME_ENTRY_create_by_NID(ne: PPX509_NAME_ENTRY; nid: Integer; _type: Integer; bytes: PChar; len: Integer):PX509_NAME_ENTRY; external MySSL_DLL_name name fn_X509_NAME_ENTRY_create_by_NID;
  function  f_X509_NAME_ENTRY_create_by_OBJ(ne: PPX509_NAME_ENTRY; obj: PASN1_OBJECT; _type: Integer; bytes: PChar; len: Integer):PX509_NAME_ENTRY; external MySSL_DLL_name name fn_X509_NAME_ENTRY_create_by_OBJ;
  function  f_X509_NAME_ENTRY_set_object(ne: PX509_NAME_ENTRY; obj: PASN1_OBJECT):Integer; external MySSL_DLL_name name fn_X509_NAME_ENTRY_set_object;
  function  f_X509_NAME_ENTRY_set_data(ne: PX509_NAME_ENTRY; _type: Integer; bytes: PChar; len: Integer):Integer; external MySSL_DLL_name name fn_X509_NAME_ENTRY_set_data;
  function  f_X509_NAME_ENTRY_get_object(ne: PX509_NAME_ENTRY):PASN1_OBJECT; external MySSL_DLL_name name fn_X509_NAME_ENTRY_get_object;
  function  f_X509_NAME_ENTRY_get_data(ne: PX509_NAME_ENTRY):PASN1_STRING; external MySSL_DLL_name name fn_X509_NAME_ENTRY_get_data;
  function  f_X509v3_get_ext_count(const x: PSTACK_X509_EXTENSION):Integer; external MySSL_DLL_name name fn_X509v3_get_ext_count;
  function  f_X509v3_get_ext_by_NID(const x: PSTACK_X509_EXTENSION; nid: Integer; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509v3_get_ext_by_NID;
  function  f_X509v3_get_ext_by_OBJ(const x: PSTACK_X509_EXTENSION; obj: PASN1_OBJECT; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509v3_get_ext_by_OBJ;
  function  f_X509v3_get_ext_by_critical(const x: PSTACK_X509_EXTENSION; crit: Integer; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509v3_get_ext_by_critical;
  function  f_X509v3_get_ext(const x: PSTACK_X509_EXTENSION; loc: Integer):PX509_EXTENSION; external MySSL_DLL_name name fn_X509v3_get_ext;
  function  f_X509v3_delete_ext(x: PSTACK_X509_EXTENSION; loc: Integer):PX509_EXTENSION; external MySSL_DLL_name name fn_X509v3_delete_ext;
  function  f_X509v3_add_ext(x: PPSTACK_X509_EXTENSION; ex: PX509_EXTENSION; loc: Integer):PSTACK_X509_EXTENSION; external MySSL_DLL_name name fn_X509v3_add_ext;
  function  f_X509_get_ext_count(x: PX509):Integer; external MySSL_DLL_name name fn_X509_get_ext_count;
  function  f_X509_get_ext_by_NID(x: PX509; nid: Integer; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509_get_ext_by_NID;
  function  f_X509_get_ext_by_OBJ(x: PX509; obj: PASN1_OBJECT; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509_get_ext_by_OBJ;
  function  f_X509_get_ext_by_critical(x: PX509; crit: Integer; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509_get_ext_by_critical;
  function  f_X509_get_ext(x: PX509; loc: Integer):PX509_EXTENSION; external MySSL_DLL_name name fn_X509_get_ext;
  function  f_X509_delete_ext(x: PX509; loc: Integer):PX509_EXTENSION; external MySSL_DLL_name name fn_X509_delete_ext;
  function  f_X509_add_ext(x: PX509; ex: PX509_EXTENSION; loc: Integer):Integer; external MySSL_DLL_name name fn_X509_add_ext;
  function  f_X509_CRL_get_ext_count(x: PX509_CRL):Integer; external MySSL_DLL_name name fn_X509_CRL_get_ext_count;
  function  f_X509_CRL_get_ext_by_NID(x: PX509_CRL; nid: Integer; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509_CRL_get_ext_by_NID;
  function  f_X509_CRL_get_ext_by_OBJ(x: PX509_CRL; obj: PASN1_OBJECT; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509_CRL_get_ext_by_OBJ;
  function  f_X509_CRL_get_ext_by_critical(x: PX509_CRL; crit: Integer; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509_CRL_get_ext_by_critical;
  function  f_X509_CRL_get_ext(x: PX509_CRL; loc: Integer):PX509_EXTENSION; external MySSL_DLL_name name fn_X509_CRL_get_ext;
  function  f_X509_CRL_delete_ext(x: PX509_CRL; loc: Integer):PX509_EXTENSION; external MySSL_DLL_name name fn_X509_CRL_delete_ext;
  function  f_X509_CRL_add_ext(x: PX509_CRL; ex: PX509_EXTENSION; loc: Integer):Integer; external MySSL_DLL_name name fn_X509_CRL_add_ext;
  function  f_X509_REVOKED_get_ext_count(x: PX509_REVOKED):Integer; external MySSL_DLL_name name fn_X509_REVOKED_get_ext_count;
  function  f_X509_REVOKED_get_ext_by_NID(x: PX509_REVOKED; nid: Integer; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509_REVOKED_get_ext_by_NID;
  function  f_X509_REVOKED_get_ext_by_OBJ(x: PX509_REVOKED; obj: PASN1_OBJECT; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509_REVOKED_get_ext_by_OBJ;
  function  f_X509_REVOKED_get_ext_by_critical(x: PX509_REVOKED; crit: Integer; lastpos: Integer):Integer; external MySSL_DLL_name name fn_X509_REVOKED_get_ext_by_critical;
  function  f_X509_REVOKED_get_ext(x: PX509_REVOKED; loc: Integer):PX509_EXTENSION; external MySSL_DLL_name name fn_X509_REVOKED_get_ext;
  function  f_X509_REVOKED_delete_ext(x: PX509_REVOKED; loc: Integer):PX509_EXTENSION; external MySSL_DLL_name name fn_X509_REVOKED_delete_ext;
  function  f_X509_REVOKED_add_ext(x: PX509_REVOKED; ex: PX509_EXTENSION; loc: Integer):Integer; external MySSL_DLL_name name fn_X509_REVOKED_add_ext;
  function  f_X509_EXTENSION_create_by_NID(ex: PPX509_EXTENSION; nid: Integer; crit: Integer; data: PASN1_STRING):PX509_EXTENSION; external MySSL_DLL_name name fn_X509_EXTENSION_create_by_NID;
  function  f_X509_EXTENSION_create_by_OBJ(ex: PPX509_EXTENSION; obj: PASN1_OBJECT; crit: Integer; data: PASN1_STRING):PX509_EXTENSION; external MySSL_DLL_name name fn_X509_EXTENSION_create_by_OBJ;
  function  f_X509_EXTENSION_set_object(ex: PX509_EXTENSION; obj: PASN1_OBJECT):Integer; external MySSL_DLL_name name fn_X509_EXTENSION_set_object;
  function  f_X509_EXTENSION_set_critical(ex: PX509_EXTENSION; crit: Integer):Integer; external MySSL_DLL_name name fn_X509_EXTENSION_set_critical;
  function  f_X509_EXTENSION_set_data(ex: PX509_EXTENSION; data: PASN1_STRING):Integer; external MySSL_DLL_name name fn_X509_EXTENSION_set_data;
  function  f_X509_EXTENSION_get_object(ex: PX509_EXTENSION):PASN1_OBJECT; external MySSL_DLL_name name fn_X509_EXTENSION_get_object;
  function  f_X509_EXTENSION_get_data(ne: PX509_EXTENSION):PASN1_STRING; external MySSL_DLL_name name fn_X509_EXTENSION_get_data;
  function  f_X509_EXTENSION_get_critical(ex: PX509_EXTENSION):Integer; external MySSL_DLL_name name fn_X509_EXTENSION_get_critical;
  function  f_X509_verify_cert(ctx: PX509_STORE_CTX):Integer; external MySSL_DLL_name name fn_X509_verify_cert;
  function  f_X509_find_by_issuer_and_serial(sk: PSTACK_X509; name: PX509_NAME; serial: PASN1_STRING):PX509; external MySSL_DLL_name name fn_X509_find_by_issuer_and_serial;
  function  f_X509_find_by_subject(sk: PSTACK_X509; name: PX509_NAME):PX509; external MySSL_DLL_name name fn_X509_find_by_subject;
  function  f_i2d_PBEPARAM(a: PPBEPARAM; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PBEPARAM;
  function  f_PBEPARAM_new:PPBEPARAM; external MySSL_DLL_name name fn_PBEPARAM_new;
  function  f_d2i_PBEPARAM(a: PPPBEPARAM; pp: PPChar; length: Longint):PPBEPARAM; external MySSL_DLL_name name fn_d2i_PBEPARAM;
  procedure f_PBEPARAM_free(a: PPBEPARAM); external MySSL_DLL_name name fn_PBEPARAM_free;
  function  f_PKCS5_pbe_set(alg: Integer; iter: Integer; salt: PChar; saltlen: Integer):PX509_ALGOR; external MySSL_DLL_name name fn_PKCS5_pbe_set;
  function  f_PKCS5_pbe2_set(const cipher: PEVP_CIPHER; iter: Integer; salt: PChar; saltlen: Integer):PX509_ALGOR; external MySSL_DLL_name name fn_PKCS5_pbe2_set;
  function  f_i2d_PBKDF2PARAM(a: PPBKDF2PARAM; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PBKDF2PARAM;
  function  f_PBKDF2PARAM_new:PPBKDF2PARAM; external MySSL_DLL_name name fn_PBKDF2PARAM_new;
  function  f_d2i_PBKDF2PARAM(a: PPPBKDF2PARAM; pp: PPChar; length: Longint):PPBKDF2PARAM; external MySSL_DLL_name name fn_d2i_PBKDF2PARAM;
  procedure f_PBKDF2PARAM_free(a: PPBKDF2PARAM); external MySSL_DLL_name name fn_PBKDF2PARAM_free;
  function  f_i2d_PBE2PARAM(a: PPBE2PARAM; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PBE2PARAM;
  function  f_PBE2PARAM_new:PPBE2PARAM; external MySSL_DLL_name name fn_PBE2PARAM_new;
  function  f_d2i_PBE2PARAM(a: PPPBE2PARAM; pp: PPChar; length: Longint):PPBE2PARAM; external MySSL_DLL_name name fn_d2i_PBE2PARAM;
  procedure f_PBE2PARAM_free(a: PPBE2PARAM); external MySSL_DLL_name name fn_PBE2PARAM_free;
  function  f_i2d_PKCS8_PRIV_KEY_INFO(a: PPKCS8_PRIV_KEY_INFO; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_PKCS8_PRIV_KEY_INFO;
  function  f_PKCS8_PRIV_KEY_INFO_new:PPKCS8_PRIV_KEY_INFO; external MySSL_DLL_name name fn_PKCS8_PRIV_KEY_INFO_new;
  function  f_d2i_PKCS8_PRIV_KEY_INFO(a: PPPKCS8_PRIV_KEY_INFO; pp: PPChar; length: Longint):PPKCS8_PRIV_KEY_INFO; external MySSL_DLL_name name fn_d2i_PKCS8_PRIV_KEY_INFO;
  procedure f_PKCS8_PRIV_KEY_INFO_free(a: PPKCS8_PRIV_KEY_INFO); external MySSL_DLL_name name fn_PKCS8_PRIV_KEY_INFO_free;
  function  f_EVP_PKCS82PKEY(p8: PPKCS8_PRIV_KEY_INFO):PEVP_PKEY; external MySSL_DLL_name name fn_EVP_PKCS82PKEY;
  function  f_EVP_PKEY2PKCS8(pkey: PEVP_PKEY):PPKCS8_PRIV_KEY_INFO; external MySSL_DLL_name name fn_EVP_PKEY2PKCS8;
  function  f_PKCS8_set_broken(p8: PPKCS8_PRIV_KEY_INFO; broken: Integer):PPKCS8_PRIV_KEY_INFO; external MySSL_DLL_name name fn_PKCS8_set_broken;
  procedure f_ERR_load_PEM_strings; external MySSL_DLL_name name fn_ERR_load_PEM_strings;
  function  f_PEM_get_EVP_CIPHER_INFO(header: PChar; cipher: PEVP_CIPHER_INFO):Integer; external MySSL_DLL_name name fn_PEM_get_EVP_CIPHER_INFO;
  function  f_PEM_do_header(cipher: PEVP_CIPHER_INFO; data: PChar; len: PLong; callback: Ppem_password_cb; u: Pointer):Integer; external MySSL_DLL_name name fn_PEM_do_header;
  function  f_PEM_read_bio(bp: PBIO; name: PPChar; header: PPChar; data: PPChar; len: PLong):Integer; external MySSL_DLL_name name fn_PEM_read_bio;
  function  f_PEM_write_bio(bp: PBIO; const name: PChar; hdr: PChar; data: PChar; len: Longint):Integer; external MySSL_DLL_name name fn_PEM_write_bio;
  function  f_PEM_ASN1_read_bio(arg0: PFunction; const name: PChar; bp: PBIO; x: PPChar; cb: Ppem_password_cb; u: Pointer):PChar; external MySSL_DLL_name name fn_PEM_ASN1_read_bio;
  function  f_PEM_ASN1_write_bio(arg0: PFunction; const name: PChar; bp: PBIO; x: PChar; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; external MySSL_DLL_name name fn_PEM_ASN1_write_bio;
  function  f_PEM_X509_INFO_read_bio(bp: PBIO; sk: PSTACK_X509_INFO; cb: Ppem_password_cb; u: Pointer):PSTACK_X509_INFO; external MySSL_DLL_name name fn_PEM_X509_INFO_read_bio;
  function  f_PEM_X509_INFO_write_bio(bp: PBIO; xi: PX509_INFO; enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cd: Ppem_password_cb; u: Pointer):Integer; external MySSL_DLL_name name fn_PEM_X509_INFO_write_bio;
  function  f_PEM_read(fp: PFILE; name: PPChar; header: PPChar; data: PPChar; len: PLong):Integer; external MySSL_DLL_name name fn_PEM_read;
  function  f_PEM_write(fp: PFILE; name: PChar; hdr: PChar; data: PChar; len: Longint):Integer; external MySSL_DLL_name name fn_PEM_write;
  function  f_PEM_ASN1_read(arg0: PFunction; const name: PChar; fp: PFILE; x: PPChar; cb: Ppem_password_cb; u: Pointer):PChar; external MySSL_DLL_name name fn_PEM_ASN1_read;
  function  f_PEM_ASN1_write(arg0: PFunction; const name: PChar; fp: PFILE; x: PChar; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; callback: Ppem_password_cb; u: Pointer):Integer; external MySSL_DLL_name name fn_PEM_ASN1_write;
  function  f_PEM_X509_INFO_read(fp: PFILE; sk: PSTACK_X509_INFO; cb: Ppem_password_cb; u: Pointer):PSTACK_X509_INFO; external MySSL_DLL_name name fn_PEM_X509_INFO_read;
  function  f_PEM_SealInit(ctx: PPEM_ENCODE_SEAL_CTX; _type: PEVP_CIPHER; md_type: PEVP_MD; ek: PPChar; ekl: PInteger; iv: PChar; pubk: PPEVP_PKEY; npubk: Integer):Integer; external MySSL_DLL_name name fn_PEM_SealInit;
  procedure f_PEM_SealUpdate(ctx: PPEM_ENCODE_SEAL_CTX; _out: PChar; outl: PInteger; _in: PChar; inl: Integer); external MySSL_DLL_name name fn_PEM_SealUpdate;
  function  f_PEM_SealFinal(ctx: PPEM_ENCODE_SEAL_CTX; sig: PChar; sigl: PInteger; _out: PChar; outl: PInteger; priv: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_PEM_SealFinal;
  procedure f_PEM_SignInit(ctx: PEVP_MD_CTX; _type: PEVP_MD); external MySSL_DLL_name name fn_PEM_SignInit;
  procedure f_PEM_SignUpdate(ctx: PEVP_MD_CTX; d: PChar; cnt: UInteger); external MySSL_DLL_name name fn_PEM_SignUpdate;
  function  f_PEM_SignFinal(ctx: PEVP_MD_CTX; sigret: PChar; siglen: PUInteger; pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_PEM_SignFinal;
  procedure f_PEM_proc_type(buf: PChar; _type: Integer); external MySSL_DLL_name name fn_PEM_proc_type;
  procedure f_PEM_dek_info(buf: PChar; const _type: PChar; len: Integer; str: PChar); external MySSL_DLL_name name fn_PEM_dek_info;
  function  f_PEM_read_bio_X509(bp: PBIO; x: PPX509; cb: Ppem_password_cb; u: Pointer):PX509; external MySSL_DLL_name name fn_PEM_read_bio_X509;
  function  f_PEM_read_X509(fp: PFILE; x: PPX509; cb: Ppem_password_cb; u: Pointer):PX509; external MySSL_DLL_name name fn_PEM_read_X509;
  function  f_PEM_write_bio_X509(bp: PBIO; x: PX509):Integer; external MySSL_DLL_name name fn_PEM_write_bio_X509;
  function  f_PEM_write_X509(fp: PFILE; x: PX509):Integer; external MySSL_DLL_name name fn_PEM_write_X509;
  function  f_PEM_read_bio_X509_REQ(bp: PBIO; x: PPX509_REQ; cb: Ppem_password_cb; u: Pointer):PX509_REQ; external MySSL_DLL_name name fn_PEM_read_bio_X509_REQ;
  function  f_PEM_read_X509_REQ(fp: PFILE; x: PPX509_REQ; cb: Ppem_password_cb; u: Pointer):PX509_REQ; external MySSL_DLL_name name fn_PEM_read_X509_REQ;
  function  f_PEM_write_bio_X509_REQ(bp: PBIO; x: PX509_REQ):Integer; external MySSL_DLL_name name fn_PEM_write_bio_X509_REQ;
  function  f_PEM_write_X509_REQ(fp: PFILE; x: PX509_REQ):Integer; external MySSL_DLL_name name fn_PEM_write_X509_REQ;
  function  f_PEM_read_bio_X509_CRL(bp: PBIO; x: PPX509_CRL; cb: Ppem_password_cb; u: Pointer):PX509_CRL; external MySSL_DLL_name name fn_PEM_read_bio_X509_CRL;
  function  f_PEM_read_X509_CRL(fp: PFILE; x: PPX509_CRL; cb: Ppem_password_cb; u: Pointer):PX509_CRL; external MySSL_DLL_name name fn_PEM_read_X509_CRL;
  function  f_PEM_write_bio_X509_CRL(bp: PBIO; x: PX509_CRL):Integer; external MySSL_DLL_name name fn_PEM_write_bio_X509_CRL;
  function  f_PEM_write_X509_CRL(fp: PFILE; x: PX509_CRL):Integer; external MySSL_DLL_name name fn_PEM_write_X509_CRL;
  function  f_PEM_read_bio_PKCS7(bp: PBIO; x: PPPKCS7; cb: Ppem_password_cb; u: Pointer):PPKCS7; external MySSL_DLL_name name fn_PEM_read_bio_PKCS7;
  function  f_PEM_read_PKCS7(fp: PFILE; x: PPPKCS7; cb: Ppem_password_cb; u: Pointer):PPKCS7; external MySSL_DLL_name name fn_PEM_read_PKCS7;
  function  f_PEM_write_bio_PKCS7(bp: PBIO; x: PPKCS7):Integer; external MySSL_DLL_name name fn_PEM_write_bio_PKCS7;
  function  f_PEM_write_PKCS7(fp: PFILE; x: PPKCS7):Integer; external MySSL_DLL_name name fn_PEM_write_PKCS7;
  function  f_PEM_read_bio_NETSCAPE_CERT_SEQUENCE(bp: PBIO; x: PPNETSCAPE_CERT_SEQUENCE; cb: Ppem_password_cb; u: Pointer):PNETSCAPE_CERT_SEQUENCE; external MySSL_DLL_name name fn_PEM_read_bio_NETSCAPE_CERT_SEQUENCE;
  function  f_PEM_read_NETSCAPE_CERT_SEQUENCE(fp: PFILE; x: PPNETSCAPE_CERT_SEQUENCE; cb: Ppem_password_cb; u: Pointer):PNETSCAPE_CERT_SEQUENCE; external MySSL_DLL_name name fn_PEM_read_NETSCAPE_CERT_SEQUENCE;
  function  f_PEM_write_bio_NETSCAPE_CERT_SEQUENCE(bp: PBIO; x: PNETSCAPE_CERT_SEQUENCE):Integer; external MySSL_DLL_name name fn_PEM_write_bio_NETSCAPE_CERT_SEQUENCE;
  function  f_PEM_write_NETSCAPE_CERT_SEQUENCE(fp: PFILE; x: PNETSCAPE_CERT_SEQUENCE):Integer; external MySSL_DLL_name name fn_PEM_write_NETSCAPE_CERT_SEQUENCE;
  function  f_PEM_read_bio_PKCS8(bp: PBIO; x: PPX509_SIG; cb: Ppem_password_cb; u: Pointer):PX509_SIG; external MySSL_DLL_name name fn_PEM_read_bio_PKCS8;
  function  f_PEM_read_PKCS8(fp: PFILE; x: PPX509_SIG; cb: Ppem_password_cb; u: Pointer):PX509_SIG; external MySSL_DLL_name name fn_PEM_read_PKCS8;
  function  f_PEM_write_bio_PKCS8(bp: PBIO; x: PX509_SIG):Integer; external MySSL_DLL_name name fn_PEM_write_bio_PKCS8;
  function  f_PEM_write_PKCS8(fp: PFILE; x: PX509_SIG):Integer; external MySSL_DLL_name name fn_PEM_write_PKCS8;
  function  f_PEM_read_bio_PKCS8_PRIV_KEY_INFO(bp: PBIO; x: PPPKCS8_PRIV_KEY_INFO; cb: Ppem_password_cb; u: Pointer):PPKCS8_PRIV_KEY_INFO; external MySSL_DLL_name name fn_PEM_read_bio_PKCS8_PRIV_KEY_INFO;
  function  f_PEM_read_PKCS8_PRIV_KEY_INFO(fp: PFILE; x: PPPKCS8_PRIV_KEY_INFO; cb: Ppem_password_cb; u: Pointer):PPKCS8_PRIV_KEY_INFO; external MySSL_DLL_name name fn_PEM_read_PKCS8_PRIV_KEY_INFO;
  function  f_PEM_write_bio_PKCS8_PRIV_KEY_INFO(bp: PBIO; x: PPKCS8_PRIV_KEY_INFO):Integer; external MySSL_DLL_name name fn_PEM_write_bio_PKCS8_PRIV_KEY_INFO;
  function  f_PEM_write_PKCS8_PRIV_KEY_INFO(fp: PFILE; x: PPKCS8_PRIV_KEY_INFO):Integer; external MySSL_DLL_name name fn_PEM_write_PKCS8_PRIV_KEY_INFO;
  function  f_PEM_read_bio_RSAPrivateKey(bp: PBIO; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA; external MySSL_DLL_name name fn_PEM_read_bio_RSAPrivateKey;
  function  f_PEM_read_RSAPrivateKey(fp: PFILE; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA; external MySSL_DLL_name name fn_PEM_read_RSAPrivateKey;
  function  f_PEM_write_bio_RSAPrivateKey(bp: PBIO; x: PRSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; external MySSL_DLL_name name fn_PEM_write_bio_RSAPrivateKey;
  function  f_PEM_write_RSAPrivateKey(fp: PFILE; x: PRSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; external MySSL_DLL_name name fn_PEM_write_RSAPrivateKey;
  function  f_PEM_read_bio_RSAPublicKey(bp: PBIO; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA; external MySSL_DLL_name name fn_PEM_read_bio_RSAPublicKey;
  function  f_PEM_read_RSAPublicKey(fp: PFILE; x: PPRSA; cb: Ppem_password_cb; u: Pointer):PRSA; external MySSL_DLL_name name fn_PEM_read_RSAPublicKey;
  function  f_PEM_write_bio_RSAPublicKey(bp: PBIO; x: PRSA):Integer; external MySSL_DLL_name name fn_PEM_write_bio_RSAPublicKey;
  function  f_PEM_write_RSAPublicKey(fp: PFILE; x: PRSA):Integer; external MySSL_DLL_name name fn_PEM_write_RSAPublicKey;
  function  f_PEM_read_bio_DSAPrivateKey(bp: PBIO; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA; external MySSL_DLL_name name fn_PEM_read_bio_DSAPrivateKey;
  function  f_PEM_read_DSAPrivateKey(fp: PFILE; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA; external MySSL_DLL_name name fn_PEM_read_DSAPrivateKey;
  function  f_PEM_write_bio_DSAPrivateKey(bp: PBIO; x: PDSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; external MySSL_DLL_name name fn_PEM_write_bio_DSAPrivateKey;
  function  f_PEM_write_DSAPrivateKey(fp: PFILE; x: PDSA; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; external MySSL_DLL_name name fn_PEM_write_DSAPrivateKey;
  function  f_PEM_read_bio_DSAparams(bp: PBIO; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA; external MySSL_DLL_name name fn_PEM_read_bio_DSAparams;
  function  f_PEM_read_DSAparams(fp: PFILE; x: PPDSA; cb: Ppem_password_cb; u: Pointer):PDSA; external MySSL_DLL_name name fn_PEM_read_DSAparams;
  function  f_PEM_write_bio_DSAparams(bp: PBIO; x: PDSA):Integer; external MySSL_DLL_name name fn_PEM_write_bio_DSAparams;
  function  f_PEM_write_DSAparams(fp: PFILE; x: PDSA):Integer; external MySSL_DLL_name name fn_PEM_write_DSAparams;
  function  f_PEM_read_bio_DHparams(bp: PBIO; x: PPDH; cb: Ppem_password_cb; u: Pointer):PDH; external MySSL_DLL_name name fn_PEM_read_bio_DHparams;
  function  f_PEM_read_DHparams(fp: PFILE; x: PPDH; cb: Ppem_password_cb; u: Pointer):PDH; external MySSL_DLL_name name fn_PEM_read_DHparams;
  function  f_PEM_write_bio_DHparams(bp: PBIO; x: PDH):Integer; external MySSL_DLL_name name fn_PEM_write_bio_DHparams;
  function  f_PEM_write_DHparams(fp: PFILE; x: PDH):Integer; external MySSL_DLL_name name fn_PEM_write_DHparams;
  function  f_PEM_read_bio_PrivateKey(bp: PBIO; x: PPEVP_PKEY; cb: Ppem_password_cb; u: Pointer):PEVP_PKEY; external MySSL_DLL_name name fn_PEM_read_bio_PrivateKey;
  function  f_PEM_read_PrivateKey(fp: PFILE; x: PPEVP_PKEY; cb: Ppem_password_cb; u: Pointer):PEVP_PKEY; external MySSL_DLL_name name fn_PEM_read_PrivateKey;
  function  f_PEM_write_bio_PrivateKey(bp: PBIO; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; external MySSL_DLL_name name fn_PEM_write_bio_PrivateKey;
  function  f_PEM_write_PrivateKey(fp: PFILE; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cb: Ppem_password_cb; u: Pointer):Integer; external MySSL_DLL_name name fn_PEM_write_PrivateKey;
  function  f_PEM_write_bio_PKCS8PrivateKey(arg0: PBIO; arg1: PEVP_PKEY; const arg2: PEVP_CIPHER; arg3: PChar; arg4: Integer; arg5: Ppem_password_cb; arg6: Pointer):Integer; external MySSL_DLL_name name fn_PEM_write_bio_PKCS8PrivateKey;
  function  f_PEM_write_PKCS8PrivateKey(fp: PFILE; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PChar; klen: Integer; cd: Ppem_password_cb; u: Pointer):Integer; external MySSL_DLL_name name fn_PEM_write_PKCS8PrivateKey;
  function  f_sk_SSL_CIPHER_new(arg0: PFunction):PSTACK_SSL_CIPHER; external MySSL_DLL_name name fn_sk_SSL_CIPHER_new;
  function  f_sk_SSL_CIPHER_new_null:PSTACK_SSL_CIPHER; external MySSL_DLL_name name fn_sk_SSL_CIPHER_new_null;
  procedure f_sk_SSL_CIPHER_free(sk: PSTACK_SSL_CIPHER); external MySSL_DLL_name name fn_sk_SSL_CIPHER_free;
  function  f_sk_SSL_CIPHER_num(const sk: PSTACK_SSL_CIPHER):Integer; external MySSL_DLL_name name fn_sk_SSL_CIPHER_num;
  function  f_sk_SSL_CIPHER_value(const sk: PSTACK_SSL_CIPHER; n: Integer):PSSL_CIPHER; external MySSL_DLL_name name fn_sk_SSL_CIPHER_value;
  function  f_sk_SSL_CIPHER_set(sk: PSTACK_SSL_CIPHER; n: Integer; v: PSSL_CIPHER):PSSL_CIPHER; external MySSL_DLL_name name fn_sk_SSL_CIPHER_set;
  procedure f_sk_SSL_CIPHER_zero(sk: PSTACK_SSL_CIPHER); external MySSL_DLL_name name fn_sk_SSL_CIPHER_zero;
  function  f_sk_SSL_CIPHER_push(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER):Integer; external MySSL_DLL_name name fn_sk_SSL_CIPHER_push;
  function  f_sk_SSL_CIPHER_unshift(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER):Integer; external MySSL_DLL_name name fn_sk_SSL_CIPHER_unshift;
  function  f_sk_SSL_CIPHER_find(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER):Integer; external MySSL_DLL_name name fn_sk_SSL_CIPHER_find;
  function  f_sk_SSL_CIPHER_delete(sk: PSTACK_SSL_CIPHER; n: Integer):PSSL_CIPHER; external MySSL_DLL_name name fn_sk_SSL_CIPHER_delete;
  procedure f_sk_SSL_CIPHER_delete_ptr(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER); external MySSL_DLL_name name fn_sk_SSL_CIPHER_delete_ptr;
  function  f_sk_SSL_CIPHER_insert(sk: PSTACK_SSL_CIPHER; v: PSSL_CIPHER; n: Integer):Integer; external MySSL_DLL_name name fn_sk_SSL_CIPHER_insert;
  function  f_sk_SSL_CIPHER_dup(sk: PSTACK_SSL_CIPHER):PSTACK_SSL_CIPHER; external MySSL_DLL_name name fn_sk_SSL_CIPHER_dup;
  procedure f_sk_SSL_CIPHER_pop_free(sk: PSTACK_SSL_CIPHER; arg1: PFunction); external MySSL_DLL_name name fn_sk_SSL_CIPHER_pop_free;
  function  f_sk_SSL_CIPHER_shift(sk: PSTACK_SSL_CIPHER):PSSL_CIPHER; external MySSL_DLL_name name fn_sk_SSL_CIPHER_shift;
  function  f_sk_SSL_CIPHER_pop(sk: PSTACK_SSL_CIPHER):PSSL_CIPHER; external MySSL_DLL_name name fn_sk_SSL_CIPHER_pop;
  procedure f_sk_SSL_CIPHER_sort(sk: PSTACK_SSL_CIPHER); external MySSL_DLL_name name fn_sk_SSL_CIPHER_sort;
  function  f_sk_SSL_COMP_new(arg0: PFunction):PSTACK_SSL_COMP; external MySSL_DLL_name name fn_sk_SSL_COMP_new;
  function  f_sk_SSL_COMP_new_null:PSTACK_SSL_COMP; external MySSL_DLL_name name fn_sk_SSL_COMP_new_null;
  procedure f_sk_SSL_COMP_free(sk: PSTACK_SSL_COMP); external MySSL_DLL_name name fn_sk_SSL_COMP_free;
  function  f_sk_SSL_COMP_num(const sk: PSTACK_SSL_COMP):Integer; external MySSL_DLL_name name fn_sk_SSL_COMP_num;
  function  f_sk_SSL_COMP_value(const sk: PSTACK_SSL_COMP; n: Integer):PSSL_COMP; external MySSL_DLL_name name fn_sk_SSL_COMP_value;
  function  f_sk_SSL_COMP_set(sk: PSTACK_SSL_COMP; n: Integer; v: PSSL_COMP):PSSL_COMP; external MySSL_DLL_name name fn_sk_SSL_COMP_set;
  procedure f_sk_SSL_COMP_zero(sk: PSTACK_SSL_COMP); external MySSL_DLL_name name fn_sk_SSL_COMP_zero;
  function  f_sk_SSL_COMP_push(sk: PSTACK_SSL_COMP; v: PSSL_COMP):Integer; external MySSL_DLL_name name fn_sk_SSL_COMP_push;
  function  f_sk_SSL_COMP_unshift(sk: PSTACK_SSL_COMP; v: PSSL_COMP):Integer; external MySSL_DLL_name name fn_sk_SSL_COMP_unshift;
  function  f_sk_SSL_COMP_find(sk: PSTACK_SSL_COMP; v: PSSL_COMP):Integer; external MySSL_DLL_name name fn_sk_SSL_COMP_find;
  function  f_sk_SSL_COMP_delete(sk: PSTACK_SSL_COMP; n: Integer):PSSL_COMP; external MySSL_DLL_name name fn_sk_SSL_COMP_delete;
  procedure f_sk_SSL_COMP_delete_ptr(sk: PSTACK_SSL_COMP; v: PSSL_COMP); external MySSL_DLL_name name fn_sk_SSL_COMP_delete_ptr;
  function  f_sk_SSL_COMP_insert(sk: PSTACK_SSL_COMP; v: PSSL_COMP; n: Integer):Integer; external MySSL_DLL_name name fn_sk_SSL_COMP_insert;
  function  f_sk_SSL_COMP_dup(sk: PSTACK_SSL_COMP):PSTACK_SSL_COMP; external MySSL_DLL_name name fn_sk_SSL_COMP_dup;
  procedure f_sk_SSL_COMP_pop_free(sk: PSTACK_SSL_COMP; arg1: PFunction); external MySSL_DLL_name name fn_sk_SSL_COMP_pop_free;
  function  f_sk_SSL_COMP_shift(sk: PSTACK_SSL_COMP):PSSL_COMP; external MySSL_DLL_name name fn_sk_SSL_COMP_shift;
  function  f_sk_SSL_COMP_pop(sk: PSTACK_SSL_COMP):PSSL_COMP; external MySSL_DLL_name name fn_sk_SSL_COMP_pop;
  procedure f_sk_SSL_COMP_sort(sk: PSTACK_SSL_COMP); external MySSL_DLL_name name fn_sk_SSL_COMP_sort;
  function  f_BIO_f_ssl:PBIO_METHOD; external MySSL_DLL_name name fn_BIO_f_ssl;
  function  f_BIO_new_ssl(ctx: PSSL_CTX; client: Integer):PBIO; external MySSL_DLL_name name fn_BIO_new_ssl;
  function  f_BIO_new_ssl_connect(ctx: PSSL_CTX):PBIO; external MySSL_DLL_name name fn_BIO_new_ssl_connect;
  function  f_BIO_new_buffer_ssl_connect(ctx: PSSL_CTX):PBIO; external MySSL_DLL_name name fn_BIO_new_buffer_ssl_connect;
  function  f_BIO_ssl_copy_session_id(_to: PBIO; from: PBIO):Integer; external MySSL_DLL_name name fn_BIO_ssl_copy_session_id;
  procedure f_BIO_ssl_shutdown(ssl_bio: PBIO); external MySSL_DLL_name name fn_BIO_ssl_shutdown;
  function  f_SSL_CTX_set_cipher_list(arg0: PSSL_CTX; str: PChar):Integer; external MySSL_DLL_name name fn_SSL_CTX_set_cipher_list;
  function  f_SSL_CTX_new(meth: PSSL_METHOD):PSSL_CTX; external MySSL_DLL_name name fn_SSL_CTX_new;
  procedure f_SSL_CTX_free(arg0: PSSL_CTX); external MySSL_DLL_name name fn_SSL_CTX_free;
  function  f_SSL_CTX_set_timeout(ctx: PSSL_CTX; t: Longint):Longint; external MySSL_DLL_name name fn_SSL_CTX_set_timeout;
  function  f_SSL_CTX_get_timeout(ctx: PSSL_CTX):Longint; external MySSL_DLL_name name fn_SSL_CTX_get_timeout;
  function  f_SSL_CTX_get_cert_store(arg0: PSSL_CTX):PX509_STORE; external MySSL_DLL_name name fn_SSL_CTX_get_cert_store;
  procedure f_SSL_CTX_set_cert_store(arg0: PSSL_CTX; arg1: PX509_STORE); external MySSL_DLL_name name fn_SSL_CTX_set_cert_store;
  function  f_SSL_want(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_want;
  function  f_SSL_clear(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_clear;
  procedure f_SSL_CTX_flush_sessions(ctx: PSSL_CTX; tm: Longint); external MySSL_DLL_name name fn_SSL_CTX_flush_sessions;
  function  f_SSL_get_current_cipher(s: PSSL):PSSL_CIPHER; external MySSL_DLL_name name fn_SSL_get_current_cipher;
  function  f_SSL_CIPHER_get_bits(c: PSSL_CIPHER; alg_bits: PInteger):Integer; external MySSL_DLL_name name fn_SSL_CIPHER_get_bits;
  function  f_SSL_CIPHER_get_version(c: PSSL_CIPHER):PChar; external MySSL_DLL_name name fn_SSL_CIPHER_get_version;
  function  f_SSL_CIPHER_get_name(c: PSSL_CIPHER):PChar; external MySSL_DLL_name name fn_SSL_CIPHER_get_name;
  function  f_SSL_get_fd(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_get_fd;
  function  f_SSL_get_cipher_list(s: PSSL; n: Integer):PChar; external MySSL_DLL_name name fn_SSL_get_cipher_list;
  function  f_SSL_get_shared_ciphers(s: PSSL; buf: PChar; len: Integer):PChar; external MySSL_DLL_name name fn_SSL_get_shared_ciphers;
  function  f_SSL_get_read_ahead(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_get_read_ahead;
  function  f_SSL_pending(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_pending;
  function  f_SSL_set_fd(s: PSSL; fd: Integer):Integer; external MySSL_DLL_name name fn_SSL_set_fd;
  function  f_SSL_set_rfd(s: PSSL; fd: Integer):Integer; external MySSL_DLL_name name fn_SSL_set_rfd;
  function  f_SSL_set_wfd(s: PSSL; fd: Integer):Integer; external MySSL_DLL_name name fn_SSL_set_wfd;
  procedure f_SSL_set_bio(s: PSSL; rbio: PBIO; wbio: PBIO); external MySSL_DLL_name name fn_SSL_set_bio;
  function  f_SSL_get_rbio(s: PSSL):PBIO; external MySSL_DLL_name name fn_SSL_get_rbio;
  function  f_SSL_get_wbio(s: PSSL):PBIO; external MySSL_DLL_name name fn_SSL_get_wbio;
  function  f_SSL_set_cipher_list(s: PSSL; str: PChar):Integer; external MySSL_DLL_name name fn_SSL_set_cipher_list;
  procedure f_SSL_set_read_ahead(s: PSSL; yes: Integer); external MySSL_DLL_name name fn_SSL_set_read_ahead;
  function  f_SSL_get_verify_mode(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_get_verify_mode;
  function  f_SSL_get_verify_depth(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_get_verify_depth;
  procedure f_SSL_set_verify(s: PSSL; mode: Integer; arg2: PFunction); external MySSL_DLL_name name fn_SSL_set_verify;
  procedure f_SSL_set_verify_depth(s: PSSL; depth: Integer); external MySSL_DLL_name name fn_SSL_set_verify_depth;
  function  f_SSL_use_RSAPrivateKey(ssl: PSSL; rsa: PRSA):Integer; external MySSL_DLL_name name fn_SSL_use_RSAPrivateKey;
  function  f_SSL_use_RSAPrivateKey_ASN1(ssl: PSSL; d: PChar; len: Longint):Integer; external MySSL_DLL_name name fn_SSL_use_RSAPrivateKey_ASN1;
  function  f_SSL_use_PrivateKey(ssl: PSSL; pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_SSL_use_PrivateKey;
  function  f_SSL_use_PrivateKey_ASN1(pk: Integer; ssl: PSSL; d: PChar; len: Longint):Integer; external MySSL_DLL_name name fn_SSL_use_PrivateKey_ASN1;
  function  f_SSL_use_certificate(ssl: PSSL; x: PX509):Integer; external MySSL_DLL_name name fn_SSL_use_certificate;
  function  f_SSL_use_certificate_ASN1(ssl: PSSL; d: PChar; len: Integer):Integer; external MySSL_DLL_name name fn_SSL_use_certificate_ASN1;
  function  f_SSL_use_RSAPrivateKey_file(ssl: PSSL; const _file: PChar; _type: Integer):Integer; external MySSL_DLL_name name fn_SSL_use_RSAPrivateKey_file;
  function  f_SSL_use_PrivateKey_file(ssl: PSSL; const _file: PChar; _type: Integer):Integer; external MySSL_DLL_name name fn_SSL_use_PrivateKey_file;
  function  f_SSL_use_certificate_file(ssl: PSSL; const _file: PChar; _type: Integer):Integer; external MySSL_DLL_name name fn_SSL_use_certificate_file;
  function  f_SSL_CTX_use_RSAPrivateKey_file(ctx: PSSL_CTX; const _file: PChar; _type: Integer):Integer; external MySSL_DLL_name name fn_SSL_CTX_use_RSAPrivateKey_file;
  function  f_SSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const _file: PChar; _type: Integer):Integer; external MySSL_DLL_name name fn_SSL_CTX_use_PrivateKey_file;
  function  f_SSL_CTX_use_certificate_file(ctx: PSSL_CTX; const _file: PChar; _type: Integer):Integer; external MySSL_DLL_name name fn_SSL_CTX_use_certificate_file;
  function  f_SSL_CTX_use_certificate_chain_file(ctx: PSSL_CTX; const _file: PChar):Integer; external MySSL_DLL_name name fn_SSL_CTX_use_certificate_chain_file;
  function  f_SSL_load_client_CA_file(const _file: PChar):PSTACK_X509_NAME; external MySSL_DLL_name name fn_SSL_load_client_CA_file;
  function  f_SSL_add_file_cert_subjects_to_stack(stackCAs: PSTACK_X509_NAME; const _file: PChar):Integer; external MySSL_DLL_name name fn_SSL_add_file_cert_subjects_to_stack;
  procedure f_ERR_load_SSL_strings; external MySSL_DLL_name name fn_ERR_load_SSL_strings;
  procedure f_SSL_load_error_strings; external MySSL_DLL_name name fn_SSL_load_error_strings;
  function  f_SSL_state_string(s: PSSL):PChar; external MySSL_DLL_name name fn_SSL_state_string;
  function  f_SSL_rstate_string(s: PSSL):PChar; external MySSL_DLL_name name fn_SSL_rstate_string;
  function  f_SSL_state_string_long(s: PSSL):PChar; external MySSL_DLL_name name fn_SSL_state_string_long;
  function  f_SSL_rstate_string_long(s: PSSL):PChar; external MySSL_DLL_name name fn_SSL_rstate_string_long;
  function  f_SSL_SESSION_get_time(s: PSSL_SESSION):Longint; external MySSL_DLL_name name fn_SSL_SESSION_get_time;
  function  f_SSL_SESSION_set_time(s: PSSL_SESSION; t: Longint):Longint; external MySSL_DLL_name name fn_SSL_SESSION_set_time;
  function  f_SSL_SESSION_get_timeout(s: PSSL_SESSION):Longint; external MySSL_DLL_name name fn_SSL_SESSION_get_timeout;
  function  f_SSL_SESSION_set_timeout(s: PSSL_SESSION; t: Longint):Longint; external MySSL_DLL_name name fn_SSL_SESSION_set_timeout;
  procedure f_SSL_copy_session_id(_to: PSSL; from: PSSL); external MySSL_DLL_name name fn_SSL_copy_session_id;
  function  f_SSL_SESSION_new:PSSL_SESSION; external MySSL_DLL_name name fn_SSL_SESSION_new;
  function  f_SSL_SESSION_hash(a: PSSL_SESSION):Cardinal; external MySSL_DLL_name name fn_SSL_SESSION_hash;
  function  f_SSL_SESSION_cmp(a: PSSL_SESSION; b: PSSL_SESSION):Integer; external MySSL_DLL_name name fn_SSL_SESSION_cmp;
  function  f_SSL_SESSION_print_fp(fp: PFILE; ses: PSSL_SESSION):Integer; external MySSL_DLL_name name fn_SSL_SESSION_print_fp;
  function  f_SSL_SESSION_print(fp: PBIO; ses: PSSL_SESSION):Integer; external MySSL_DLL_name name fn_SSL_SESSION_print;
  procedure f_SSL_SESSION_free(ses: PSSL_SESSION); external MySSL_DLL_name name fn_SSL_SESSION_free;
  function  f_i2d_SSL_SESSION(_in: PSSL_SESSION; pp: PPChar):Integer; external MySSL_DLL_name name fn_i2d_SSL_SESSION;
  function  f_SSL_set_session(_to: PSSL; session: PSSL_SESSION):Integer; external MySSL_DLL_name name fn_SSL_set_session;
  function  f_SSL_CTX_add_session(s: PSSL_CTX; c: PSSL_SESSION):Integer; external MySSL_DLL_name name fn_SSL_CTX_add_session;
  function  f_SSL_CTX_remove_session(arg0: PSSL_CTX; c: PSSL_SESSION):Integer; external MySSL_DLL_name name fn_SSL_CTX_remove_session;
  function  f_d2i_SSL_SESSION(a: PPSSL_SESSION; pp: PPChar; length: Longint):PSSL_SESSION; external MySSL_DLL_name name fn_d2i_SSL_SESSION;
  function  f_SSL_get_peer_certificate(s: PSSL):PX509; external MySSL_DLL_name name fn_SSL_get_peer_certificate;
  function  f_SSL_get_peer_cert_chain(s: PSSL):PSTACK_X509; external MySSL_DLL_name name fn_SSL_get_peer_cert_chain;
  function  f_SSL_CTX_get_verify_mode(ctx: PSSL_CTX):Integer; external MySSL_DLL_name name fn_SSL_CTX_get_verify_mode;
  function  f_SSL_CTX_get_verify_depth(ctx: PSSL_CTX):Integer; external MySSL_DLL_name name fn_SSL_CTX_get_verify_depth;
  procedure f_SSL_CTX_set_verify(ctx: PSSL_CTX; mode: Integer; arg2: PFunction); external MySSL_DLL_name name fn_SSL_CTX_set_verify;
  procedure f_SSL_CTX_set_verify_depth(ctx: PSSL_CTX; depth: Integer); external MySSL_DLL_name name fn_SSL_CTX_set_verify_depth;
  procedure f_SSL_CTX_set_cert_verify_callback(ctx: PSSL_CTX; arg1: PFunction; arg: PChar); external MySSL_DLL_name name fn_SSL_CTX_set_cert_verify_callback;
  function  f_SSL_CTX_use_RSAPrivateKey(ctx: PSSL_CTX; rsa: PRSA):Integer; external MySSL_DLL_name name fn_SSL_CTX_use_RSAPrivateKey;
  function  f_SSL_CTX_use_RSAPrivateKey_ASN1(ctx: PSSL_CTX; d: PChar; len: Longint):Integer; external MySSL_DLL_name name fn_SSL_CTX_use_RSAPrivateKey_ASN1;
  function  f_SSL_CTX_use_PrivateKey(ctx: PSSL_CTX; pkey: PEVP_PKEY):Integer; external MySSL_DLL_name name fn_SSL_CTX_use_PrivateKey;
  function  f_SSL_CTX_use_PrivateKey_ASN1(pk: Integer; ctx: PSSL_CTX; d: PChar; len: Longint):Integer; external MySSL_DLL_name name fn_SSL_CTX_use_PrivateKey_ASN1;
  function  f_SSL_CTX_use_certificate(ctx: PSSL_CTX; x: PX509):Integer; external MySSL_DLL_name name fn_SSL_CTX_use_certificate;
  function  f_SSL_CTX_use_certificate_ASN1(ctx: PSSL_CTX; len: Integer; d: PChar):Integer; external MySSL_DLL_name name fn_SSL_CTX_use_certificate_ASN1;
  procedure f_SSL_CTX_set_default_passwd_cb(ctx: PSSL_CTX; cb: Ppem_password_cb); external MySSL_DLL_name name fn_SSL_CTX_set_default_passwd_cb;
  procedure f_SSL_CTX_set_default_passwd_cb_userdata(ctx: PSSL_CTX; u: Pointer); external MySSL_DLL_name name fn_SSL_CTX_set_default_passwd_cb_userdata;
  function  f_SSL_CTX_check_private_key(ctx: PSSL_CTX):Integer; external MySSL_DLL_name name fn_SSL_CTX_check_private_key;
  function  f_SSL_check_private_key(ctx: PSSL):Integer; external MySSL_DLL_name name fn_SSL_check_private_key;
  function  f_SSL_CTX_set_session_id_context(ctx: PSSL_CTX; const sid_ctx: PChar; sid_ctx_len: UInteger):Integer; external MySSL_DLL_name name fn_SSL_CTX_set_session_id_context;
  function  f_SSL_new(ctx: PSSL_CTX):PSSL; external MySSL_DLL_name name fn_SSL_new;
  function  f_SSL_set_session_id_context(ssl: PSSL; const sid_ctx: PChar; sid_ctx_len: UInteger):Integer; external MySSL_DLL_name name fn_SSL_set_session_id_context;
  procedure f_SSL_free(ssl: PSSL); external MySSL_DLL_name name fn_SSL_free;
  function  f_SSL_accept(ssl: PSSL):Integer; external MySSL_DLL_name name fn_SSL_accept;
  function  f_SSL_connect(ssl: PSSL):Integer; external MySSL_DLL_name name fn_SSL_connect;
  function  f_SSL_read(ssl: PSSL; buf: PChar; num: Integer):Integer; external MySSL_DLL_name name fn_SSL_read;
  function  f_SSL_peek(ssl: PSSL; buf: PChar; num: Integer):Integer; external MySSL_DLL_name name fn_SSL_peek;
  function  f_SSL_write(ssl: PSSL; const buf: PChar; num: Integer):Integer; external MySSL_DLL_name name fn_SSL_write;
  function  f_SSL_ctrl(ssl: PSSL; cmd: Integer; larg: Longint; parg: PChar):Longint; external MySSL_DLL_name name fn_SSL_ctrl;
  function  f_SSL_CTX_ctrl(ctx: PSSL_CTX; cmd: Integer; larg: Longint; parg: PChar):Longint; external MySSL_DLL_name name fn_SSL_CTX_ctrl;
  function  f_SSL_get_error(s: PSSL; ret_code: Integer):Integer; external MySSL_DLL_name name fn_SSL_get_error;
  function  f_SSL_get_version(s: PSSL):PChar; external MySSL_DLL_name name fn_SSL_get_version;
  function  f_SSL_CTX_set_ssl_version(ctx: PSSL_CTX; meth: PSSL_METHOD):Integer; external MySSL_DLL_name name fn_SSL_CTX_set_ssl_version;
  function  f_SSLv2_method:PSSL_METHOD; external MySSL_DLL_name name fn_SSLv2_method;
  function  f_SSLv2_server_method:PSSL_METHOD; external MySSL_DLL_name name fn_SSLv2_server_method;
  function  f_SSLv2_client_method:PSSL_METHOD; external MySSL_DLL_name name fn_SSLv2_client_method;
  function  f_SSLv3_method:PSSL_METHOD; external MySSL_DLL_name name fn_SSLv3_method;
  function  f_SSLv3_server_method:PSSL_METHOD; external MySSL_DLL_name name fn_SSLv3_server_method;
  function  f_SSLv3_client_method:PSSL_METHOD; external MySSL_DLL_name name fn_SSLv3_client_method;
  function  f_SSLv23_method:PSSL_METHOD; external MySSL_DLL_name name fn_SSLv23_method;
  function  f_SSLv23_server_method:PSSL_METHOD; external MySSL_DLL_name name fn_SSLv23_server_method;
  function  f_SSLv23_client_method:PSSL_METHOD; external MySSL_DLL_name name fn_SSLv23_client_method;
  function  f_TLSv1_method:PSSL_METHOD; external MySSL_DLL_name name fn_TLSv1_method;
  function  f_TLSv1_server_method:PSSL_METHOD; external MySSL_DLL_name name fn_TLSv1_server_method;
  function  f_TLSv1_client_method:PSSL_METHOD; external MySSL_DLL_name name fn_TLSv1_client_method;
  function  f_SSL_get_ciphers(s: PSSL):PSTACK_SSL_CIPHER; external MySSL_DLL_name name fn_SSL_get_ciphers;
  function  f_SSL_do_handshake(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_do_handshake;
  function  f_SSL_renegotiate(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_renegotiate;
  function  f_SSL_shutdown(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_shutdown;
  function  f_SSL_get_ssl_method(s: PSSL):PSSL_METHOD; external MySSL_DLL_name name fn_SSL_get_ssl_method;
  function  f_SSL_set_ssl_method(s: PSSL; method: PSSL_METHOD):Integer; external MySSL_DLL_name name fn_SSL_set_ssl_method;
  function  f_SSL_alert_type_string_long(value: Integer):PChar; external MySSL_DLL_name name fn_SSL_alert_type_string_long;
  function  f_SSL_alert_type_string(value: Integer):PChar; external MySSL_DLL_name name fn_SSL_alert_type_string;
  function  f_SSL_alert_desc_string_long(value: Integer):PChar; external MySSL_DLL_name name fn_SSL_alert_desc_string_long;
  function  f_SSL_alert_desc_string(value: Integer):PChar; external MySSL_DLL_name name fn_SSL_alert_desc_string;
  procedure f_SSL_set_client_CA_list(s: PSSL; list: PSTACK_X509_NAME); external MySSL_DLL_name name fn_SSL_set_client_CA_list;
  procedure f_SSL_CTX_set_client_CA_list(ctx: PSSL_CTX; list: PSTACK_X509_NAME); external MySSL_DLL_name name fn_SSL_CTX_set_client_CA_list;
  function  f_SSL_get_client_CA_list(s: PSSL):PSTACK_X509_NAME; external MySSL_DLL_name name fn_SSL_get_client_CA_list;
  function  f_SSL_CTX_get_client_CA_list(s: PSSL_CTX):PSTACK_X509_NAME; external MySSL_DLL_name name fn_SSL_CTX_get_client_CA_list;
  function  f_SSL_add_client_CA(ssl: PSSL; x: PX509):Integer; external MySSL_DLL_name name fn_SSL_add_client_CA;
  function  f_SSL_CTX_add_client_CA(ctx: PSSL_CTX; x: PX509):Integer; external MySSL_DLL_name name fn_SSL_CTX_add_client_CA;
  procedure f_SSL_set_connect_state(s: PSSL); external MySSL_DLL_name name fn_SSL_set_connect_state;
  procedure f_SSL_set_accept_state(s: PSSL); external MySSL_DLL_name name fn_SSL_set_accept_state;
  function  f_SSL_get_default_timeout(s: PSSL):Longint; external MySSL_DLL_name name fn_SSL_get_default_timeout;
  function  f_SSL_library_init:Integer; external MySSL_DLL_name name fn_SSL_library_init;
  function  f_SSL_CIPHER_description(arg0: PSSL_CIPHER; buf: PChar; size: Integer):PChar; external MySSL_DLL_name name fn_SSL_CIPHER_description;
  function  f_SSL_dup_CA_list(sk: PSTACK_X509_NAME):PSTACK_X509_NAME; external MySSL_DLL_name name fn_SSL_dup_CA_list;
  function  f_SSL_dup(ssl: PSSL):PSSL; external MySSL_DLL_name name fn_SSL_dup;
  function  f_SSL_get_certificate(ssl: PSSL):PX509; external MySSL_DLL_name name fn_SSL_get_certificate;
  function  f_SSL_get_privatekey(ssl: PSSL):Pevp_pkey_st; external MySSL_DLL_name name fn_SSL_get_privatekey;
  procedure f_SSL_CTX_set_quiet_shutdown(ctx: PSSL_CTX; mode: Integer); external MySSL_DLL_name name fn_SSL_CTX_set_quiet_shutdown;
  function  f_SSL_CTX_get_quiet_shutdown(ctx: PSSL_CTX):Integer; external MySSL_DLL_name name fn_SSL_CTX_get_quiet_shutdown;
  procedure f_SSL_set_quiet_shutdown(ssl: PSSL; mode: Integer); external MySSL_DLL_name name fn_SSL_set_quiet_shutdown;
  function  f_SSL_get_quiet_shutdown(ssl: PSSL):Integer; external MySSL_DLL_name name fn_SSL_get_quiet_shutdown;
  procedure f_SSL_set_shutdown(ssl: PSSL; mode: Integer); external MySSL_DLL_name name fn_SSL_set_shutdown;
  function  f_SSL_get_shutdown(ssl: PSSL):Integer; external MySSL_DLL_name name fn_SSL_get_shutdown;
  function  f_SSL_version(ssl: PSSL):Integer; external MySSL_DLL_name name fn_SSL_version;
  function  f_SSL_CTX_set_default_verify_paths(ctx: PSSL_CTX):Integer; external MySSL_DLL_name name fn_SSL_CTX_set_default_verify_paths;
  function  f_SSL_CTX_load_verify_locations(ctx: PSSL_CTX; const CAfile: PChar; const CApath: PChar):Integer; external MySSL_DLL_name name fn_SSL_CTX_load_verify_locations;
  function  f_SSL_get_session(ssl: PSSL):PSSL_SESSION; external MySSL_DLL_name name fn_SSL_get_session;
  function  f_SSL_get_SSL_CTX(ssl: PSSL):PSSL_CTX; external MySSL_DLL_name name fn_SSL_get_SSL_CTX;
  procedure f_SSL_set_info_callback(ssl: PSSL; arg1: PFunction); external MySSL_DLL_name name fn_SSL_set_info_callback;
  function  f_SSL_state(ssl: PSSL):Integer; external MySSL_DLL_name name fn_SSL_state;
  procedure f_SSL_set_verify_result(ssl: PSSL; v: Longint); external MySSL_DLL_name name fn_SSL_set_verify_result;
  function  f_SSL_get_verify_result(ssl: PSSL):Longint; external MySSL_DLL_name name fn_SSL_get_verify_result;
  function  f_SSL_set_ex_data(ssl: PSSL; idx: Integer; data: Pointer):Integer; external MySSL_DLL_name name fn_SSL_set_ex_data;
  function  f_SSL_get_ex_data(ssl: PSSL; idx: Integer):Pointer; external MySSL_DLL_name name fn_SSL_get_ex_data;
  function  f_SSL_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; external MySSL_DLL_name name fn_SSL_get_ex_new_index;
  function  f_SSL_SESSION_set_ex_data(ss: PSSL_SESSION; idx: Integer; data: Pointer):Integer; external MySSL_DLL_name name fn_SSL_SESSION_set_ex_data;
  function  f_SSL_SESSION_get_ex_data(ss: PSSL_SESSION; idx: Integer):Pointer; external MySSL_DLL_name name fn_SSL_SESSION_get_ex_data;
  function  f_SSL_SESSION_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; external MySSL_DLL_name name fn_SSL_SESSION_get_ex_new_index;
  function  f_SSL_CTX_set_ex_data(ssl: PSSL_CTX; idx: Integer; data: Pointer):Integer; external MySSL_DLL_name name fn_SSL_CTX_set_ex_data;
  function  f_SSL_CTX_get_ex_data(ssl: PSSL_CTX; idx: Integer):Pointer; external MySSL_DLL_name name fn_SSL_CTX_get_ex_data;
  function  f_SSL_CTX_get_ex_new_index(argl: Longint; argp: PChar; arg2: PFunction; arg3: PFunction; arg4: PFunction):Integer; external MySSL_DLL_name name fn_SSL_CTX_get_ex_new_index;
  function  f_SSL_get_ex_data_X509_STORE_CTX_idx:Integer; external MySSL_DLL_name name fn_SSL_get_ex_data_X509_STORE_CTX_idx;
  procedure f_SSL_CTX_set_tmp_rsa_callback(ctx: PSSL_CTX; arg1: PFunction); external MySSL_DLL_name name fn_SSL_CTX_set_tmp_rsa_callback;
  procedure f_SSL_set_tmp_rsa_callback(ssl: PSSL; arg1: PFunction); external MySSL_DLL_name name fn_SSL_set_tmp_rsa_callback;
  procedure f_SSL_CTX_set_tmp_dh_callback(ctx: PSSL_CTX; arg1: PFunction); external MySSL_DLL_name name fn_SSL_CTX_set_tmp_dh_callback;
  procedure f_SSL_set_tmp_dh_callback(ssl: PSSL; arg1: PFunction); external MySSL_DLL_name name fn_SSL_set_tmp_dh_callback;
  function  f_SSL_COMP_add_compression_method(id: Integer; cm: PChar):Integer; external MySSL_DLL_name name fn_SSL_COMP_add_compression_method;
  function  f_SSLeay_add_ssl_algorithms:Integer; external MySSL_DLL_name name fn_SSLeay_add_ssl_algorithms;
  function  f_SSL_set_app_data(s: PSSL; arg: Pointer):Integer; external MySSL_DLL_name name fn_SSL_set_app_data;
  function  f_SSL_get_app_data(s: PSSL):Pointer; external MySSL_DLL_name name fn_SSL_get_app_data;
  procedure f_SSL_CTX_set_info_callback(ctx: PSSL_CTX; cb: PFunction); external MySSL_DLL_name name fn_SSL_CTX_set_info_callback;
  function  f_SSL_CTX_set_options(ctx: PSSL_CTX; op: Longint):Longint; external MySSL_DLL_name name fn_SSL_CTX_set_options;
  function  f_SSL_is_init_finished(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_is_init_finished;
  function  f_SSL_in_init(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_in_init;
  function  f_SSL_in_before(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_in_before;
  function  f_SSL_in_connect_init(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_in_connect_init;
  function  f_SSL_in_accept_init(s: PSSL):Integer; external MySSL_DLL_name name fn_SSL_in_accept_init;
  function  f_X509_STORE_CTX_get_app_data(ctx: PX509_STORE_CTX):Pointer; external MySSL_DLL_name name fn_X509_STORE_CTX_get_app_data;
  function  f_X509_get_notBefore(x509: PX509):PASN1_UTCTIME; external MySSL_DLL_name name fn_X509_get_notBefore;
  function  f_X509_get_notAfter(x509: PX509):PASN1_UTCTIME; external MySSL_DLL_name name fn_X509_get_notAfter;
  function  f_UCTTimeDecode(UCTtime: PASN1_UTCTIME; year: PUShort; month: PUShort; day: PUShort; hour: PUShort; min: PUShort; sec: PUShort; tz_hour: PInteger; tz_min: PInteger):Integer; external MySSL_DLL_name name fn_UCTTimeDecode;
  function  f_SSL_CTX_get_version(ctx: PSSL_CTX):Integer; external MySSL_DLL_name name fn_SSL_CTX_get_version;
  function  f_SSL_SESSION_get_id(s: PSSL_SESSION; id: PPChar; length: PInteger):Integer; external MySSL_DLL_name name fn_SSL_SESSION_get_id;
  function  f_SSL_SESSION_get_id_ctx(s: PSSL_SESSION; id: PPChar; length: PInteger):Integer; external MySSL_DLL_name name fn_SSL_SESSION_get_id_ctx;
  function  f_fopen(const path: PChar; mode: PChar):PFILE; external MySSL_DLL_name name fn_fopen;
  function  f_fclose(stream: PFILE):Integer; external MySSL_DLL_name name fn_fclose;

{$ENDIF}

{$IFNDEF MySSL_STATIC}
Function LoadFunction(FceName:String):Pointer;
Begin
  FceName := FceName+#0;
  Result := GetProcAddress(hMySSL, @FceName[1]);
End;
{$ENDIF}

Function Load:Boolean;
begin
  result := True;
  {$IFDEF MySSL_STATIC}
  { If program linked in static mode can exec this code, all entry points     }
  { in dll was found. Top level code need not to recognize if it is staticaly }
  { or dynamicaly linked ... always look like dynamicaly                      }
  {$ELSE}
  If hMySSL=0 Then hMySSL := LoadLibrary(MySSL_DLL_name) Else Exit;
  @f_sk_num := LoadFunction(fn_sk_num);
  @f_sk_value := LoadFunction(fn_sk_value);
  @f_sk_set := LoadFunction(fn_sk_set);
  @f_sk_new := LoadFunction(fn_sk_new);
  @f_sk_free := LoadFunction(fn_sk_free);
  @f_sk_pop_free := LoadFunction(fn_sk_pop_free);
  @f_sk_insert := LoadFunction(fn_sk_insert);
  @f_sk_delete := LoadFunction(fn_sk_delete);
  @f_sk_delete_ptr := LoadFunction(fn_sk_delete_ptr);
  @f_sk_find := LoadFunction(fn_sk_find);
  @f_sk_push := LoadFunction(fn_sk_push);
  @f_sk_unshift := LoadFunction(fn_sk_unshift);
  @f_sk_shift := LoadFunction(fn_sk_shift);
  @f_sk_pop := LoadFunction(fn_sk_pop);
  @f_sk_zero := LoadFunction(fn_sk_zero);
  @f_sk_dup := LoadFunction(fn_sk_dup);
  @f_sk_sort := LoadFunction(fn_sk_sort);
  @f_SSLeay_version := LoadFunction(fn_SSLeay_version);
  @f_SSLeay := LoadFunction(fn_SSLeay);
  @f_CRYPTO_get_ex_new_index := LoadFunction(fn_CRYPTO_get_ex_new_index);
  @f_CRYPTO_set_ex_data := LoadFunction(fn_CRYPTO_set_ex_data);
  @f_CRYPTO_get_ex_data := LoadFunction(fn_CRYPTO_get_ex_data);
  @f_CRYPTO_dup_ex_data := LoadFunction(fn_CRYPTO_dup_ex_data);
  @f_CRYPTO_free_ex_data := LoadFunction(fn_CRYPTO_free_ex_data);
  @f_CRYPTO_new_ex_data := LoadFunction(fn_CRYPTO_new_ex_data);
  @f_CRYPTO_mem_ctrl := LoadFunction(fn_CRYPTO_mem_ctrl);
  @f_CRYPTO_get_new_lockid := LoadFunction(fn_CRYPTO_get_new_lockid);
  @f_CRYPTO_num_locks := LoadFunction(fn_CRYPTO_num_locks);
  @f_CRYPTO_lock := LoadFunction(fn_CRYPTO_lock);
  @f_CRYPTO_set_locking_callback := LoadFunction(fn_CRYPTO_set_locking_callback);
  @f_CRYPTO_set_add_lock_callback := LoadFunction(fn_CRYPTO_set_add_lock_callback);
  @f_CRYPTO_set_id_callback := LoadFunction(fn_CRYPTO_set_id_callback);
  @f_CRYPTO_thread_id := LoadFunction(fn_CRYPTO_thread_id);
  @f_CRYPTO_get_lock_name := LoadFunction(fn_CRYPTO_get_lock_name);
  @f_CRYPTO_add_lock := LoadFunction(fn_CRYPTO_add_lock);
  @f_CRYPTO_set_mem_functions := LoadFunction(fn_CRYPTO_set_mem_functions);
  @f_CRYPTO_get_mem_functions := LoadFunction(fn_CRYPTO_get_mem_functions);
  @f_CRYPTO_set_locked_mem_functions := LoadFunction(fn_CRYPTO_set_locked_mem_functions);
  @f_CRYPTO_get_locked_mem_functions := LoadFunction(fn_CRYPTO_get_locked_mem_functions);
  @f_CRYPTO_malloc_locked := LoadFunction(fn_CRYPTO_malloc_locked);
  @f_CRYPTO_free_locked := LoadFunction(fn_CRYPTO_free_locked);
  @f_CRYPTO_malloc := LoadFunction(fn_CRYPTO_malloc);
  @f_CRYPTO_free := LoadFunction(fn_CRYPTO_free);
  @f_CRYPTO_realloc := LoadFunction(fn_CRYPTO_realloc);
  @f_CRYPTO_remalloc := LoadFunction(fn_CRYPTO_remalloc);
  @f_CRYPTO_dbg_malloc := LoadFunction(fn_CRYPTO_dbg_malloc);
  @f_CRYPTO_dbg_realloc := LoadFunction(fn_CRYPTO_dbg_realloc);
  @f_CRYPTO_dbg_free := LoadFunction(fn_CRYPTO_dbg_free);
  @f_CRYPTO_dbg_remalloc := LoadFunction(fn_CRYPTO_dbg_remalloc);
  @f_CRYPTO_mem_leaks_fp := LoadFunction(fn_CRYPTO_mem_leaks_fp);
  @f_CRYPTO_mem_leaks := LoadFunction(fn_CRYPTO_mem_leaks);
  @f_CRYPTO_mem_leaks_cb := LoadFunction(fn_CRYPTO_mem_leaks_cb);
  @f_ERR_load_CRYPTO_strings := LoadFunction(fn_ERR_load_CRYPTO_strings);
  @f_lh_new := LoadFunction(fn_lh_new);
  @f_lh_free := LoadFunction(fn_lh_free);
  @f_lh_insert := LoadFunction(fn_lh_insert);
  @f_lh_delete := LoadFunction(fn_lh_delete);
  @f_lh_retrieve := LoadFunction(fn_lh_retrieve);
  @f_lh_doall := LoadFunction(fn_lh_doall);
  @f_lh_doall_arg := LoadFunction(fn_lh_doall_arg);
  @f_lh_strhash := LoadFunction(fn_lh_strhash);
  @f_lh_stats := LoadFunction(fn_lh_stats);
  @f_lh_node_stats := LoadFunction(fn_lh_node_stats);
  @f_lh_node_usage_stats := LoadFunction(fn_lh_node_usage_stats);
  @f_BUF_MEM_new := LoadFunction(fn_BUF_MEM_new);
  @f_BUF_MEM_free := LoadFunction(fn_BUF_MEM_free);
  @f_BUF_MEM_grow := LoadFunction(fn_BUF_MEM_grow);
  @f_BUF_strdup := LoadFunction(fn_BUF_strdup);
  @f_ERR_load_BUF_strings := LoadFunction(fn_ERR_load_BUF_strings);
  @f_BIO_ctrl_pending := LoadFunction(fn_BIO_ctrl_pending);
  @f_BIO_ctrl_wpending := LoadFunction(fn_BIO_ctrl_wpending);
  @f_BIO_ctrl_get_write_guarantee := LoadFunction(fn_BIO_ctrl_get_write_guarantee);
  @f_BIO_ctrl_get_read_request := LoadFunction(fn_BIO_ctrl_get_read_request);
  @f_BIO_set_ex_data := LoadFunction(fn_BIO_set_ex_data);
  @f_BIO_get_ex_data := LoadFunction(fn_BIO_get_ex_data);
  @f_BIO_get_ex_new_index := LoadFunction(fn_BIO_get_ex_new_index);
  @f_BIO_s_file := LoadFunction(fn_BIO_s_file);
  @f_BIO_new_file := LoadFunction(fn_BIO_new_file);
  @f_BIO_new_fp := LoadFunction(fn_BIO_new_fp);
  @f_BIO_new := LoadFunction(fn_BIO_new);
  @f_BIO_set := LoadFunction(fn_BIO_set);
  @f_BIO_free := LoadFunction(fn_BIO_free);
  @f_BIO_read := LoadFunction(fn_BIO_read);
  @f_BIO_gets := LoadFunction(fn_BIO_gets);
  @f_BIO_write := LoadFunction(fn_BIO_write);
  @f_BIO_puts := LoadFunction(fn_BIO_puts);
  @f_BIO_ctrl := LoadFunction(fn_BIO_ctrl);
  @f_BIO_ptr_ctrl := LoadFunction(fn_BIO_ptr_ctrl);
  @f_BIO_int_ctrl := LoadFunction(fn_BIO_int_ctrl);
  @f_BIO_push := LoadFunction(fn_BIO_push);
  @f_BIO_pop := LoadFunction(fn_BIO_pop);
  @f_BIO_free_all := LoadFunction(fn_BIO_free_all);
  @f_BIO_find_type := LoadFunction(fn_BIO_find_type);
  @f_BIO_get_retry_BIO := LoadFunction(fn_BIO_get_retry_BIO);
  @f_BIO_get_retry_reason := LoadFunction(fn_BIO_get_retry_reason);
  @f_BIO_dup_chain := LoadFunction(fn_BIO_dup_chain);
  @f_BIO_debug_callback := LoadFunction(fn_BIO_debug_callback);
  @f_BIO_s_mem := LoadFunction(fn_BIO_s_mem);
  @f_BIO_s_socket := LoadFunction(fn_BIO_s_socket);
  @f_BIO_s_connect := LoadFunction(fn_BIO_s_connect);
  @f_BIO_s_accept := LoadFunction(fn_BIO_s_accept);
  @f_BIO_s_fd := LoadFunction(fn_BIO_s_fd);
  @f_BIO_s_bio := LoadFunction(fn_BIO_s_bio);
  @f_BIO_s_null := LoadFunction(fn_BIO_s_null);
  @f_BIO_f_null := LoadFunction(fn_BIO_f_null);
  @f_BIO_f_buffer := LoadFunction(fn_BIO_f_buffer);
  @f_BIO_f_nbio_test := LoadFunction(fn_BIO_f_nbio_test);
  @f_BIO_sock_should_retry := LoadFunction(fn_BIO_sock_should_retry);
  @f_BIO_sock_non_fatal_error := LoadFunction(fn_BIO_sock_non_fatal_error);
  @f_BIO_fd_should_retry := LoadFunction(fn_BIO_fd_should_retry);
  @f_BIO_fd_non_fatal_error := LoadFunction(fn_BIO_fd_non_fatal_error);
  @f_BIO_dump := LoadFunction(fn_BIO_dump);
  @f_BIO_gethostbyname := LoadFunction(fn_BIO_gethostbyname);
  @f_BIO_sock_error := LoadFunction(fn_BIO_sock_error);
  @f_BIO_socket_ioctl := LoadFunction(fn_BIO_socket_ioctl);
  @f_BIO_socket_nbio := LoadFunction(fn_BIO_socket_nbio);
  @f_BIO_get_port := LoadFunction(fn_BIO_get_port);
  @f_BIO_get_host_ip := LoadFunction(fn_BIO_get_host_ip);
  @f_BIO_get_accept_socket := LoadFunction(fn_BIO_get_accept_socket);
  @f_BIO_accept := LoadFunction(fn_BIO_accept);
  @f_BIO_sock_init := LoadFunction(fn_BIO_sock_init);
  @f_BIO_sock_cleanup := LoadFunction(fn_BIO_sock_cleanup);
  @f_BIO_set_tcp_ndelay := LoadFunction(fn_BIO_set_tcp_ndelay);
  @f_ERR_load_BIO_strings := LoadFunction(fn_ERR_load_BIO_strings);
  @f_BIO_new_socket := LoadFunction(fn_BIO_new_socket);
  @f_BIO_new_fd := LoadFunction(fn_BIO_new_fd);
  @f_BIO_new_connect := LoadFunction(fn_BIO_new_connect);
  @f_BIO_new_accept := LoadFunction(fn_BIO_new_accept);
  @f_BIO_new_bio_pair := LoadFunction(fn_BIO_new_bio_pair);
  @f_BIO_copy_next_retry := LoadFunction(fn_BIO_copy_next_retry);
  @f_BIO_ghbn_ctrl := LoadFunction(fn_BIO_ghbn_ctrl);
  @f_MD2_options := LoadFunction(fn_MD2_options);
  @f_MD2_Init := LoadFunction(fn_MD2_Init);
  @f_MD2_Update := LoadFunction(fn_MD2_Update);
  @f_MD2_Final := LoadFunction(fn_MD2_Final);
  @f_MD2 := LoadFunction(fn_MD2);
  @f_MD5_Init := LoadFunction(fn_MD5_Init);
  @f_MD5_Update := LoadFunction(fn_MD5_Update);
  @f_MD5_Final := LoadFunction(fn_MD5_Final);
  @f_MD5 := LoadFunction(fn_MD5);
  @f_MD5_Transform := LoadFunction(fn_MD5_Transform);
  @f_SHA_Init := LoadFunction(fn_SHA_Init);
  @f_SHA_Update := LoadFunction(fn_SHA_Update);
  @f_SHA_Final := LoadFunction(fn_SHA_Final);
  @f_SHA := LoadFunction(fn_SHA);
  @f_SHA_Transform := LoadFunction(fn_SHA_Transform);
  @f_SHA1_Init := LoadFunction(fn_SHA1_Init);
  @f_SHA1_Update := LoadFunction(fn_SHA1_Update);
  @f_SHA1_Final := LoadFunction(fn_SHA1_Final);
  @f_SHA1 := LoadFunction(fn_SHA1);
  @f_SHA1_Transform := LoadFunction(fn_SHA1_Transform);
  @f_RIPEMD160_Init := LoadFunction(fn_RIPEMD160_Init);
  @f_RIPEMD160_Update := LoadFunction(fn_RIPEMD160_Update);
  @f_RIPEMD160_Final := LoadFunction(fn_RIPEMD160_Final);
  @f_RIPEMD160 := LoadFunction(fn_RIPEMD160);
  @f_RIPEMD160_Transform := LoadFunction(fn_RIPEMD160_Transform);
  @f_des_options := LoadFunction(fn_des_options);
  @f_des_ecb3_encrypt := LoadFunction(fn_des_ecb3_encrypt);
  @f_des_cbc_cksum := LoadFunction(fn_des_cbc_cksum);
  @f_des_cbc_encrypt := LoadFunction(fn_des_cbc_encrypt);
  @f_des_ncbc_encrypt := LoadFunction(fn_des_ncbc_encrypt);
  @f_des_xcbc_encrypt := LoadFunction(fn_des_xcbc_encrypt);
  @f_des_cfb_encrypt := LoadFunction(fn_des_cfb_encrypt);
  @f_des_ecb_encrypt := LoadFunction(fn_des_ecb_encrypt);
  @f_des_encrypt := LoadFunction(fn_des_encrypt);
  @f_des_encrypt2 := LoadFunction(fn_des_encrypt2);
  @f_des_encrypt3 := LoadFunction(fn_des_encrypt3);
  @f_des_decrypt3 := LoadFunction(fn_des_decrypt3);
  @f_des_ede3_cbc_encrypt := LoadFunction(fn_des_ede3_cbc_encrypt);
  @f_des_ede3_cbcm_encrypt := LoadFunction(fn_des_ede3_cbcm_encrypt);
  @f_des_ede3_cfb64_encrypt := LoadFunction(fn_des_ede3_cfb64_encrypt);
  @f_des_ede3_ofb64_encrypt := LoadFunction(fn_des_ede3_ofb64_encrypt);
  @f_des_xwhite_in2out := LoadFunction(fn_des_xwhite_in2out);
  @f_des_enc_read := LoadFunction(fn_des_enc_read);
  @f_des_enc_write := LoadFunction(fn_des_enc_write);
  @f_des_fcrypt := LoadFunction(fn_des_fcrypt);
  @f_crypt := LoadFunction(fn_crypt);
  @f_des_ofb_encrypt := LoadFunction(fn_des_ofb_encrypt);
  @f_des_pcbc_encrypt := LoadFunction(fn_des_pcbc_encrypt);
  @f_des_quad_cksum := LoadFunction(fn_des_quad_cksum);
  @f_des_random_seed := LoadFunction(fn_des_random_seed);
  @f_des_random_key := LoadFunction(fn_des_random_key);
  @f_des_read_password := LoadFunction(fn_des_read_password);
  @f_des_read_2passwords := LoadFunction(fn_des_read_2passwords);
  @f_des_read_pw_string := LoadFunction(fn_des_read_pw_string);
  @f_des_set_odd_parity := LoadFunction(fn_des_set_odd_parity);
  @f_des_is_weak_key := LoadFunction(fn_des_is_weak_key);
  @f_des_set_key := LoadFunction(fn_des_set_key);
  @f_des_key_sched := LoadFunction(fn_des_key_sched);
  @f_des_string_to_key := LoadFunction(fn_des_string_to_key);
  @f_des_string_to_2keys := LoadFunction(fn_des_string_to_2keys);
  @f_des_cfb64_encrypt := LoadFunction(fn_des_cfb64_encrypt);
  @f_des_ofb64_encrypt := LoadFunction(fn_des_ofb64_encrypt);
  @f_des_read_pw := LoadFunction(fn_des_read_pw);
  @f_des_cblock_print_file := LoadFunction(fn_des_cblock_print_file);
  @f_RC4_options := LoadFunction(fn_RC4_options);
  @f_RC4_set_key := LoadFunction(fn_RC4_set_key);
  @f_RC4 := LoadFunction(fn_RC4);
  @f_RC2_set_key := LoadFunction(fn_RC2_set_key);
  @f_RC2_ecb_encrypt := LoadFunction(fn_RC2_ecb_encrypt);
  @f_RC2_encrypt := LoadFunction(fn_RC2_encrypt);
  @f_RC2_decrypt := LoadFunction(fn_RC2_decrypt);
  @f_RC2_cbc_encrypt := LoadFunction(fn_RC2_cbc_encrypt);
  @f_RC2_cfb64_encrypt := LoadFunction(fn_RC2_cfb64_encrypt);
  @f_RC2_ofb64_encrypt := LoadFunction(fn_RC2_ofb64_encrypt);
  @f_RC5_32_set_key := LoadFunction(fn_RC5_32_set_key);
  @f_RC5_32_ecb_encrypt := LoadFunction(fn_RC5_32_ecb_encrypt);
  @f_RC5_32_encrypt := LoadFunction(fn_RC5_32_encrypt);
  @f_RC5_32_decrypt := LoadFunction(fn_RC5_32_decrypt);
  @f_RC5_32_cbc_encrypt := LoadFunction(fn_RC5_32_cbc_encrypt);
  @f_RC5_32_cfb64_encrypt := LoadFunction(fn_RC5_32_cfb64_encrypt);
  @f_RC5_32_ofb64_encrypt := LoadFunction(fn_RC5_32_ofb64_encrypt);
  @f_BF_set_key := LoadFunction(fn_BF_set_key);
  @f_BF_ecb_encrypt := LoadFunction(fn_BF_ecb_encrypt);
  @f_BF_encrypt := LoadFunction(fn_BF_encrypt);
  @f_BF_decrypt := LoadFunction(fn_BF_decrypt);
  @f_BF_cbc_encrypt := LoadFunction(fn_BF_cbc_encrypt);
  @f_BF_cfb64_encrypt := LoadFunction(fn_BF_cfb64_encrypt);
  @f_BF_ofb64_encrypt := LoadFunction(fn_BF_ofb64_encrypt);
  @f_BF_options := LoadFunction(fn_BF_options);
  @f_CAST_set_key := LoadFunction(fn_CAST_set_key);
  @f_CAST_ecb_encrypt := LoadFunction(fn_CAST_ecb_encrypt);
  @f_CAST_encrypt := LoadFunction(fn_CAST_encrypt);
  @f_CAST_decrypt := LoadFunction(fn_CAST_decrypt);
  @f_CAST_cbc_encrypt := LoadFunction(fn_CAST_cbc_encrypt);
  @f_CAST_cfb64_encrypt := LoadFunction(fn_CAST_cfb64_encrypt);
  @f_CAST_ofb64_encrypt := LoadFunction(fn_CAST_ofb64_encrypt);
  @f_idea_options := LoadFunction(fn_idea_options);
  @f_idea_ecb_encrypt := LoadFunction(fn_idea_ecb_encrypt);
  @f_idea_set_encrypt_key := LoadFunction(fn_idea_set_encrypt_key);
  @f_idea_set_decrypt_key := LoadFunction(fn_idea_set_decrypt_key);
  @f_idea_cbc_encrypt := LoadFunction(fn_idea_cbc_encrypt);
  @f_idea_cfb64_encrypt := LoadFunction(fn_idea_cfb64_encrypt);
  @f_idea_ofb64_encrypt := LoadFunction(fn_idea_ofb64_encrypt);
  @f_idea_encrypt := LoadFunction(fn_idea_encrypt);
  @f_MDC2_Init := LoadFunction(fn_MDC2_Init);
  @f_MDC2_Update := LoadFunction(fn_MDC2_Update);
  @f_MDC2_Final := LoadFunction(fn_MDC2_Final);
  @f_MDC2 := LoadFunction(fn_MDC2);
  @f_BN_value_one := LoadFunction(fn_BN_value_one);
  @f_BN_options := LoadFunction(fn_BN_options);
  @f_BN_CTX_new := LoadFunction(fn_BN_CTX_new);
  @f_BN_CTX_init := LoadFunction(fn_BN_CTX_init);
  @f_BN_CTX_free := LoadFunction(fn_BN_CTX_free);
  @f_BN_rand := LoadFunction(fn_BN_rand);
  @f_BN_num_bits := LoadFunction(fn_BN_num_bits);
  @f_BN_num_bits_word := LoadFunction(fn_BN_num_bits_word);
  @f_BN_new := LoadFunction(fn_BN_new);
  @f_BN_init := LoadFunction(fn_BN_init);
  @f_BN_clear_free := LoadFunction(fn_BN_clear_free);
  @f_BN_copy := LoadFunction(fn_BN_copy);
  @f_BN_bin2bn := LoadFunction(fn_BN_bin2bn);
  @f_BN_bn2bin := LoadFunction(fn_BN_bn2bin);
  @f_BN_mpi2bn := LoadFunction(fn_BN_mpi2bn);
  @f_BN_bn2mpi := LoadFunction(fn_BN_bn2mpi);
  @f_BN_sub := LoadFunction(fn_BN_sub);
  @f_BN_usub := LoadFunction(fn_BN_usub);
  @f_BN_uadd := LoadFunction(fn_BN_uadd);
  @f_BN_add := LoadFunction(fn_BN_add);
  @f_BN_mod := LoadFunction(fn_BN_mod);
  @f_BN_div := LoadFunction(fn_BN_div);
  @f_BN_mul := LoadFunction(fn_BN_mul);
  @f_BN_sqr := LoadFunction(fn_BN_sqr);
  @f_BN_mod_word := LoadFunction(fn_BN_mod_word);
  @f_BN_div_word := LoadFunction(fn_BN_div_word);
  @f_BN_mul_word := LoadFunction(fn_BN_mul_word);
  @f_BN_add_word := LoadFunction(fn_BN_add_word);
  @f_BN_sub_word := LoadFunction(fn_BN_sub_word);
  @f_BN_set_word := LoadFunction(fn_BN_set_word);
  @f_BN_get_word := LoadFunction(fn_BN_get_word);
  @f_BN_cmp := LoadFunction(fn_BN_cmp);
  @f_BN_free := LoadFunction(fn_BN_free);
  @f_BN_is_bit_set := LoadFunction(fn_BN_is_bit_set);
  @f_BN_lshift := LoadFunction(fn_BN_lshift);
  @f_BN_lshift1 := LoadFunction(fn_BN_lshift1);
  @f_BN_exp := LoadFunction(fn_BN_exp);
  @f_BN_mod_exp := LoadFunction(fn_BN_mod_exp);
  @f_BN_mod_exp_mont := LoadFunction(fn_BN_mod_exp_mont);
  @f_BN_mod_exp2_mont := LoadFunction(fn_BN_mod_exp2_mont);
  @f_BN_mod_exp_simple := LoadFunction(fn_BN_mod_exp_simple);
  @f_BN_mask_bits := LoadFunction(fn_BN_mask_bits);
  @f_BN_mod_mul := LoadFunction(fn_BN_mod_mul);
  @f_BN_print_fp := LoadFunction(fn_BN_print_fp);
  @f_BN_print := LoadFunction(fn_BN_print);
  @f_BN_reciprocal := LoadFunction(fn_BN_reciprocal);
  @f_BN_rshift := LoadFunction(fn_BN_rshift);
  @f_BN_rshift1 := LoadFunction(fn_BN_rshift1);
  @f_BN_clear := LoadFunction(fn_BN_clear);
  @f_bn_expand2 := LoadFunction(fn_bn_expand2);
  @f_BN_dup := LoadFunction(fn_BN_dup);
  @f_BN_ucmp := LoadFunction(fn_BN_ucmp);
  @f_BN_set_bit := LoadFunction(fn_BN_set_bit);
  @f_BN_clear_bit := LoadFunction(fn_BN_clear_bit);
  @f_BN_bn2hex := LoadFunction(fn_BN_bn2hex);
  @f_BN_bn2dec := LoadFunction(fn_BN_bn2dec);
  @f_BN_hex2bn := LoadFunction(fn_BN_hex2bn);
  @f_BN_dec2bn := LoadFunction(fn_BN_dec2bn);
  @f_BN_gcd := LoadFunction(fn_BN_gcd);
  @f_BN_mod_inverse := LoadFunction(fn_BN_mod_inverse);
  @f_BN_generate_prime := LoadFunction(fn_BN_generate_prime);
  @f_BN_is_prime := LoadFunction(fn_BN_is_prime);
  @f_ERR_load_BN_strings := LoadFunction(fn_ERR_load_BN_strings);
  @f_bn_mul_add_words := LoadFunction(fn_bn_mul_add_words);
  @f_bn_mul_words := LoadFunction(fn_bn_mul_words);
  @f_bn_sqr_words := LoadFunction(fn_bn_sqr_words);
  @f_bn_div_words := LoadFunction(fn_bn_div_words);
  @f_bn_add_words := LoadFunction(fn_bn_add_words);
  @f_bn_sub_words := LoadFunction(fn_bn_sub_words);
  @f_BN_MONT_CTX_new := LoadFunction(fn_BN_MONT_CTX_new);
  @f_BN_MONT_CTX_init := LoadFunction(fn_BN_MONT_CTX_init);
  @f_BN_mod_mul_montgomery := LoadFunction(fn_BN_mod_mul_montgomery);
  @f_BN_from_montgomery := LoadFunction(fn_BN_from_montgomery);
  @f_BN_MONT_CTX_free := LoadFunction(fn_BN_MONT_CTX_free);
  @f_BN_MONT_CTX_set := LoadFunction(fn_BN_MONT_CTX_set);
  @f_BN_MONT_CTX_copy := LoadFunction(fn_BN_MONT_CTX_copy);
  @f_BN_BLINDING_new := LoadFunction(fn_BN_BLINDING_new);
  @f_BN_BLINDING_free := LoadFunction(fn_BN_BLINDING_free);
  @f_BN_BLINDING_update := LoadFunction(fn_BN_BLINDING_update);
  @f_BN_BLINDING_convert := LoadFunction(fn_BN_BLINDING_convert);
  @f_BN_BLINDING_invert := LoadFunction(fn_BN_BLINDING_invert);
  @f_BN_set_params := LoadFunction(fn_BN_set_params);
  @f_BN_get_params := LoadFunction(fn_BN_get_params);
  @f_BN_RECP_CTX_init := LoadFunction(fn_BN_RECP_CTX_init);
  @f_BN_RECP_CTX_new := LoadFunction(fn_BN_RECP_CTX_new);
  @f_BN_RECP_CTX_free := LoadFunction(fn_BN_RECP_CTX_free);
  @f_BN_RECP_CTX_set := LoadFunction(fn_BN_RECP_CTX_set);
  @f_BN_mod_mul_reciprocal := LoadFunction(fn_BN_mod_mul_reciprocal);
  @f_BN_mod_exp_recp := LoadFunction(fn_BN_mod_exp_recp);
  @f_BN_div_recp := LoadFunction(fn_BN_div_recp);
  @f_RSA_new := LoadFunction(fn_RSA_new);
  @f_RSA_new_method := LoadFunction(fn_RSA_new_method);
  @f_RSA_size := LoadFunction(fn_RSA_size);
  @f_RSA_generate_key := LoadFunction(fn_RSA_generate_key);
  @f_RSA_check_key := LoadFunction(fn_RSA_check_key);
  @f_RSA_public_encrypt := LoadFunction(fn_RSA_public_encrypt);
  @f_RSA_private_encrypt := LoadFunction(fn_RSA_private_encrypt);
  @f_RSA_public_decrypt := LoadFunction(fn_RSA_public_decrypt);
  @f_RSA_private_decrypt := LoadFunction(fn_RSA_private_decrypt);
  @f_RSA_free := LoadFunction(fn_RSA_free);
  @f_RSA_flags := LoadFunction(fn_RSA_flags);
  @f_RSA_set_default_method := LoadFunction(fn_RSA_set_default_method);
  @f_RSA_get_default_method := LoadFunction(fn_RSA_get_default_method);
  @f_RSA_get_method := LoadFunction(fn_RSA_get_method);
  @f_RSA_set_method := LoadFunction(fn_RSA_set_method);
  @f_RSA_memory_lock := LoadFunction(fn_RSA_memory_lock);
  @f_RSA_PKCS1_SSLeay := LoadFunction(fn_RSA_PKCS1_SSLeay);
  @f_ERR_load_RSA_strings := LoadFunction(fn_ERR_load_RSA_strings);
  @f_d2i_RSAPublicKey := LoadFunction(fn_d2i_RSAPublicKey);
  @f_i2d_RSAPublicKey := LoadFunction(fn_i2d_RSAPublicKey);
  @f_d2i_RSAPrivateKey := LoadFunction(fn_d2i_RSAPrivateKey);
  @f_i2d_RSAPrivateKey := LoadFunction(fn_i2d_RSAPrivateKey);
  @f_RSA_print_fp := LoadFunction(fn_RSA_print_fp);
  @f_RSA_print := LoadFunction(fn_RSA_print);
  @f_i2d_Netscape_RSA := LoadFunction(fn_i2d_Netscape_RSA);
  @f_d2i_Netscape_RSA := LoadFunction(fn_d2i_Netscape_RSA);
  @f_d2i_Netscape_RSA_2 := LoadFunction(fn_d2i_Netscape_RSA_2);
  @f_RSA_sign := LoadFunction(fn_RSA_sign);
  @f_RSA_verify := LoadFunction(fn_RSA_verify);
  @f_RSA_sign_ASN1_OCTET_STRING := LoadFunction(fn_RSA_sign_ASN1_OCTET_STRING);
  @f_RSA_verify_ASN1_OCTET_STRING := LoadFunction(fn_RSA_verify_ASN1_OCTET_STRING);
  @f_RSA_blinding_on := LoadFunction(fn_RSA_blinding_on);
  @f_RSA_blinding_off := LoadFunction(fn_RSA_blinding_off);
  @f_RSA_padding_add_PKCS1_type_1 := LoadFunction(fn_RSA_padding_add_PKCS1_type_1);
  @f_RSA_padding_check_PKCS1_type_1 := LoadFunction(fn_RSA_padding_check_PKCS1_type_1);
  @f_RSA_padding_add_PKCS1_type_2 := LoadFunction(fn_RSA_padding_add_PKCS1_type_2);
  @f_RSA_padding_check_PKCS1_type_2 := LoadFunction(fn_RSA_padding_check_PKCS1_type_2);
  @f_RSA_padding_add_PKCS1_OAEP := LoadFunction(fn_RSA_padding_add_PKCS1_OAEP);
  @f_RSA_padding_check_PKCS1_OAEP := LoadFunction(fn_RSA_padding_check_PKCS1_OAEP);
  @f_RSA_padding_add_SSLv23 := LoadFunction(fn_RSA_padding_add_SSLv23);
  @f_RSA_padding_check_SSLv23 := LoadFunction(fn_RSA_padding_check_SSLv23);
  @f_RSA_padding_add_none := LoadFunction(fn_RSA_padding_add_none);
  @f_RSA_padding_check_none := LoadFunction(fn_RSA_padding_check_none);
  @f_RSA_get_ex_new_index := LoadFunction(fn_RSA_get_ex_new_index);
  @f_RSA_set_ex_data := LoadFunction(fn_RSA_set_ex_data);
  @f_RSA_get_ex_data := LoadFunction(fn_RSA_get_ex_data);
  @f_DH_new := LoadFunction(fn_DH_new);
  @f_DH_free := LoadFunction(fn_DH_free);
  @f_DH_size := LoadFunction(fn_DH_size);
  @f_DH_generate_parameters := LoadFunction(fn_DH_generate_parameters);
  @f_DH_check := LoadFunction(fn_DH_check);
  @f_DH_generate_key := LoadFunction(fn_DH_generate_key);
  @f_DH_compute_key := LoadFunction(fn_DH_compute_key);
  @f_d2i_DHparams := LoadFunction(fn_d2i_DHparams);
  @f_i2d_DHparams := LoadFunction(fn_i2d_DHparams);
  @f_DHparams_print_fp := LoadFunction(fn_DHparams_print_fp);
  @f_DHparams_print := LoadFunction(fn_DHparams_print);
  @f_ERR_load_DH_strings := LoadFunction(fn_ERR_load_DH_strings);
  @f_DSA_SIG_new := LoadFunction(fn_DSA_SIG_new);
  @f_DSA_SIG_free := LoadFunction(fn_DSA_SIG_free);
  @f_i2d_DSA_SIG := LoadFunction(fn_i2d_DSA_SIG);
  @f_d2i_DSA_SIG := LoadFunction(fn_d2i_DSA_SIG);
  @f_DSA_do_sign := LoadFunction(fn_DSA_do_sign);
  @f_DSA_do_verify := LoadFunction(fn_DSA_do_verify);
  @f_DSA_new := LoadFunction(fn_DSA_new);
  @f_DSA_size := LoadFunction(fn_DSA_size);
  @f_DSA_sign_setup := LoadFunction(fn_DSA_sign_setup);
  @f_DSA_sign := LoadFunction(fn_DSA_sign);
  @f_DSA_verify := LoadFunction(fn_DSA_verify);
  @f_DSA_free := LoadFunction(fn_DSA_free);
  @f_ERR_load_DSA_strings := LoadFunction(fn_ERR_load_DSA_strings);
  @f_d2i_DSAPublicKey := LoadFunction(fn_d2i_DSAPublicKey);
  @f_d2i_DSAPrivateKey := LoadFunction(fn_d2i_DSAPrivateKey);
  @f_d2i_DSAparams := LoadFunction(fn_d2i_DSAparams);
  @f_DSA_generate_parameters := LoadFunction(fn_DSA_generate_parameters);
  @f_DSA_generate_key := LoadFunction(fn_DSA_generate_key);
  @f_i2d_DSAPublicKey := LoadFunction(fn_i2d_DSAPublicKey);
  @f_i2d_DSAPrivateKey := LoadFunction(fn_i2d_DSAPrivateKey);
  @f_i2d_DSAparams := LoadFunction(fn_i2d_DSAparams);
  @f_DSAparams_print := LoadFunction(fn_DSAparams_print);
  @f_DSA_print := LoadFunction(fn_DSA_print);
  @f_DSAparams_print_fp := LoadFunction(fn_DSAparams_print_fp);
  @f_DSA_print_fp := LoadFunction(fn_DSA_print_fp);
  @f_DSA_is_prime := LoadFunction(fn_DSA_is_prime);
  @f_DSA_dup_DH := LoadFunction(fn_DSA_dup_DH);
  @f_sk_ASN1_TYPE_new := LoadFunction(fn_sk_ASN1_TYPE_new);
  @f_sk_ASN1_TYPE_new_null := LoadFunction(fn_sk_ASN1_TYPE_new_null);
  @f_sk_ASN1_TYPE_free := LoadFunction(fn_sk_ASN1_TYPE_free);
  @f_sk_ASN1_TYPE_num := LoadFunction(fn_sk_ASN1_TYPE_num);
  @f_sk_ASN1_TYPE_value := LoadFunction(fn_sk_ASN1_TYPE_value);
  @f_sk_ASN1_TYPE_set := LoadFunction(fn_sk_ASN1_TYPE_set);
  @f_sk_ASN1_TYPE_zero := LoadFunction(fn_sk_ASN1_TYPE_zero);
  @f_sk_ASN1_TYPE_push := LoadFunction(fn_sk_ASN1_TYPE_push);
  @f_sk_ASN1_TYPE_unshift := LoadFunction(fn_sk_ASN1_TYPE_unshift);
  @f_sk_ASN1_TYPE_find := LoadFunction(fn_sk_ASN1_TYPE_find);
  @f_sk_ASN1_TYPE_delete := LoadFunction(fn_sk_ASN1_TYPE_delete);
  @f_sk_ASN1_TYPE_delete_ptr := LoadFunction(fn_sk_ASN1_TYPE_delete_ptr);
  @f_sk_ASN1_TYPE_insert := LoadFunction(fn_sk_ASN1_TYPE_insert);
  @f_sk_ASN1_TYPE_dup := LoadFunction(fn_sk_ASN1_TYPE_dup);
  @f_sk_ASN1_TYPE_pop_free := LoadFunction(fn_sk_ASN1_TYPE_pop_free);
  @f_sk_ASN1_TYPE_shift := LoadFunction(fn_sk_ASN1_TYPE_shift);
  @f_sk_ASN1_TYPE_pop := LoadFunction(fn_sk_ASN1_TYPE_pop);
  @f_sk_ASN1_TYPE_sort := LoadFunction(fn_sk_ASN1_TYPE_sort);
  @f_i2d_ASN1_SET_OF_ASN1_TYPE := LoadFunction(fn_i2d_ASN1_SET_OF_ASN1_TYPE);
  @f_d2i_ASN1_SET_OF_ASN1_TYPE := LoadFunction(fn_d2i_ASN1_SET_OF_ASN1_TYPE);
  @f_ASN1_TYPE_new := LoadFunction(fn_ASN1_TYPE_new);
  @f_ASN1_TYPE_free := LoadFunction(fn_ASN1_TYPE_free);
  @f_i2d_ASN1_TYPE := LoadFunction(fn_i2d_ASN1_TYPE);
  @f_d2i_ASN1_TYPE := LoadFunction(fn_d2i_ASN1_TYPE);
  @f_ASN1_TYPE_get := LoadFunction(fn_ASN1_TYPE_get);
  @f_ASN1_TYPE_set := LoadFunction(fn_ASN1_TYPE_set);
  @f_ASN1_OBJECT_new := LoadFunction(fn_ASN1_OBJECT_new);
  @f_ASN1_OBJECT_free := LoadFunction(fn_ASN1_OBJECT_free);
  @f_i2d_ASN1_OBJECT := LoadFunction(fn_i2d_ASN1_OBJECT);
  @f_d2i_ASN1_OBJECT := LoadFunction(fn_d2i_ASN1_OBJECT);
  @f_sk_ASN1_OBJECT_new := LoadFunction(fn_sk_ASN1_OBJECT_new);
  @f_sk_ASN1_OBJECT_new_null := LoadFunction(fn_sk_ASN1_OBJECT_new_null);
  @f_sk_ASN1_OBJECT_free := LoadFunction(fn_sk_ASN1_OBJECT_free);
  @f_sk_ASN1_OBJECT_num := LoadFunction(fn_sk_ASN1_OBJECT_num);
  @f_sk_ASN1_OBJECT_value := LoadFunction(fn_sk_ASN1_OBJECT_value);
  @f_sk_ASN1_OBJECT_set := LoadFunction(fn_sk_ASN1_OBJECT_set);
  @f_sk_ASN1_OBJECT_zero := LoadFunction(fn_sk_ASN1_OBJECT_zero);
  @f_sk_ASN1_OBJECT_push := LoadFunction(fn_sk_ASN1_OBJECT_push);
  @f_sk_ASN1_OBJECT_unshift := LoadFunction(fn_sk_ASN1_OBJECT_unshift);
  @f_sk_ASN1_OBJECT_find := LoadFunction(fn_sk_ASN1_OBJECT_find);
  @f_sk_ASN1_OBJECT_delete := LoadFunction(fn_sk_ASN1_OBJECT_delete);
  @f_sk_ASN1_OBJECT_delete_ptr := LoadFunction(fn_sk_ASN1_OBJECT_delete_ptr);
  @f_sk_ASN1_OBJECT_insert := LoadFunction(fn_sk_ASN1_OBJECT_insert);
  @f_sk_ASN1_OBJECT_dup := LoadFunction(fn_sk_ASN1_OBJECT_dup);
  @f_sk_ASN1_OBJECT_pop_free := LoadFunction(fn_sk_ASN1_OBJECT_pop_free);
  @f_sk_ASN1_OBJECT_shift := LoadFunction(fn_sk_ASN1_OBJECT_shift);
  @f_sk_ASN1_OBJECT_pop := LoadFunction(fn_sk_ASN1_OBJECT_pop);
  @f_sk_ASN1_OBJECT_sort := LoadFunction(fn_sk_ASN1_OBJECT_sort);
  @f_i2d_ASN1_SET_OF_ASN1_OBJECT := LoadFunction(fn_i2d_ASN1_SET_OF_ASN1_OBJECT);
  @f_d2i_ASN1_SET_OF_ASN1_OBJECT := LoadFunction(fn_d2i_ASN1_SET_OF_ASN1_OBJECT);
  @f_ASN1_STRING_new := LoadFunction(fn_ASN1_STRING_new);
  @f_ASN1_STRING_free := LoadFunction(fn_ASN1_STRING_free);
  @f_ASN1_STRING_dup := LoadFunction(fn_ASN1_STRING_dup);
  @f_ASN1_STRING_type_new := LoadFunction(fn_ASN1_STRING_type_new);
  @f_ASN1_STRING_cmp := LoadFunction(fn_ASN1_STRING_cmp);
  @f_ASN1_STRING_set := LoadFunction(fn_ASN1_STRING_set);
  @f_i2d_ASN1_BIT_STRING := LoadFunction(fn_i2d_ASN1_BIT_STRING);
  @f_d2i_ASN1_BIT_STRING := LoadFunction(fn_d2i_ASN1_BIT_STRING);
  @f_ASN1_BIT_STRING_set_bit := LoadFunction(fn_ASN1_BIT_STRING_set_bit);
  @f_ASN1_BIT_STRING_get_bit := LoadFunction(fn_ASN1_BIT_STRING_get_bit);
  @f_i2d_ASN1_BOOLEAN := LoadFunction(fn_i2d_ASN1_BOOLEAN);
  @f_d2i_ASN1_BOOLEAN := LoadFunction(fn_d2i_ASN1_BOOLEAN);
  @f_i2d_ASN1_INTEGER := LoadFunction(fn_i2d_ASN1_INTEGER);
  @f_d2i_ASN1_INTEGER := LoadFunction(fn_d2i_ASN1_INTEGER);
  @f_d2i_ASN1_UINTEGER := LoadFunction(fn_d2i_ASN1_UINTEGER);
  @f_i2d_ASN1_ENUMERATED := LoadFunction(fn_i2d_ASN1_ENUMERATED);
  @f_d2i_ASN1_ENUMERATED := LoadFunction(fn_d2i_ASN1_ENUMERATED);
  @f_ASN1_UTCTIME_check := LoadFunction(fn_ASN1_UTCTIME_check);
  @f_ASN1_UTCTIME_set := LoadFunction(fn_ASN1_UTCTIME_set);
  @f_ASN1_UTCTIME_set_string := LoadFunction(fn_ASN1_UTCTIME_set_string);
  @f_ASN1_GENERALIZEDTIME_check := LoadFunction(fn_ASN1_GENERALIZEDTIME_check);
  @f_ASN1_GENERALIZEDTIME_set := LoadFunction(fn_ASN1_GENERALIZEDTIME_set);
  @f_ASN1_GENERALIZEDTIME_set_string := LoadFunction(fn_ASN1_GENERALIZEDTIME_set_string);
  @f_i2d_ASN1_OCTET_STRING := LoadFunction(fn_i2d_ASN1_OCTET_STRING);
  @f_d2i_ASN1_OCTET_STRING := LoadFunction(fn_d2i_ASN1_OCTET_STRING);
  @f_i2d_ASN1_VISIBLESTRING := LoadFunction(fn_i2d_ASN1_VISIBLESTRING);
  @f_d2i_ASN1_VISIBLESTRING := LoadFunction(fn_d2i_ASN1_VISIBLESTRING);
  @f_i2d_ASN1_UTF8STRING := LoadFunction(fn_i2d_ASN1_UTF8STRING);
  @f_d2i_ASN1_UTF8STRING := LoadFunction(fn_d2i_ASN1_UTF8STRING);
  @f_i2d_ASN1_BMPSTRING := LoadFunction(fn_i2d_ASN1_BMPSTRING);
  @f_d2i_ASN1_BMPSTRING := LoadFunction(fn_d2i_ASN1_BMPSTRING);
  @f_i2d_ASN1_PRINTABLE := LoadFunction(fn_i2d_ASN1_PRINTABLE);
  @f_d2i_ASN1_PRINTABLE := LoadFunction(fn_d2i_ASN1_PRINTABLE);
  @f_d2i_ASN1_PRINTABLESTRING := LoadFunction(fn_d2i_ASN1_PRINTABLESTRING);
  @f_i2d_DIRECTORYSTRING := LoadFunction(fn_i2d_DIRECTORYSTRING);
  @f_d2i_DIRECTORYSTRING := LoadFunction(fn_d2i_DIRECTORYSTRING);
  @f_i2d_DISPLAYTEXT := LoadFunction(fn_i2d_DISPLAYTEXT);
  @f_d2i_DISPLAYTEXT := LoadFunction(fn_d2i_DISPLAYTEXT);
  @f_d2i_ASN1_T61STRING := LoadFunction(fn_d2i_ASN1_T61STRING);
  @f_i2d_ASN1_IA5STRING := LoadFunction(fn_i2d_ASN1_IA5STRING);
  @f_d2i_ASN1_IA5STRING := LoadFunction(fn_d2i_ASN1_IA5STRING);
  @f_i2d_ASN1_UTCTIME := LoadFunction(fn_i2d_ASN1_UTCTIME);
  @f_d2i_ASN1_UTCTIME := LoadFunction(fn_d2i_ASN1_UTCTIME);
  @f_i2d_ASN1_GENERALIZEDTIME := LoadFunction(fn_i2d_ASN1_GENERALIZEDTIME);
  @f_d2i_ASN1_GENERALIZEDTIME := LoadFunction(fn_d2i_ASN1_GENERALIZEDTIME);
  @f_i2d_ASN1_TIME := LoadFunction(fn_i2d_ASN1_TIME);
  @f_d2i_ASN1_TIME := LoadFunction(fn_d2i_ASN1_TIME);
  @f_ASN1_TIME_set := LoadFunction(fn_ASN1_TIME_set);
  @f_i2d_ASN1_SET := LoadFunction(fn_i2d_ASN1_SET);
  @f_d2i_ASN1_SET := LoadFunction(fn_d2i_ASN1_SET);
  @f_i2a_ASN1_INTEGER := LoadFunction(fn_i2a_ASN1_INTEGER);
  @f_a2i_ASN1_INTEGER := LoadFunction(fn_a2i_ASN1_INTEGER);
  @f_i2a_ASN1_ENUMERATED := LoadFunction(fn_i2a_ASN1_ENUMERATED);
  @f_a2i_ASN1_ENUMERATED := LoadFunction(fn_a2i_ASN1_ENUMERATED);
  @f_i2a_ASN1_OBJECT := LoadFunction(fn_i2a_ASN1_OBJECT);
  @f_a2i_ASN1_STRING := LoadFunction(fn_a2i_ASN1_STRING);
  @f_i2a_ASN1_STRING := LoadFunction(fn_i2a_ASN1_STRING);
  @f_i2t_ASN1_OBJECT := LoadFunction(fn_i2t_ASN1_OBJECT);
  @f_a2d_ASN1_OBJECT := LoadFunction(fn_a2d_ASN1_OBJECT);
  @f_ASN1_OBJECT_create := LoadFunction(fn_ASN1_OBJECT_create);
  @f_ASN1_INTEGER_set := LoadFunction(fn_ASN1_INTEGER_set);
  @f_ASN1_INTEGER_get := LoadFunction(fn_ASN1_INTEGER_get);
  @f_BN_to_ASN1_INTEGER := LoadFunction(fn_BN_to_ASN1_INTEGER);
  @f_ASN1_INTEGER_to_BN := LoadFunction(fn_ASN1_INTEGER_to_BN);
  @f_ASN1_ENUMERATED_set := LoadFunction(fn_ASN1_ENUMERATED_set);
  @f_ASN1_ENUMERATED_get := LoadFunction(fn_ASN1_ENUMERATED_get);
  @f_BN_to_ASN1_ENUMERATED := LoadFunction(fn_BN_to_ASN1_ENUMERATED);
  @f_ASN1_ENUMERATED_to_BN := LoadFunction(fn_ASN1_ENUMERATED_to_BN);
  @f_ASN1_PRINTABLE_type := LoadFunction(fn_ASN1_PRINTABLE_type);
  @f_i2d_ASN1_bytes := LoadFunction(fn_i2d_ASN1_bytes);
  @f_d2i_ASN1_bytes := LoadFunction(fn_d2i_ASN1_bytes);
  @f_d2i_ASN1_type_bytes := LoadFunction(fn_d2i_ASN1_type_bytes);
  @f_asn1_Finish := LoadFunction(fn_asn1_Finish);
  @f_ASN1_get_object := LoadFunction(fn_ASN1_get_object);
  @f_ASN1_check_infinite_end := LoadFunction(fn_ASN1_check_infinite_end);
  @f_ASN1_put_object := LoadFunction(fn_ASN1_put_object);
  @f_ASN1_object_size := LoadFunction(fn_ASN1_object_size);
  @f_ASN1_dup := LoadFunction(fn_ASN1_dup);
  @f_ASN1_d2i_fp := LoadFunction(fn_ASN1_d2i_fp);
  @f_ASN1_i2d_fp := LoadFunction(fn_ASN1_i2d_fp);
  @f_ASN1_d2i_bio := LoadFunction(fn_ASN1_d2i_bio);
  @f_ASN1_i2d_bio := LoadFunction(fn_ASN1_i2d_bio);
  @f_ASN1_UTCTIME_print := LoadFunction(fn_ASN1_UTCTIME_print);
  @f_ASN1_GENERALIZEDTIME_print := LoadFunction(fn_ASN1_GENERALIZEDTIME_print);
  @f_ASN1_TIME_print := LoadFunction(fn_ASN1_TIME_print);
  @f_ASN1_STRING_print := LoadFunction(fn_ASN1_STRING_print);
  @f_ASN1_parse := LoadFunction(fn_ASN1_parse);
  @f_i2d_ASN1_HEADER := LoadFunction(fn_i2d_ASN1_HEADER);
  @f_d2i_ASN1_HEADER := LoadFunction(fn_d2i_ASN1_HEADER);
  @f_ASN1_HEADER_new := LoadFunction(fn_ASN1_HEADER_new);
  @f_ASN1_HEADER_free := LoadFunction(fn_ASN1_HEADER_free);
  @f_ASN1_UNIVERSALSTRING_to_string := LoadFunction(fn_ASN1_UNIVERSALSTRING_to_string);
  @f_ERR_load_ASN1_strings := LoadFunction(fn_ERR_load_ASN1_strings);
  @f_X509_asn1_meth := LoadFunction(fn_X509_asn1_meth);
  @f_RSAPrivateKey_asn1_meth := LoadFunction(fn_RSAPrivateKey_asn1_meth);
  @f_ASN1_IA5STRING_asn1_meth := LoadFunction(fn_ASN1_IA5STRING_asn1_meth);
  @f_ASN1_BIT_STRING_asn1_meth := LoadFunction(fn_ASN1_BIT_STRING_asn1_meth);
  @f_ASN1_TYPE_set_octetstring := LoadFunction(fn_ASN1_TYPE_set_octetstring);
  @f_ASN1_TYPE_get_octetstring := LoadFunction(fn_ASN1_TYPE_get_octetstring);
  @f_ASN1_TYPE_set_int_octetstring := LoadFunction(fn_ASN1_TYPE_set_int_octetstring);
  @f_ASN1_TYPE_get_int_octetstring := LoadFunction(fn_ASN1_TYPE_get_int_octetstring);
  @f_ASN1_seq_unpack := LoadFunction(fn_ASN1_seq_unpack);
  @f_ASN1_seq_pack := LoadFunction(fn_ASN1_seq_pack);
  @f_ASN1_unpack_string := LoadFunction(fn_ASN1_unpack_string);
  @f_ASN1_pack_string := LoadFunction(fn_ASN1_pack_string);
  @f_OBJ_NAME_init := LoadFunction(fn_OBJ_NAME_init);
  @f_OBJ_NAME_new_index := LoadFunction(fn_OBJ_NAME_new_index);
  @f_OBJ_NAME_get := LoadFunction(fn_OBJ_NAME_get);
  @f_OBJ_NAME_add := LoadFunction(fn_OBJ_NAME_add);
  @f_OBJ_NAME_remove := LoadFunction(fn_OBJ_NAME_remove);
  @f_OBJ_NAME_cleanup := LoadFunction(fn_OBJ_NAME_cleanup);
  @f_OBJ_dup := LoadFunction(fn_OBJ_dup);
  @f_OBJ_nid2obj := LoadFunction(fn_OBJ_nid2obj);
  @f_OBJ_nid2ln := LoadFunction(fn_OBJ_nid2ln);
  @f_OBJ_nid2sn := LoadFunction(fn_OBJ_nid2sn);
  @f_OBJ_obj2nid := LoadFunction(fn_OBJ_obj2nid);
  @f_OBJ_txt2obj := LoadFunction(fn_OBJ_txt2obj);
  @f_OBJ_obj2txt := LoadFunction(fn_OBJ_obj2txt);
  @f_OBJ_txt2nid := LoadFunction(fn_OBJ_txt2nid);
  @f_OBJ_ln2nid := LoadFunction(fn_OBJ_ln2nid);
  @f_OBJ_sn2nid := LoadFunction(fn_OBJ_sn2nid);
  @f_OBJ_cmp := LoadFunction(fn_OBJ_cmp);
  @f_OBJ_bsearch := LoadFunction(fn_OBJ_bsearch);
  @f_ERR_load_OBJ_strings := LoadFunction(fn_ERR_load_OBJ_strings);
  @f_OBJ_new_nid := LoadFunction(fn_OBJ_new_nid);
  @f_OBJ_add_object := LoadFunction(fn_OBJ_add_object);
  @f_OBJ_create := LoadFunction(fn_OBJ_create);
  @f_OBJ_cleanup := LoadFunction(fn_OBJ_cleanup);
  @f_OBJ_create_objects := LoadFunction(fn_OBJ_create_objects);
  @f_EVP_MD_CTX_copy := LoadFunction(fn_EVP_MD_CTX_copy);
  @f_EVP_DigestInit := LoadFunction(fn_EVP_DigestInit);
  @f_EVP_DigestUpdate := LoadFunction(fn_EVP_DigestUpdate);
  @f_EVP_DigestFinal := LoadFunction(fn_EVP_DigestFinal);
  @f_EVP_read_pw_string := LoadFunction(fn_EVP_read_pw_string);
  @f_EVP_set_pw_prompt := LoadFunction(fn_EVP_set_pw_prompt);
  @f_EVP_get_pw_prompt := LoadFunction(fn_EVP_get_pw_prompt);
  @f_EVP_BytesToKey := LoadFunction(fn_EVP_BytesToKey);
  @f_EVP_EncryptInit := LoadFunction(fn_EVP_EncryptInit);
  @f_EVP_EncryptUpdate := LoadFunction(fn_EVP_EncryptUpdate);
  @f_EVP_EncryptFinal := LoadFunction(fn_EVP_EncryptFinal);
  @f_EVP_DecryptInit := LoadFunction(fn_EVP_DecryptInit);
  @f_EVP_DecryptUpdate := LoadFunction(fn_EVP_DecryptUpdate);
  @f_EVP_DecryptFinal := LoadFunction(fn_EVP_DecryptFinal);
  @f_EVP_CipherInit := LoadFunction(fn_EVP_CipherInit);
  @f_EVP_CipherUpdate := LoadFunction(fn_EVP_CipherUpdate);
  @f_EVP_CipherFinal := LoadFunction(fn_EVP_CipherFinal);
  @f_EVP_SignFinal := LoadFunction(fn_EVP_SignFinal);
  @f_EVP_VerifyFinal := LoadFunction(fn_EVP_VerifyFinal);
  @f_EVP_OpenInit := LoadFunction(fn_EVP_OpenInit);
  @f_EVP_OpenFinal := LoadFunction(fn_EVP_OpenFinal);
  @f_EVP_SealInit := LoadFunction(fn_EVP_SealInit);
  @f_EVP_SealFinal := LoadFunction(fn_EVP_SealFinal);
  @f_EVP_EncodeInit := LoadFunction(fn_EVP_EncodeInit);
  @f_EVP_EncodeUpdate := LoadFunction(fn_EVP_EncodeUpdate);
  @f_EVP_EncodeFinal := LoadFunction(fn_EVP_EncodeFinal);
  @f_EVP_EncodeBlock := LoadFunction(fn_EVP_EncodeBlock);
  @f_EVP_DecodeInit := LoadFunction(fn_EVP_DecodeInit);
  @f_EVP_DecodeUpdate := LoadFunction(fn_EVP_DecodeUpdate);
  @f_EVP_DecodeFinal := LoadFunction(fn_EVP_DecodeFinal);
  @f_EVP_DecodeBlock := LoadFunction(fn_EVP_DecodeBlock);
  @f_ERR_load_EVP_strings := LoadFunction(fn_ERR_load_EVP_strings);
  @f_EVP_CIPHER_CTX_init := LoadFunction(fn_EVP_CIPHER_CTX_init);
  @f_EVP_CIPHER_CTX_cleanup := LoadFunction(fn_EVP_CIPHER_CTX_cleanup);
  @f_BIO_f_md := LoadFunction(fn_BIO_f_md);
  @f_BIO_f_base64 := LoadFunction(fn_BIO_f_base64);
  @f_BIO_f_cipher := LoadFunction(fn_BIO_f_cipher);
  @f_BIO_f_reliable := LoadFunction(fn_BIO_f_reliable);
  @f_BIO_set_cipher := LoadFunction(fn_BIO_set_cipher);
  @f_EVP_md_null := LoadFunction(fn_EVP_md_null);
  @f_EVP_md2 := LoadFunction(fn_EVP_md2);
  @f_EVP_md5 := LoadFunction(fn_EVP_md5);
  @f_EVP_sha := LoadFunction(fn_EVP_sha);
  @f_EVP_sha1 := LoadFunction(fn_EVP_sha1);
  @f_EVP_dss := LoadFunction(fn_EVP_dss);
  @f_EVP_dss1 := LoadFunction(fn_EVP_dss1);
  @f_EVP_mdc2 := LoadFunction(fn_EVP_mdc2);
  @f_EVP_ripemd160 := LoadFunction(fn_EVP_ripemd160);
  @f_EVP_enc_null := LoadFunction(fn_EVP_enc_null);
  @f_EVP_des_ecb := LoadFunction(fn_EVP_des_ecb);
  @f_EVP_des_ede := LoadFunction(fn_EVP_des_ede);
  @f_EVP_des_ede3 := LoadFunction(fn_EVP_des_ede3);
  @f_EVP_des_cfb := LoadFunction(fn_EVP_des_cfb);
  @f_EVP_des_ede_cfb := LoadFunction(fn_EVP_des_ede_cfb);
  @f_EVP_des_ede3_cfb := LoadFunction(fn_EVP_des_ede3_cfb);
  @f_EVP_des_ofb := LoadFunction(fn_EVP_des_ofb);
  @f_EVP_des_ede_ofb := LoadFunction(fn_EVP_des_ede_ofb);
  @f_EVP_des_ede3_ofb := LoadFunction(fn_EVP_des_ede3_ofb);
  @f_EVP_des_cbc := LoadFunction(fn_EVP_des_cbc);
  @f_EVP_des_ede_cbc := LoadFunction(fn_EVP_des_ede_cbc);
  @f_EVP_des_ede3_cbc := LoadFunction(fn_EVP_des_ede3_cbc);
  @f_EVP_desx_cbc := LoadFunction(fn_EVP_desx_cbc);
  @f_EVP_rc4 := LoadFunction(fn_EVP_rc4);
  @f_EVP_rc4_40 := LoadFunction(fn_EVP_rc4_40);
  @f_EVP_idea_ecb := LoadFunction(fn_EVP_idea_ecb);
  @f_EVP_idea_cfb := LoadFunction(fn_EVP_idea_cfb);
  @f_EVP_idea_ofb := LoadFunction(fn_EVP_idea_ofb);
  @f_EVP_idea_cbc := LoadFunction(fn_EVP_idea_cbc);
  @f_EVP_rc2_ecb := LoadFunction(fn_EVP_rc2_ecb);
  @f_EVP_rc2_cbc := LoadFunction(fn_EVP_rc2_cbc);
  @f_EVP_rc2_40_cbc := LoadFunction(fn_EVP_rc2_40_cbc);
  @f_EVP_rc2_64_cbc := LoadFunction(fn_EVP_rc2_64_cbc);
  @f_EVP_rc2_cfb := LoadFunction(fn_EVP_rc2_cfb);
  @f_EVP_rc2_ofb := LoadFunction(fn_EVP_rc2_ofb);
  @f_EVP_bf_ecb := LoadFunction(fn_EVP_bf_ecb);
  @f_EVP_bf_cbc := LoadFunction(fn_EVP_bf_cbc);
  @f_EVP_bf_cfb := LoadFunction(fn_EVP_bf_cfb);
  @f_EVP_bf_ofb := LoadFunction(fn_EVP_bf_ofb);
  @f_EVP_cast5_ecb := LoadFunction(fn_EVP_cast5_ecb);
  @f_EVP_cast5_cbc := LoadFunction(fn_EVP_cast5_cbc);
  @f_EVP_cast5_cfb := LoadFunction(fn_EVP_cast5_cfb);
  @f_EVP_cast5_ofb := LoadFunction(fn_EVP_cast5_ofb);
  @f_EVP_rc5_32_12_16_cbc := LoadFunction(fn_EVP_rc5_32_12_16_cbc);
  @f_EVP_rc5_32_12_16_ecb := LoadFunction(fn_EVP_rc5_32_12_16_ecb);
  @f_EVP_rc5_32_12_16_cfb := LoadFunction(fn_EVP_rc5_32_12_16_cfb);
  @f_EVP_rc5_32_12_16_ofb := LoadFunction(fn_EVP_rc5_32_12_16_ofb);
  @f_SSLeay_add_all_algorithms := LoadFunction(fn_SSLeay_add_all_algorithms);
  @f_SSLeay_add_all_ciphers := LoadFunction(fn_SSLeay_add_all_ciphers);
  @f_SSLeay_add_all_digests := LoadFunction(fn_SSLeay_add_all_digests);
  @f_EVP_add_cipher := LoadFunction(fn_EVP_add_cipher);
  @f_EVP_add_digest := LoadFunction(fn_EVP_add_digest);
  @f_EVP_get_cipherbyname := LoadFunction(fn_EVP_get_cipherbyname);
  @f_EVP_get_digestbyname := LoadFunction(fn_EVP_get_digestbyname);
  @f_EVP_cleanup := LoadFunction(fn_EVP_cleanup);
  @f_EVP_PKEY_decrypt := LoadFunction(fn_EVP_PKEY_decrypt);
  @f_EVP_PKEY_encrypt := LoadFunction(fn_EVP_PKEY_encrypt);
  @f_EVP_PKEY_type := LoadFunction(fn_EVP_PKEY_type);
  @f_EVP_PKEY_bits := LoadFunction(fn_EVP_PKEY_bits);
  @f_EVP_PKEY_size := LoadFunction(fn_EVP_PKEY_size);
  @f_EVP_PKEY_assign := LoadFunction(fn_EVP_PKEY_assign);
  @f_EVP_PKEY_new := LoadFunction(fn_EVP_PKEY_new);
  @f_EVP_PKEY_free := LoadFunction(fn_EVP_PKEY_free);
  @f_d2i_PublicKey := LoadFunction(fn_d2i_PublicKey);
  @f_i2d_PublicKey := LoadFunction(fn_i2d_PublicKey);
  @f_d2i_PrivateKey := LoadFunction(fn_d2i_PrivateKey);
  @f_i2d_PrivateKey := LoadFunction(fn_i2d_PrivateKey);
  @f_EVP_PKEY_copy_parameters := LoadFunction(fn_EVP_PKEY_copy_parameters);
  @f_EVP_PKEY_missing_parameters := LoadFunction(fn_EVP_PKEY_missing_parameters);
  @f_EVP_PKEY_save_parameters := LoadFunction(fn_EVP_PKEY_save_parameters);
  @f_EVP_PKEY_cmp_parameters := LoadFunction(fn_EVP_PKEY_cmp_parameters);
  @f_EVP_CIPHER_type := LoadFunction(fn_EVP_CIPHER_type);
  @f_EVP_CIPHER_param_to_asn1 := LoadFunction(fn_EVP_CIPHER_param_to_asn1);
  @f_EVP_CIPHER_asn1_to_param := LoadFunction(fn_EVP_CIPHER_asn1_to_param);
  @f_EVP_CIPHER_set_asn1_iv := LoadFunction(fn_EVP_CIPHER_set_asn1_iv);
  @f_EVP_CIPHER_get_asn1_iv := LoadFunction(fn_EVP_CIPHER_get_asn1_iv);
  @f_PKCS5_PBE_keyivgen := LoadFunction(fn_PKCS5_PBE_keyivgen);
  @f_PKCS5_PBKDF2_HMAC_SHA1 := LoadFunction(fn_PKCS5_PBKDF2_HMAC_SHA1);
  @f_PKCS5_v2_PBE_keyivgen := LoadFunction(fn_PKCS5_v2_PBE_keyivgen);
  @f_PKCS5_PBE_add := LoadFunction(fn_PKCS5_PBE_add);
  @f_EVP_PBE_CipherInit := LoadFunction(fn_EVP_PBE_CipherInit);
  @f_EVP_PBE_alg_add := LoadFunction(fn_EVP_PBE_alg_add);
  @f_EVP_PBE_cleanup := LoadFunction(fn_EVP_PBE_cleanup);
  @f_sk_X509_ALGOR_new := LoadFunction(fn_sk_X509_ALGOR_new);
  @f_sk_X509_ALGOR_new_null := LoadFunction(fn_sk_X509_ALGOR_new_null);
  @f_sk_X509_ALGOR_free := LoadFunction(fn_sk_X509_ALGOR_free);
  @f_sk_X509_ALGOR_num := LoadFunction(fn_sk_X509_ALGOR_num);
  @f_sk_X509_ALGOR_value := LoadFunction(fn_sk_X509_ALGOR_value);
  @f_sk_X509_ALGOR_set := LoadFunction(fn_sk_X509_ALGOR_set);
  @f_sk_X509_ALGOR_zero := LoadFunction(fn_sk_X509_ALGOR_zero);
  @f_sk_X509_ALGOR_push := LoadFunction(fn_sk_X509_ALGOR_push);
  @f_sk_X509_ALGOR_unshift := LoadFunction(fn_sk_X509_ALGOR_unshift);
  @f_sk_X509_ALGOR_find := LoadFunction(fn_sk_X509_ALGOR_find);
  @f_sk_X509_ALGOR_delete := LoadFunction(fn_sk_X509_ALGOR_delete);
  @f_sk_X509_ALGOR_delete_ptr := LoadFunction(fn_sk_X509_ALGOR_delete_ptr);
  @f_sk_X509_ALGOR_insert := LoadFunction(fn_sk_X509_ALGOR_insert);
  @f_sk_X509_ALGOR_dup := LoadFunction(fn_sk_X509_ALGOR_dup);
  @f_sk_X509_ALGOR_pop_free := LoadFunction(fn_sk_X509_ALGOR_pop_free);
  @f_sk_X509_ALGOR_shift := LoadFunction(fn_sk_X509_ALGOR_shift);
  @f_sk_X509_ALGOR_pop := LoadFunction(fn_sk_X509_ALGOR_pop);
  @f_sk_X509_ALGOR_sort := LoadFunction(fn_sk_X509_ALGOR_sort);
  @f_i2d_ASN1_SET_OF_X509_ALGOR := LoadFunction(fn_i2d_ASN1_SET_OF_X509_ALGOR);
  @f_d2i_ASN1_SET_OF_X509_ALGOR := LoadFunction(fn_d2i_ASN1_SET_OF_X509_ALGOR);
  @f_sk_X509_NAME_ENTRY_new := LoadFunction(fn_sk_X509_NAME_ENTRY_new);
  @f_sk_X509_NAME_ENTRY_new_null := LoadFunction(fn_sk_X509_NAME_ENTRY_new_null);
  @f_sk_X509_NAME_ENTRY_free := LoadFunction(fn_sk_X509_NAME_ENTRY_free);
  @f_sk_X509_NAME_ENTRY_num := LoadFunction(fn_sk_X509_NAME_ENTRY_num);
  @f_sk_X509_NAME_ENTRY_value := LoadFunction(fn_sk_X509_NAME_ENTRY_value);
  @f_sk_X509_NAME_ENTRY_set := LoadFunction(fn_sk_X509_NAME_ENTRY_set);
  @f_sk_X509_NAME_ENTRY_zero := LoadFunction(fn_sk_X509_NAME_ENTRY_zero);
  @f_sk_X509_NAME_ENTRY_push := LoadFunction(fn_sk_X509_NAME_ENTRY_push);
  @f_sk_X509_NAME_ENTRY_unshift := LoadFunction(fn_sk_X509_NAME_ENTRY_unshift);
  @f_sk_X509_NAME_ENTRY_find := LoadFunction(fn_sk_X509_NAME_ENTRY_find);
  @f_sk_X509_NAME_ENTRY_delete := LoadFunction(fn_sk_X509_NAME_ENTRY_delete);
  @f_sk_X509_NAME_ENTRY_delete_ptr := LoadFunction(fn_sk_X509_NAME_ENTRY_delete_ptr);
  @f_sk_X509_NAME_ENTRY_insert := LoadFunction(fn_sk_X509_NAME_ENTRY_insert);
  @f_sk_X509_NAME_ENTRY_dup := LoadFunction(fn_sk_X509_NAME_ENTRY_dup);
  @f_sk_X509_NAME_ENTRY_pop_free := LoadFunction(fn_sk_X509_NAME_ENTRY_pop_free);
  @f_sk_X509_NAME_ENTRY_shift := LoadFunction(fn_sk_X509_NAME_ENTRY_shift);
  @f_sk_X509_NAME_ENTRY_pop := LoadFunction(fn_sk_X509_NAME_ENTRY_pop);
  @f_sk_X509_NAME_ENTRY_sort := LoadFunction(fn_sk_X509_NAME_ENTRY_sort);
  @f_i2d_ASN1_SET_OF_X509_NAME_ENTRY := LoadFunction(fn_i2d_ASN1_SET_OF_X509_NAME_ENTRY);
  @f_d2i_ASN1_SET_OF_X509_NAME_ENTRY := LoadFunction(fn_d2i_ASN1_SET_OF_X509_NAME_ENTRY);
  @f_sk_X509_NAME_new := LoadFunction(fn_sk_X509_NAME_new);
  @f_sk_X509_NAME_new_null := LoadFunction(fn_sk_X509_NAME_new_null);
  @f_sk_X509_NAME_free := LoadFunction(fn_sk_X509_NAME_free);
  @f_sk_X509_NAME_num := LoadFunction(fn_sk_X509_NAME_num);
  @f_sk_X509_NAME_value := LoadFunction(fn_sk_X509_NAME_value);
  @f_sk_X509_NAME_set := LoadFunction(fn_sk_X509_NAME_set);
  @f_sk_X509_NAME_zero := LoadFunction(fn_sk_X509_NAME_zero);
  @f_sk_X509_NAME_push := LoadFunction(fn_sk_X509_NAME_push);
  @f_sk_X509_NAME_unshift := LoadFunction(fn_sk_X509_NAME_unshift);
  @f_sk_X509_NAME_find := LoadFunction(fn_sk_X509_NAME_find);
  @f_sk_X509_NAME_delete := LoadFunction(fn_sk_X509_NAME_delete);
  @f_sk_X509_NAME_delete_ptr := LoadFunction(fn_sk_X509_NAME_delete_ptr);
  @f_sk_X509_NAME_insert := LoadFunction(fn_sk_X509_NAME_insert);
  @f_sk_X509_NAME_dup := LoadFunction(fn_sk_X509_NAME_dup);
  @f_sk_X509_NAME_pop_free := LoadFunction(fn_sk_X509_NAME_pop_free);
  @f_sk_X509_NAME_shift := LoadFunction(fn_sk_X509_NAME_shift);
  @f_sk_X509_NAME_pop := LoadFunction(fn_sk_X509_NAME_pop);
  @f_sk_X509_NAME_sort := LoadFunction(fn_sk_X509_NAME_sort);
  @f_sk_X509_EXTENSION_new := LoadFunction(fn_sk_X509_EXTENSION_new);
  @f_sk_X509_EXTENSION_new_null := LoadFunction(fn_sk_X509_EXTENSION_new_null);
  @f_sk_X509_EXTENSION_free := LoadFunction(fn_sk_X509_EXTENSION_free);
  @f_sk_X509_EXTENSION_num := LoadFunction(fn_sk_X509_EXTENSION_num);
  @f_sk_X509_EXTENSION_value := LoadFunction(fn_sk_X509_EXTENSION_value);
  @f_sk_X509_EXTENSION_set := LoadFunction(fn_sk_X509_EXTENSION_set);
  @f_sk_X509_EXTENSION_zero := LoadFunction(fn_sk_X509_EXTENSION_zero);
  @f_sk_X509_EXTENSION_push := LoadFunction(fn_sk_X509_EXTENSION_push);
  @f_sk_X509_EXTENSION_unshift := LoadFunction(fn_sk_X509_EXTENSION_unshift);
  @f_sk_X509_EXTENSION_find := LoadFunction(fn_sk_X509_EXTENSION_find);
  @f_sk_X509_EXTENSION_delete := LoadFunction(fn_sk_X509_EXTENSION_delete);
  @f_sk_X509_EXTENSION_delete_ptr := LoadFunction(fn_sk_X509_EXTENSION_delete_ptr);
  @f_sk_X509_EXTENSION_insert := LoadFunction(fn_sk_X509_EXTENSION_insert);
  @f_sk_X509_EXTENSION_dup := LoadFunction(fn_sk_X509_EXTENSION_dup);
  @f_sk_X509_EXTENSION_pop_free := LoadFunction(fn_sk_X509_EXTENSION_pop_free);
  @f_sk_X509_EXTENSION_shift := LoadFunction(fn_sk_X509_EXTENSION_shift);
  @f_sk_X509_EXTENSION_pop := LoadFunction(fn_sk_X509_EXTENSION_pop);
  @f_sk_X509_EXTENSION_sort := LoadFunction(fn_sk_X509_EXTENSION_sort);
  @f_i2d_ASN1_SET_OF_X509_EXTENSION := LoadFunction(fn_i2d_ASN1_SET_OF_X509_EXTENSION);
  @f_d2i_ASN1_SET_OF_X509_EXTENSION := LoadFunction(fn_d2i_ASN1_SET_OF_X509_EXTENSION);
  @f_sk_X509_ATTRIBUTE_new := LoadFunction(fn_sk_X509_ATTRIBUTE_new);
  @f_sk_X509_ATTRIBUTE_new_null := LoadFunction(fn_sk_X509_ATTRIBUTE_new_null);
  @f_sk_X509_ATTRIBUTE_free := LoadFunction(fn_sk_X509_ATTRIBUTE_free);
  @f_sk_X509_ATTRIBUTE_num := LoadFunction(fn_sk_X509_ATTRIBUTE_num);
  @f_sk_X509_ATTRIBUTE_value := LoadFunction(fn_sk_X509_ATTRIBUTE_value);
  @f_sk_X509_ATTRIBUTE_set := LoadFunction(fn_sk_X509_ATTRIBUTE_set);
  @f_sk_X509_ATTRIBUTE_zero := LoadFunction(fn_sk_X509_ATTRIBUTE_zero);
  @f_sk_X509_ATTRIBUTE_push := LoadFunction(fn_sk_X509_ATTRIBUTE_push);
  @f_sk_X509_ATTRIBUTE_unshift := LoadFunction(fn_sk_X509_ATTRIBUTE_unshift);
  @f_sk_X509_ATTRIBUTE_find := LoadFunction(fn_sk_X509_ATTRIBUTE_find);
  @f_sk_X509_ATTRIBUTE_delete := LoadFunction(fn_sk_X509_ATTRIBUTE_delete);
  @f_sk_X509_ATTRIBUTE_delete_ptr := LoadFunction(fn_sk_X509_ATTRIBUTE_delete_ptr);
  @f_sk_X509_ATTRIBUTE_insert := LoadFunction(fn_sk_X509_ATTRIBUTE_insert);
  @f_sk_X509_ATTRIBUTE_dup := LoadFunction(fn_sk_X509_ATTRIBUTE_dup);
  @f_sk_X509_ATTRIBUTE_pop_free := LoadFunction(fn_sk_X509_ATTRIBUTE_pop_free);
  @f_sk_X509_ATTRIBUTE_shift := LoadFunction(fn_sk_X509_ATTRIBUTE_shift);
  @f_sk_X509_ATTRIBUTE_pop := LoadFunction(fn_sk_X509_ATTRIBUTE_pop);
  @f_sk_X509_ATTRIBUTE_sort := LoadFunction(fn_sk_X509_ATTRIBUTE_sort);
  @f_i2d_ASN1_SET_OF_X509_ATTRIBUTE := LoadFunction(fn_i2d_ASN1_SET_OF_X509_ATTRIBUTE);
  @f_d2i_ASN1_SET_OF_X509_ATTRIBUTE := LoadFunction(fn_d2i_ASN1_SET_OF_X509_ATTRIBUTE);
  @f_sk_X509_new := LoadFunction(fn_sk_X509_new);
  @f_sk_X509_new_null := LoadFunction(fn_sk_X509_new_null);
  @f_sk_X509_free := LoadFunction(fn_sk_X509_free);
  @f_sk_X509_num := LoadFunction(fn_sk_X509_num);
  @f_sk_X509_value := LoadFunction(fn_sk_X509_value);
  @f_sk_X509_set := LoadFunction(fn_sk_X509_set);
  @f_sk_X509_zero := LoadFunction(fn_sk_X509_zero);
  @f_sk_X509_push := LoadFunction(fn_sk_X509_push);
  @f_sk_X509_unshift := LoadFunction(fn_sk_X509_unshift);
  @f_sk_X509_find := LoadFunction(fn_sk_X509_find);
  @f_sk_X509_delete := LoadFunction(fn_sk_X509_delete);
  @f_sk_X509_delete_ptr := LoadFunction(fn_sk_X509_delete_ptr);
  @f_sk_X509_insert := LoadFunction(fn_sk_X509_insert);
  @f_sk_X509_dup := LoadFunction(fn_sk_X509_dup);
  @f_sk_X509_pop_free := LoadFunction(fn_sk_X509_pop_free);
  @f_sk_X509_shift := LoadFunction(fn_sk_X509_shift);
  @f_sk_X509_pop := LoadFunction(fn_sk_X509_pop);
  @f_sk_X509_sort := LoadFunction(fn_sk_X509_sort);
  @f_i2d_ASN1_SET_OF_X509 := LoadFunction(fn_i2d_ASN1_SET_OF_X509);
  @f_d2i_ASN1_SET_OF_X509 := LoadFunction(fn_d2i_ASN1_SET_OF_X509);
  @f_sk_X509_REVOKED_new := LoadFunction(fn_sk_X509_REVOKED_new);
  @f_sk_X509_REVOKED_new_null := LoadFunction(fn_sk_X509_REVOKED_new_null);
  @f_sk_X509_REVOKED_free := LoadFunction(fn_sk_X509_REVOKED_free);
  @f_sk_X509_REVOKED_num := LoadFunction(fn_sk_X509_REVOKED_num);
  @f_sk_X509_REVOKED_value := LoadFunction(fn_sk_X509_REVOKED_value);
  @f_sk_X509_REVOKED_set := LoadFunction(fn_sk_X509_REVOKED_set);
  @f_sk_X509_REVOKED_zero := LoadFunction(fn_sk_X509_REVOKED_zero);
  @f_sk_X509_REVOKED_push := LoadFunction(fn_sk_X509_REVOKED_push);
  @f_sk_X509_REVOKED_unshift := LoadFunction(fn_sk_X509_REVOKED_unshift);
  @f_sk_X509_REVOKED_find := LoadFunction(fn_sk_X509_REVOKED_find);
  @f_sk_X509_REVOKED_delete := LoadFunction(fn_sk_X509_REVOKED_delete);
  @f_sk_X509_REVOKED_delete_ptr := LoadFunction(fn_sk_X509_REVOKED_delete_ptr);
  @f_sk_X509_REVOKED_insert := LoadFunction(fn_sk_X509_REVOKED_insert);
  @f_sk_X509_REVOKED_dup := LoadFunction(fn_sk_X509_REVOKED_dup);
  @f_sk_X509_REVOKED_pop_free := LoadFunction(fn_sk_X509_REVOKED_pop_free);
  @f_sk_X509_REVOKED_shift := LoadFunction(fn_sk_X509_REVOKED_shift);
  @f_sk_X509_REVOKED_pop := LoadFunction(fn_sk_X509_REVOKED_pop);
  @f_sk_X509_REVOKED_sort := LoadFunction(fn_sk_X509_REVOKED_sort);
  @f_i2d_ASN1_SET_OF_X509_REVOKED := LoadFunction(fn_i2d_ASN1_SET_OF_X509_REVOKED);
  @f_d2i_ASN1_SET_OF_X509_REVOKED := LoadFunction(fn_d2i_ASN1_SET_OF_X509_REVOKED);
  @f_sk_X509_CRL_new := LoadFunction(fn_sk_X509_CRL_new);
  @f_sk_X509_CRL_new_null := LoadFunction(fn_sk_X509_CRL_new_null);
  @f_sk_X509_CRL_free := LoadFunction(fn_sk_X509_CRL_free);
  @f_sk_X509_CRL_num := LoadFunction(fn_sk_X509_CRL_num);
  @f_sk_X509_CRL_value := LoadFunction(fn_sk_X509_CRL_value);
  @f_sk_X509_CRL_set := LoadFunction(fn_sk_X509_CRL_set);
  @f_sk_X509_CRL_zero := LoadFunction(fn_sk_X509_CRL_zero);
  @f_sk_X509_CRL_push := LoadFunction(fn_sk_X509_CRL_push);
  @f_sk_X509_CRL_unshift := LoadFunction(fn_sk_X509_CRL_unshift);
  @f_sk_X509_CRL_find := LoadFunction(fn_sk_X509_CRL_find);
  @f_sk_X509_CRL_delete := LoadFunction(fn_sk_X509_CRL_delete);
  @f_sk_X509_CRL_delete_ptr := LoadFunction(fn_sk_X509_CRL_delete_ptr);
  @f_sk_X509_CRL_insert := LoadFunction(fn_sk_X509_CRL_insert);
  @f_sk_X509_CRL_dup := LoadFunction(fn_sk_X509_CRL_dup);
  @f_sk_X509_CRL_pop_free := LoadFunction(fn_sk_X509_CRL_pop_free);
  @f_sk_X509_CRL_shift := LoadFunction(fn_sk_X509_CRL_shift);
  @f_sk_X509_CRL_pop := LoadFunction(fn_sk_X509_CRL_pop);
  @f_sk_X509_CRL_sort := LoadFunction(fn_sk_X509_CRL_sort);
  @f_i2d_ASN1_SET_OF_X509_CRL := LoadFunction(fn_i2d_ASN1_SET_OF_X509_CRL);
  @f_d2i_ASN1_SET_OF_X509_CRL := LoadFunction(fn_d2i_ASN1_SET_OF_X509_CRL);
  @f_sk_X509_INFO_new := LoadFunction(fn_sk_X509_INFO_new);
  @f_sk_X509_INFO_new_null := LoadFunction(fn_sk_X509_INFO_new_null);
  @f_sk_X509_INFO_free := LoadFunction(fn_sk_X509_INFO_free);
  @f_sk_X509_INFO_num := LoadFunction(fn_sk_X509_INFO_num);
  @f_sk_X509_INFO_value := LoadFunction(fn_sk_X509_INFO_value);
  @f_sk_X509_INFO_set := LoadFunction(fn_sk_X509_INFO_set);
  @f_sk_X509_INFO_zero := LoadFunction(fn_sk_X509_INFO_zero);
  @f_sk_X509_INFO_push := LoadFunction(fn_sk_X509_INFO_push);
  @f_sk_X509_INFO_unshift := LoadFunction(fn_sk_X509_INFO_unshift);
  @f_sk_X509_INFO_find := LoadFunction(fn_sk_X509_INFO_find);
  @f_sk_X509_INFO_delete := LoadFunction(fn_sk_X509_INFO_delete);
  @f_sk_X509_INFO_delete_ptr := LoadFunction(fn_sk_X509_INFO_delete_ptr);
  @f_sk_X509_INFO_insert := LoadFunction(fn_sk_X509_INFO_insert);
  @f_sk_X509_INFO_dup := LoadFunction(fn_sk_X509_INFO_dup);
  @f_sk_X509_INFO_pop_free := LoadFunction(fn_sk_X509_INFO_pop_free);
  @f_sk_X509_INFO_shift := LoadFunction(fn_sk_X509_INFO_shift);
  @f_sk_X509_INFO_pop := LoadFunction(fn_sk_X509_INFO_pop);
  @f_sk_X509_INFO_sort := LoadFunction(fn_sk_X509_INFO_sort);
  @f_sk_X509_LOOKUP_new := LoadFunction(fn_sk_X509_LOOKUP_new);
  @f_sk_X509_LOOKUP_new_null := LoadFunction(fn_sk_X509_LOOKUP_new_null);
  @f_sk_X509_LOOKUP_free := LoadFunction(fn_sk_X509_LOOKUP_free);
  @f_sk_X509_LOOKUP_num := LoadFunction(fn_sk_X509_LOOKUP_num);
  @f_sk_X509_LOOKUP_value := LoadFunction(fn_sk_X509_LOOKUP_value);
  @f_sk_X509_LOOKUP_set := LoadFunction(fn_sk_X509_LOOKUP_set);
  @f_sk_X509_LOOKUP_zero := LoadFunction(fn_sk_X509_LOOKUP_zero);
  @f_sk_X509_LOOKUP_push := LoadFunction(fn_sk_X509_LOOKUP_push);
  @f_sk_X509_LOOKUP_unshift := LoadFunction(fn_sk_X509_LOOKUP_unshift);
  @f_sk_X509_LOOKUP_find := LoadFunction(fn_sk_X509_LOOKUP_find);
  @f_sk_X509_LOOKUP_delete := LoadFunction(fn_sk_X509_LOOKUP_delete);
  @f_sk_X509_LOOKUP_delete_ptr := LoadFunction(fn_sk_X509_LOOKUP_delete_ptr);
  @f_sk_X509_LOOKUP_insert := LoadFunction(fn_sk_X509_LOOKUP_insert);
  @f_sk_X509_LOOKUP_dup := LoadFunction(fn_sk_X509_LOOKUP_dup);
  @f_sk_X509_LOOKUP_pop_free := LoadFunction(fn_sk_X509_LOOKUP_pop_free);
  @f_sk_X509_LOOKUP_shift := LoadFunction(fn_sk_X509_LOOKUP_shift);
  @f_sk_X509_LOOKUP_pop := LoadFunction(fn_sk_X509_LOOKUP_pop);
  @f_sk_X509_LOOKUP_sort := LoadFunction(fn_sk_X509_LOOKUP_sort);
  @f_X509_OBJECT_retrieve_by_subject := LoadFunction(fn_X509_OBJECT_retrieve_by_subject);
  @f_X509_OBJECT_up_ref_count := LoadFunction(fn_X509_OBJECT_up_ref_count);
  @f_X509_OBJECT_free_contents := LoadFunction(fn_X509_OBJECT_free_contents);
  @f_X509_STORE_new := LoadFunction(fn_X509_STORE_new);
  @f_X509_STORE_free := LoadFunction(fn_X509_STORE_free);
  @f_X509_STORE_CTX_init := LoadFunction(fn_X509_STORE_CTX_init);
  @f_X509_STORE_CTX_cleanup := LoadFunction(fn_X509_STORE_CTX_cleanup);
  @f_X509_STORE_add_lookup := LoadFunction(fn_X509_STORE_add_lookup);
  @f_X509_LOOKUP_hash_dir := LoadFunction(fn_X509_LOOKUP_hash_dir);
  @f_X509_LOOKUP_file := LoadFunction(fn_X509_LOOKUP_file);
  @f_X509_STORE_add_cert := LoadFunction(fn_X509_STORE_add_cert);
  @f_X509_STORE_add_crl := LoadFunction(fn_X509_STORE_add_crl);
  @f_X509_STORE_get_by_subject := LoadFunction(fn_X509_STORE_get_by_subject);
  @f_X509_LOOKUP_ctrl := LoadFunction(fn_X509_LOOKUP_ctrl);
  @f_X509_load_cert_file := LoadFunction(fn_X509_load_cert_file);
  @f_X509_load_crl_file := LoadFunction(fn_X509_load_crl_file);
  @f_X509_LOOKUP_new := LoadFunction(fn_X509_LOOKUP_new);
  @f_X509_LOOKUP_free := LoadFunction(fn_X509_LOOKUP_free);
  @f_X509_LOOKUP_init := LoadFunction(fn_X509_LOOKUP_init);
  @f_X509_LOOKUP_by_subject := LoadFunction(fn_X509_LOOKUP_by_subject);
  @f_X509_LOOKUP_by_issuer_serial := LoadFunction(fn_X509_LOOKUP_by_issuer_serial);
  @f_X509_LOOKUP_by_fingerprint := LoadFunction(fn_X509_LOOKUP_by_fingerprint);
  @f_X509_LOOKUP_by_alias := LoadFunction(fn_X509_LOOKUP_by_alias);
  @f_X509_LOOKUP_shutdown := LoadFunction(fn_X509_LOOKUP_shutdown);
  @f_X509_STORE_load_locations := LoadFunction(fn_X509_STORE_load_locations);
  @f_X509_STORE_set_default_paths := LoadFunction(fn_X509_STORE_set_default_paths);
  @f_X509_STORE_CTX_get_ex_new_index := LoadFunction(fn_X509_STORE_CTX_get_ex_new_index);
  @f_X509_STORE_CTX_set_ex_data := LoadFunction(fn_X509_STORE_CTX_set_ex_data);
  @f_X509_STORE_CTX_get_ex_data := LoadFunction(fn_X509_STORE_CTX_get_ex_data);
  @f_X509_STORE_CTX_get_error := LoadFunction(fn_X509_STORE_CTX_get_error);
  @f_X509_STORE_CTX_set_error := LoadFunction(fn_X509_STORE_CTX_set_error);
  @f_X509_STORE_CTX_get_error_depth := LoadFunction(fn_X509_STORE_CTX_get_error_depth);
  @f_X509_STORE_CTX_get_current_cert := LoadFunction(fn_X509_STORE_CTX_get_current_cert);
  @f_X509_STORE_CTX_get_chain := LoadFunction(fn_X509_STORE_CTX_get_chain);
  @f_X509_STORE_CTX_set_cert := LoadFunction(fn_X509_STORE_CTX_set_cert);
  @f_X509_STORE_CTX_set_chain := LoadFunction(fn_X509_STORE_CTX_set_chain);
  @f_sk_PKCS7_SIGNER_INFO_new := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_new);
  @f_sk_PKCS7_SIGNER_INFO_new_null := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_new_null);
  @f_sk_PKCS7_SIGNER_INFO_free := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_free);
  @f_sk_PKCS7_SIGNER_INFO_num := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_num);
  @f_sk_PKCS7_SIGNER_INFO_value := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_value);
  @f_sk_PKCS7_SIGNER_INFO_set := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_set);
  @f_sk_PKCS7_SIGNER_INFO_zero := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_zero);
  @f_sk_PKCS7_SIGNER_INFO_push := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_push);
  @f_sk_PKCS7_SIGNER_INFO_unshift := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_unshift);
  @f_sk_PKCS7_SIGNER_INFO_find := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_find);
  @f_sk_PKCS7_SIGNER_INFO_delete := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_delete);
  @f_sk_PKCS7_SIGNER_INFO_delete_ptr := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_delete_ptr);
  @f_sk_PKCS7_SIGNER_INFO_insert := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_insert);
  @f_sk_PKCS7_SIGNER_INFO_dup := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_dup);
  @f_sk_PKCS7_SIGNER_INFO_pop_free := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_pop_free);
  @f_sk_PKCS7_SIGNER_INFO_shift := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_shift);
  @f_sk_PKCS7_SIGNER_INFO_pop := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_pop);
  @f_sk_PKCS7_SIGNER_INFO_sort := LoadFunction(fn_sk_PKCS7_SIGNER_INFO_sort);
  @f_i2d_ASN1_SET_OF_PKCS7_SIGNER_INFO := LoadFunction(fn_i2d_ASN1_SET_OF_PKCS7_SIGNER_INFO);
  @f_d2i_ASN1_SET_OF_PKCS7_SIGNER_INFO := LoadFunction(fn_d2i_ASN1_SET_OF_PKCS7_SIGNER_INFO);
  @f_sk_PKCS7_RECIP_INFO_new := LoadFunction(fn_sk_PKCS7_RECIP_INFO_new);
  @f_sk_PKCS7_RECIP_INFO_new_null := LoadFunction(fn_sk_PKCS7_RECIP_INFO_new_null);
  @f_sk_PKCS7_RECIP_INFO_free := LoadFunction(fn_sk_PKCS7_RECIP_INFO_free);
  @f_sk_PKCS7_RECIP_INFO_num := LoadFunction(fn_sk_PKCS7_RECIP_INFO_num);
  @f_sk_PKCS7_RECIP_INFO_value := LoadFunction(fn_sk_PKCS7_RECIP_INFO_value);
  @f_sk_PKCS7_RECIP_INFO_set := LoadFunction(fn_sk_PKCS7_RECIP_INFO_set);
  @f_sk_PKCS7_RECIP_INFO_zero := LoadFunction(fn_sk_PKCS7_RECIP_INFO_zero);
  @f_sk_PKCS7_RECIP_INFO_push := LoadFunction(fn_sk_PKCS7_RECIP_INFO_push);
  @f_sk_PKCS7_RECIP_INFO_unshift := LoadFunction(fn_sk_PKCS7_RECIP_INFO_unshift);
  @f_sk_PKCS7_RECIP_INFO_find := LoadFunction(fn_sk_PKCS7_RECIP_INFO_find);
  @f_sk_PKCS7_RECIP_INFO_delete := LoadFunction(fn_sk_PKCS7_RECIP_INFO_delete);
  @f_sk_PKCS7_RECIP_INFO_delete_ptr := LoadFunction(fn_sk_PKCS7_RECIP_INFO_delete_ptr);
  @f_sk_PKCS7_RECIP_INFO_insert := LoadFunction(fn_sk_PKCS7_RECIP_INFO_insert);
  @f_sk_PKCS7_RECIP_INFO_dup := LoadFunction(fn_sk_PKCS7_RECIP_INFO_dup);
  @f_sk_PKCS7_RECIP_INFO_pop_free := LoadFunction(fn_sk_PKCS7_RECIP_INFO_pop_free);
  @f_sk_PKCS7_RECIP_INFO_shift := LoadFunction(fn_sk_PKCS7_RECIP_INFO_shift);
  @f_sk_PKCS7_RECIP_INFO_pop := LoadFunction(fn_sk_PKCS7_RECIP_INFO_pop);
  @f_sk_PKCS7_RECIP_INFO_sort := LoadFunction(fn_sk_PKCS7_RECIP_INFO_sort);
  @f_i2d_ASN1_SET_OF_PKCS7_RECIP_INFO := LoadFunction(fn_i2d_ASN1_SET_OF_PKCS7_RECIP_INFO);
  @f_d2i_ASN1_SET_OF_PKCS7_RECIP_INFO := LoadFunction(fn_d2i_ASN1_SET_OF_PKCS7_RECIP_INFO);
  @f_PKCS7_ISSUER_AND_SERIAL_new := LoadFunction(fn_PKCS7_ISSUER_AND_SERIAL_new);
  @f_PKCS7_ISSUER_AND_SERIAL_free := LoadFunction(fn_PKCS7_ISSUER_AND_SERIAL_free);
  @f_i2d_PKCS7_ISSUER_AND_SERIAL := LoadFunction(fn_i2d_PKCS7_ISSUER_AND_SERIAL);
  @f_d2i_PKCS7_ISSUER_AND_SERIAL := LoadFunction(fn_d2i_PKCS7_ISSUER_AND_SERIAL);
  @f_PKCS7_ISSUER_AND_SERIAL_digest := LoadFunction(fn_PKCS7_ISSUER_AND_SERIAL_digest);
  @f_d2i_PKCS7_fp := LoadFunction(fn_d2i_PKCS7_fp);
  @f_i2d_PKCS7_fp := LoadFunction(fn_i2d_PKCS7_fp);
  @f_PKCS7_dup := LoadFunction(fn_PKCS7_dup);
  @f_d2i_PKCS7_bio := LoadFunction(fn_d2i_PKCS7_bio);
  @f_i2d_PKCS7_bio := LoadFunction(fn_i2d_PKCS7_bio);
  @f_PKCS7_SIGNER_INFO_new := LoadFunction(fn_PKCS7_SIGNER_INFO_new);
  @f_PKCS7_SIGNER_INFO_free := LoadFunction(fn_PKCS7_SIGNER_INFO_free);
  @f_i2d_PKCS7_SIGNER_INFO := LoadFunction(fn_i2d_PKCS7_SIGNER_INFO);
  @f_d2i_PKCS7_SIGNER_INFO := LoadFunction(fn_d2i_PKCS7_SIGNER_INFO);
  @f_PKCS7_RECIP_INFO_new := LoadFunction(fn_PKCS7_RECIP_INFO_new);
  @f_PKCS7_RECIP_INFO_free := LoadFunction(fn_PKCS7_RECIP_INFO_free);
  @f_i2d_PKCS7_RECIP_INFO := LoadFunction(fn_i2d_PKCS7_RECIP_INFO);
  @f_d2i_PKCS7_RECIP_INFO := LoadFunction(fn_d2i_PKCS7_RECIP_INFO);
  @f_PKCS7_SIGNED_new := LoadFunction(fn_PKCS7_SIGNED_new);
  @f_PKCS7_SIGNED_free := LoadFunction(fn_PKCS7_SIGNED_free);
  @f_i2d_PKCS7_SIGNED := LoadFunction(fn_i2d_PKCS7_SIGNED);
  @f_d2i_PKCS7_SIGNED := LoadFunction(fn_d2i_PKCS7_SIGNED);
  @f_PKCS7_ENC_CONTENT_new := LoadFunction(fn_PKCS7_ENC_CONTENT_new);
  @f_PKCS7_ENC_CONTENT_free := LoadFunction(fn_PKCS7_ENC_CONTENT_free);
  @f_i2d_PKCS7_ENC_CONTENT := LoadFunction(fn_i2d_PKCS7_ENC_CONTENT);
  @f_d2i_PKCS7_ENC_CONTENT := LoadFunction(fn_d2i_PKCS7_ENC_CONTENT);
  @f_PKCS7_ENVELOPE_new := LoadFunction(fn_PKCS7_ENVELOPE_new);
  @f_PKCS7_ENVELOPE_free := LoadFunction(fn_PKCS7_ENVELOPE_free);
  @f_i2d_PKCS7_ENVELOPE := LoadFunction(fn_i2d_PKCS7_ENVELOPE);
  @f_d2i_PKCS7_ENVELOPE := LoadFunction(fn_d2i_PKCS7_ENVELOPE);
  @f_PKCS7_SIGN_ENVELOPE_new := LoadFunction(fn_PKCS7_SIGN_ENVELOPE_new);
  @f_PKCS7_SIGN_ENVELOPE_free := LoadFunction(fn_PKCS7_SIGN_ENVELOPE_free);
  @f_i2d_PKCS7_SIGN_ENVELOPE := LoadFunction(fn_i2d_PKCS7_SIGN_ENVELOPE);
  @f_d2i_PKCS7_SIGN_ENVELOPE := LoadFunction(fn_d2i_PKCS7_SIGN_ENVELOPE);
  @f_PKCS7_DIGEST_new := LoadFunction(fn_PKCS7_DIGEST_new);
  @f_PKCS7_DIGEST_free := LoadFunction(fn_PKCS7_DIGEST_free);
  @f_i2d_PKCS7_DIGEST := LoadFunction(fn_i2d_PKCS7_DIGEST);
  @f_d2i_PKCS7_DIGEST := LoadFunction(fn_d2i_PKCS7_DIGEST);
  @f_PKCS7_ENCRYPT_new := LoadFunction(fn_PKCS7_ENCRYPT_new);
  @f_PKCS7_ENCRYPT_free := LoadFunction(fn_PKCS7_ENCRYPT_free);
  @f_i2d_PKCS7_ENCRYPT := LoadFunction(fn_i2d_PKCS7_ENCRYPT);
  @f_d2i_PKCS7_ENCRYPT := LoadFunction(fn_d2i_PKCS7_ENCRYPT);
  @f_PKCS7_new := LoadFunction(fn_PKCS7_new);
  @f_PKCS7_free := LoadFunction(fn_PKCS7_free);
  @f_PKCS7_content_free := LoadFunction(fn_PKCS7_content_free);
  @f_i2d_PKCS7 := LoadFunction(fn_i2d_PKCS7);
  @f_d2i_PKCS7 := LoadFunction(fn_d2i_PKCS7);
  @f_ERR_load_PKCS7_strings := LoadFunction(fn_ERR_load_PKCS7_strings);
  @f_PKCS7_ctrl := LoadFunction(fn_PKCS7_ctrl);
  @f_PKCS7_set_type := LoadFunction(fn_PKCS7_set_type);
  @f_PKCS7_set_content := LoadFunction(fn_PKCS7_set_content);
  @f_PKCS7_SIGNER_INFO_set := LoadFunction(fn_PKCS7_SIGNER_INFO_set);
  @f_PKCS7_add_signer := LoadFunction(fn_PKCS7_add_signer);
  @f_PKCS7_add_certificate := LoadFunction(fn_PKCS7_add_certificate);
  @f_PKCS7_add_crl := LoadFunction(fn_PKCS7_add_crl);
  @f_PKCS7_content_new := LoadFunction(fn_PKCS7_content_new);
  @f_PKCS7_dataVerify := LoadFunction(fn_PKCS7_dataVerify);
  @f_PKCS7_signatureVerify := LoadFunction(fn_PKCS7_signatureVerify);
  @f_PKCS7_dataInit := LoadFunction(fn_PKCS7_dataInit);
  @f_PKCS7_dataFinal := LoadFunction(fn_PKCS7_dataFinal);
  @f_PKCS7_dataDecode := LoadFunction(fn_PKCS7_dataDecode);
  @f_PKCS7_add_signature := LoadFunction(fn_PKCS7_add_signature);
  @f_PKCS7_cert_from_signer_info := LoadFunction(fn_PKCS7_cert_from_signer_info);
  @f_PKCS7_get_signer_info := LoadFunction(fn_PKCS7_get_signer_info);
  @f_PKCS7_add_recipient := LoadFunction(fn_PKCS7_add_recipient);
  @f_PKCS7_add_recipient_info := LoadFunction(fn_PKCS7_add_recipient_info);
  @f_PKCS7_RECIP_INFO_set := LoadFunction(fn_PKCS7_RECIP_INFO_set);
  @f_PKCS7_set_cipher := LoadFunction(fn_PKCS7_set_cipher);
  @f_PKCS7_get_issuer_and_serial := LoadFunction(fn_PKCS7_get_issuer_and_serial);
  @f_PKCS7_digest_from_attributes := LoadFunction(fn_PKCS7_digest_from_attributes);
  @f_PKCS7_add_signed_attribute := LoadFunction(fn_PKCS7_add_signed_attribute);
  @f_PKCS7_add_attribute := LoadFunction(fn_PKCS7_add_attribute);
  @f_PKCS7_get_attribute := LoadFunction(fn_PKCS7_get_attribute);
  @f_PKCS7_get_signed_attribute := LoadFunction(fn_PKCS7_get_signed_attribute);
  @f_PKCS7_set_signed_attributes := LoadFunction(fn_PKCS7_set_signed_attributes);
  @f_PKCS7_set_attributes := LoadFunction(fn_PKCS7_set_attributes);
  @f_X509_verify_cert_error_string := LoadFunction(fn_X509_verify_cert_error_string);
  @f_X509_verify := LoadFunction(fn_X509_verify);
  @f_X509_REQ_verify := LoadFunction(fn_X509_REQ_verify);
  @f_X509_CRL_verify := LoadFunction(fn_X509_CRL_verify);
  @f_NETSCAPE_SPKI_verify := LoadFunction(fn_NETSCAPE_SPKI_verify);
  @f_X509_sign := LoadFunction(fn_X509_sign);
  @f_X509_REQ_sign := LoadFunction(fn_X509_REQ_sign);
  @f_X509_CRL_sign := LoadFunction(fn_X509_CRL_sign);
  @f_NETSCAPE_SPKI_sign := LoadFunction(fn_NETSCAPE_SPKI_sign);
  @f_X509_digest := LoadFunction(fn_X509_digest);
  @f_X509_NAME_digest := LoadFunction(fn_X509_NAME_digest);
  @f_d2i_X509_fp := LoadFunction(fn_d2i_X509_fp);
  @f_i2d_X509_fp := LoadFunction(fn_i2d_X509_fp);
  @f_d2i_X509_CRL_fp := LoadFunction(fn_d2i_X509_CRL_fp);
  @f_i2d_X509_CRL_fp := LoadFunction(fn_i2d_X509_CRL_fp);
  @f_d2i_X509_REQ_fp := LoadFunction(fn_d2i_X509_REQ_fp);
  @f_i2d_X509_REQ_fp := LoadFunction(fn_i2d_X509_REQ_fp);
  @f_d2i_RSAPrivateKey_fp := LoadFunction(fn_d2i_RSAPrivateKey_fp);
  @f_i2d_RSAPrivateKey_fp := LoadFunction(fn_i2d_RSAPrivateKey_fp);
  @f_d2i_RSAPublicKey_fp := LoadFunction(fn_d2i_RSAPublicKey_fp);
  @f_i2d_RSAPublicKey_fp := LoadFunction(fn_i2d_RSAPublicKey_fp);
  @f_d2i_DSAPrivateKey_fp := LoadFunction(fn_d2i_DSAPrivateKey_fp);
  @f_i2d_DSAPrivateKey_fp := LoadFunction(fn_i2d_DSAPrivateKey_fp);
  @f_d2i_PKCS8_fp := LoadFunction(fn_d2i_PKCS8_fp);
  @f_i2d_PKCS8_fp := LoadFunction(fn_i2d_PKCS8_fp);
  @f_d2i_PKCS8_PRIV_KEY_INFO_fp := LoadFunction(fn_d2i_PKCS8_PRIV_KEY_INFO_fp);
  @f_i2d_PKCS8_PRIV_KEY_INFO_fp := LoadFunction(fn_i2d_PKCS8_PRIV_KEY_INFO_fp);
  @f_d2i_X509_bio := LoadFunction(fn_d2i_X509_bio);
  @f_i2d_X509_bio := LoadFunction(fn_i2d_X509_bio);
  @f_d2i_X509_CRL_bio := LoadFunction(fn_d2i_X509_CRL_bio);
  @f_i2d_X509_CRL_bio := LoadFunction(fn_i2d_X509_CRL_bio);
  @f_d2i_X509_REQ_bio := LoadFunction(fn_d2i_X509_REQ_bio);
  @f_i2d_X509_REQ_bio := LoadFunction(fn_i2d_X509_REQ_bio);
  @f_d2i_RSAPrivateKey_bio := LoadFunction(fn_d2i_RSAPrivateKey_bio);
  @f_i2d_RSAPrivateKey_bio := LoadFunction(fn_i2d_RSAPrivateKey_bio);
  @f_d2i_RSAPublicKey_bio := LoadFunction(fn_d2i_RSAPublicKey_bio);
  @f_i2d_RSAPublicKey_bio := LoadFunction(fn_i2d_RSAPublicKey_bio);
  @f_d2i_DSAPrivateKey_bio := LoadFunction(fn_d2i_DSAPrivateKey_bio);
  @f_i2d_DSAPrivateKey_bio := LoadFunction(fn_i2d_DSAPrivateKey_bio);
  @f_d2i_PKCS8_bio := LoadFunction(fn_d2i_PKCS8_bio);
  @f_i2d_PKCS8_bio := LoadFunction(fn_i2d_PKCS8_bio);
  @f_d2i_PKCS8_PRIV_KEY_INFO_bio := LoadFunction(fn_d2i_PKCS8_PRIV_KEY_INFO_bio);
  @f_i2d_PKCS8_PRIV_KEY_INFO_bio := LoadFunction(fn_i2d_PKCS8_PRIV_KEY_INFO_bio);
  @f_X509_dup := LoadFunction(fn_X509_dup);
  @f_X509_ATTRIBUTE_dup := LoadFunction(fn_X509_ATTRIBUTE_dup);
  @f_X509_EXTENSION_dup := LoadFunction(fn_X509_EXTENSION_dup);
  @f_X509_CRL_dup := LoadFunction(fn_X509_CRL_dup);
  @f_X509_REQ_dup := LoadFunction(fn_X509_REQ_dup);
  @f_X509_ALGOR_dup := LoadFunction(fn_X509_ALGOR_dup);
  @f_X509_NAME_dup := LoadFunction(fn_X509_NAME_dup);
  @f_X509_NAME_ENTRY_dup := LoadFunction(fn_X509_NAME_ENTRY_dup);
  @f_RSAPublicKey_dup := LoadFunction(fn_RSAPublicKey_dup);
  @f_RSAPrivateKey_dup := LoadFunction(fn_RSAPrivateKey_dup);
  @f_X509_cmp_current_time := LoadFunction(fn_X509_cmp_current_time);
  @f_X509_gmtime_adj := LoadFunction(fn_X509_gmtime_adj);
  @f_X509_get_default_cert_area := LoadFunction(fn_X509_get_default_cert_area);
  @f_X509_get_default_cert_dir := LoadFunction(fn_X509_get_default_cert_dir);
  @f_X509_get_default_cert_file := LoadFunction(fn_X509_get_default_cert_file);
  @f_X509_get_default_cert_dir_env := LoadFunction(fn_X509_get_default_cert_dir_env);
  @f_X509_get_default_cert_file_env := LoadFunction(fn_X509_get_default_cert_file_env);
  @f_X509_get_default_private_dir := LoadFunction(fn_X509_get_default_private_dir);
  @f_X509_to_X509_REQ := LoadFunction(fn_X509_to_X509_REQ);
  @f_X509_REQ_to_X509 := LoadFunction(fn_X509_REQ_to_X509);
  @f_ERR_load_X509_strings := LoadFunction(fn_ERR_load_X509_strings);
  @f_X509_ALGOR_new := LoadFunction(fn_X509_ALGOR_new);
  @f_X509_ALGOR_free := LoadFunction(fn_X509_ALGOR_free);
  @f_i2d_X509_ALGOR := LoadFunction(fn_i2d_X509_ALGOR);
  @f_d2i_X509_ALGOR := LoadFunction(fn_d2i_X509_ALGOR);
  @f_X509_VAL_new := LoadFunction(fn_X509_VAL_new);
  @f_X509_VAL_free := LoadFunction(fn_X509_VAL_free);
  @f_i2d_X509_VAL := LoadFunction(fn_i2d_X509_VAL);
  @f_d2i_X509_VAL := LoadFunction(fn_d2i_X509_VAL);
  @f_X509_PUBKEY_new := LoadFunction(fn_X509_PUBKEY_new);
  @f_X509_PUBKEY_free := LoadFunction(fn_X509_PUBKEY_free);
  @f_i2d_X509_PUBKEY := LoadFunction(fn_i2d_X509_PUBKEY);
  @f_d2i_X509_PUBKEY := LoadFunction(fn_d2i_X509_PUBKEY);
  @f_X509_PUBKEY_set := LoadFunction(fn_X509_PUBKEY_set);
  @f_X509_PUBKEY_get := LoadFunction(fn_X509_PUBKEY_get);
  @f_X509_get_pubkey_parameters := LoadFunction(fn_X509_get_pubkey_parameters);
  @f_X509_SIG_new := LoadFunction(fn_X509_SIG_new);
  @f_X509_SIG_free := LoadFunction(fn_X509_SIG_free);
  @f_i2d_X509_SIG := LoadFunction(fn_i2d_X509_SIG);
  @f_d2i_X509_SIG := LoadFunction(fn_d2i_X509_SIG);
  @f_X509_REQ_INFO_new := LoadFunction(fn_X509_REQ_INFO_new);
  @f_X509_REQ_INFO_free := LoadFunction(fn_X509_REQ_INFO_free);
  @f_i2d_X509_REQ_INFO := LoadFunction(fn_i2d_X509_REQ_INFO);
  @f_d2i_X509_REQ_INFO := LoadFunction(fn_d2i_X509_REQ_INFO);
  @f_X509_REQ_new := LoadFunction(fn_X509_REQ_new);
  @f_X509_REQ_free := LoadFunction(fn_X509_REQ_free);
  @f_i2d_X509_REQ := LoadFunction(fn_i2d_X509_REQ);
  @f_d2i_X509_REQ := LoadFunction(fn_d2i_X509_REQ);
  @f_X509_ATTRIBUTE_new := LoadFunction(fn_X509_ATTRIBUTE_new);
  @f_X509_ATTRIBUTE_free := LoadFunction(fn_X509_ATTRIBUTE_free);
  @f_i2d_X509_ATTRIBUTE := LoadFunction(fn_i2d_X509_ATTRIBUTE);
  @f_d2i_X509_ATTRIBUTE := LoadFunction(fn_d2i_X509_ATTRIBUTE);
  @f_X509_ATTRIBUTE_create := LoadFunction(fn_X509_ATTRIBUTE_create);
  @f_X509_EXTENSION_new := LoadFunction(fn_X509_EXTENSION_new);
  @f_X509_EXTENSION_free := LoadFunction(fn_X509_EXTENSION_free);
  @f_i2d_X509_EXTENSION := LoadFunction(fn_i2d_X509_EXTENSION);
  @f_d2i_X509_EXTENSION := LoadFunction(fn_d2i_X509_EXTENSION);
  @f_X509_NAME_ENTRY_new := LoadFunction(fn_X509_NAME_ENTRY_new);
  @f_X509_NAME_ENTRY_free := LoadFunction(fn_X509_NAME_ENTRY_free);
  @f_i2d_X509_NAME_ENTRY := LoadFunction(fn_i2d_X509_NAME_ENTRY);
  @f_d2i_X509_NAME_ENTRY := LoadFunction(fn_d2i_X509_NAME_ENTRY);
  @f_X509_NAME_new := LoadFunction(fn_X509_NAME_new);
  @f_X509_NAME_free := LoadFunction(fn_X509_NAME_free);
  @f_i2d_X509_NAME := LoadFunction(fn_i2d_X509_NAME);
  @f_d2i_X509_NAME := LoadFunction(fn_d2i_X509_NAME);
  @f_X509_NAME_set := LoadFunction(fn_X509_NAME_set);
  @f_X509_CINF_new := LoadFunction(fn_X509_CINF_new);
  @f_X509_CINF_free := LoadFunction(fn_X509_CINF_free);
  @f_i2d_X509_CINF := LoadFunction(fn_i2d_X509_CINF);
  @f_d2i_X509_CINF := LoadFunction(fn_d2i_X509_CINF);
  @f_X509_new := LoadFunction(fn_X509_new);
  @f_X509_free := LoadFunction(fn_X509_free);
  @f_i2d_X509 := LoadFunction(fn_i2d_X509);
  @f_d2i_X509 := LoadFunction(fn_d2i_X509);
  @f_X509_REVOKED_new := LoadFunction(fn_X509_REVOKED_new);
  @f_X509_REVOKED_free := LoadFunction(fn_X509_REVOKED_free);
  @f_i2d_X509_REVOKED := LoadFunction(fn_i2d_X509_REVOKED);
  @f_d2i_X509_REVOKED := LoadFunction(fn_d2i_X509_REVOKED);
  @f_X509_CRL_INFO_new := LoadFunction(fn_X509_CRL_INFO_new);
  @f_X509_CRL_INFO_free := LoadFunction(fn_X509_CRL_INFO_free);
  @f_i2d_X509_CRL_INFO := LoadFunction(fn_i2d_X509_CRL_INFO);
  @f_d2i_X509_CRL_INFO := LoadFunction(fn_d2i_X509_CRL_INFO);
  @f_X509_CRL_new := LoadFunction(fn_X509_CRL_new);
  @f_X509_CRL_free := LoadFunction(fn_X509_CRL_free);
  @f_i2d_X509_CRL := LoadFunction(fn_i2d_X509_CRL);
  @f_d2i_X509_CRL := LoadFunction(fn_d2i_X509_CRL);
  @f_X509_PKEY_new := LoadFunction(fn_X509_PKEY_new);
  @f_X509_PKEY_free := LoadFunction(fn_X509_PKEY_free);
  @f_i2d_X509_PKEY := LoadFunction(fn_i2d_X509_PKEY);
  @f_d2i_X509_PKEY := LoadFunction(fn_d2i_X509_PKEY);
  @f_NETSCAPE_SPKI_new := LoadFunction(fn_NETSCAPE_SPKI_new);
  @f_NETSCAPE_SPKI_free := LoadFunction(fn_NETSCAPE_SPKI_free);
  @f_i2d_NETSCAPE_SPKI := LoadFunction(fn_i2d_NETSCAPE_SPKI);
  @f_d2i_NETSCAPE_SPKI := LoadFunction(fn_d2i_NETSCAPE_SPKI);
  @f_NETSCAPE_SPKAC_new := LoadFunction(fn_NETSCAPE_SPKAC_new);
  @f_NETSCAPE_SPKAC_free := LoadFunction(fn_NETSCAPE_SPKAC_free);
  @f_i2d_NETSCAPE_SPKAC := LoadFunction(fn_i2d_NETSCAPE_SPKAC);
  @f_d2i_NETSCAPE_SPKAC := LoadFunction(fn_d2i_NETSCAPE_SPKAC);
  @f_i2d_NETSCAPE_CERT_SEQUENCE := LoadFunction(fn_i2d_NETSCAPE_CERT_SEQUENCE);
  @f_NETSCAPE_CERT_SEQUENCE_new := LoadFunction(fn_NETSCAPE_CERT_SEQUENCE_new);
  @f_d2i_NETSCAPE_CERT_SEQUENCE := LoadFunction(fn_d2i_NETSCAPE_CERT_SEQUENCE);
  @f_NETSCAPE_CERT_SEQUENCE_free := LoadFunction(fn_NETSCAPE_CERT_SEQUENCE_free);
  @f_X509_INFO_new := LoadFunction(fn_X509_INFO_new);
  @f_X509_INFO_free := LoadFunction(fn_X509_INFO_free);
  @f_X509_NAME_oneline := LoadFunction(fn_X509_NAME_oneline);
  @f_ASN1_verify := LoadFunction(fn_ASN1_verify);
  @f_ASN1_digest := LoadFunction(fn_ASN1_digest);
  @f_ASN1_sign := LoadFunction(fn_ASN1_sign);
  @f_X509_set_version := LoadFunction(fn_X509_set_version);
  @f_X509_set_serialNumber := LoadFunction(fn_X509_set_serialNumber);
  @f_X509_get_serialNumber := LoadFunction(fn_X509_get_serialNumber);
  @f_X509_set_issuer_name := LoadFunction(fn_X509_set_issuer_name);
  @f_X509_get_issuer_name := LoadFunction(fn_X509_get_issuer_name);
  @f_X509_set_subject_name := LoadFunction(fn_X509_set_subject_name);
  @f_X509_get_subject_name := LoadFunction(fn_X509_get_subject_name);
  @f_X509_set_notBefore := LoadFunction(fn_X509_set_notBefore);
  @f_X509_set_notAfter := LoadFunction(fn_X509_set_notAfter);
  @f_X509_set_pubkey := LoadFunction(fn_X509_set_pubkey);
  @f_X509_get_pubkey := LoadFunction(fn_X509_get_pubkey);
  @f_X509_certificate_type := LoadFunction(fn_X509_certificate_type);
  @f_X509_REQ_set_version := LoadFunction(fn_X509_REQ_set_version);
  @f_X509_REQ_set_subject_name := LoadFunction(fn_X509_REQ_set_subject_name);
  @f_X509_REQ_set_pubkey := LoadFunction(fn_X509_REQ_set_pubkey);
  @f_X509_REQ_get_pubkey := LoadFunction(fn_X509_REQ_get_pubkey);
  @f_X509_check_private_key := LoadFunction(fn_X509_check_private_key);
  @f_X509_issuer_and_serial_cmp := LoadFunction(fn_X509_issuer_and_serial_cmp);
  @f_X509_issuer_and_serial_hash := LoadFunction(fn_X509_issuer_and_serial_hash);
  @f_X509_issuer_name_cmp := LoadFunction(fn_X509_issuer_name_cmp);
  @f_X509_issuer_name_hash := LoadFunction(fn_X509_issuer_name_hash);
  @f_X509_subject_name_cmp := LoadFunction(fn_X509_subject_name_cmp);
  @f_X509_subject_name_hash := LoadFunction(fn_X509_subject_name_hash);
  @f_X509_NAME_cmp := LoadFunction(fn_X509_NAME_cmp);
  @f_X509_NAME_hash := LoadFunction(fn_X509_NAME_hash);
  @f_X509_CRL_cmp := LoadFunction(fn_X509_CRL_cmp);
  @f_X509_print_fp := LoadFunction(fn_X509_print_fp);
  @f_X509_CRL_print_fp := LoadFunction(fn_X509_CRL_print_fp);
  @f_X509_REQ_print_fp := LoadFunction(fn_X509_REQ_print_fp);
  @f_X509_NAME_print := LoadFunction(fn_X509_NAME_print);
  @f_X509_print := LoadFunction(fn_X509_print);
  @f_X509_CRL_print := LoadFunction(fn_X509_CRL_print);
  @f_X509_REQ_print := LoadFunction(fn_X509_REQ_print);
  @f_X509_NAME_entry_count := LoadFunction(fn_X509_NAME_entry_count);
  @f_X509_NAME_get_text_by_NID := LoadFunction(fn_X509_NAME_get_text_by_NID);
  @f_X509_NAME_get_text_by_OBJ := LoadFunction(fn_X509_NAME_get_text_by_OBJ);
  @f_X509_NAME_get_index_by_NID := LoadFunction(fn_X509_NAME_get_index_by_NID);
  @f_X509_NAME_get_index_by_OBJ := LoadFunction(fn_X509_NAME_get_index_by_OBJ);
  @f_X509_NAME_get_entry := LoadFunction(fn_X509_NAME_get_entry);
  @f_X509_NAME_delete_entry := LoadFunction(fn_X509_NAME_delete_entry);
  @f_X509_NAME_add_entry := LoadFunction(fn_X509_NAME_add_entry);
  @f_X509_NAME_ENTRY_create_by_NID := LoadFunction(fn_X509_NAME_ENTRY_create_by_NID);
  @f_X509_NAME_ENTRY_create_by_OBJ := LoadFunction(fn_X509_NAME_ENTRY_create_by_OBJ);
  @f_X509_NAME_ENTRY_set_object := LoadFunction(fn_X509_NAME_ENTRY_set_object);
  @f_X509_NAME_ENTRY_set_data := LoadFunction(fn_X509_NAME_ENTRY_set_data);
  @f_X509_NAME_ENTRY_get_object := LoadFunction(fn_X509_NAME_ENTRY_get_object);
  @f_X509_NAME_ENTRY_get_data := LoadFunction(fn_X509_NAME_ENTRY_get_data);
  @f_X509v3_get_ext_count := LoadFunction(fn_X509v3_get_ext_count);
  @f_X509v3_get_ext_by_NID := LoadFunction(fn_X509v3_get_ext_by_NID);
  @f_X509v3_get_ext_by_OBJ := LoadFunction(fn_X509v3_get_ext_by_OBJ);
  @f_X509v3_get_ext_by_critical := LoadFunction(fn_X509v3_get_ext_by_critical);
  @f_X509v3_get_ext := LoadFunction(fn_X509v3_get_ext);
  @f_X509v3_delete_ext := LoadFunction(fn_X509v3_delete_ext);
  @f_X509v3_add_ext := LoadFunction(fn_X509v3_add_ext);
  @f_X509_get_ext_count := LoadFunction(fn_X509_get_ext_count);
  @f_X509_get_ext_by_NID := LoadFunction(fn_X509_get_ext_by_NID);
  @f_X509_get_ext_by_OBJ := LoadFunction(fn_X509_get_ext_by_OBJ);
  @f_X509_get_ext_by_critical := LoadFunction(fn_X509_get_ext_by_critical);
  @f_X509_get_ext := LoadFunction(fn_X509_get_ext);
  @f_X509_delete_ext := LoadFunction(fn_X509_delete_ext);
  @f_X509_add_ext := LoadFunction(fn_X509_add_ext);
  @f_X509_CRL_get_ext_count := LoadFunction(fn_X509_CRL_get_ext_count);
  @f_X509_CRL_get_ext_by_NID := LoadFunction(fn_X509_CRL_get_ext_by_NID);
  @f_X509_CRL_get_ext_by_OBJ := LoadFunction(fn_X509_CRL_get_ext_by_OBJ);
  @f_X509_CRL_get_ext_by_critical := LoadFunction(fn_X509_CRL_get_ext_by_critical);
  @f_X509_CRL_get_ext := LoadFunction(fn_X509_CRL_get_ext);
  @f_X509_CRL_delete_ext := LoadFunction(fn_X509_CRL_delete_ext);
  @f_X509_CRL_add_ext := LoadFunction(fn_X509_CRL_add_ext);
  @f_X509_REVOKED_get_ext_count := LoadFunction(fn_X509_REVOKED_get_ext_count);
  @f_X509_REVOKED_get_ext_by_NID := LoadFunction(fn_X509_REVOKED_get_ext_by_NID);
  @f_X509_REVOKED_get_ext_by_OBJ := LoadFunction(fn_X509_REVOKED_get_ext_by_OBJ);
  @f_X509_REVOKED_get_ext_by_critical := LoadFunction(fn_X509_REVOKED_get_ext_by_critical);
  @f_X509_REVOKED_get_ext := LoadFunction(fn_X509_REVOKED_get_ext);
  @f_X509_REVOKED_delete_ext := LoadFunction(fn_X509_REVOKED_delete_ext);
  @f_X509_REVOKED_add_ext := LoadFunction(fn_X509_REVOKED_add_ext);
  @f_X509_EXTENSION_create_by_NID := LoadFunction(fn_X509_EXTENSION_create_by_NID);
  @f_X509_EXTENSION_create_by_OBJ := LoadFunction(fn_X509_EXTENSION_create_by_OBJ);
  @f_X509_EXTENSION_set_object := LoadFunction(fn_X509_EXTENSION_set_object);
  @f_X509_EXTENSION_set_critical := LoadFunction(fn_X509_EXTENSION_set_critical);
  @f_X509_EXTENSION_set_data := LoadFunction(fn_X509_EXTENSION_set_data);
  @f_X509_EXTENSION_get_object := LoadFunction(fn_X509_EXTENSION_get_object);
  @f_X509_EXTENSION_get_data := LoadFunction(fn_X509_EXTENSION_get_data);
  @f_X509_EXTENSION_get_critical := LoadFunction(fn_X509_EXTENSION_get_critical);
  @f_X509_verify_cert := LoadFunction(fn_X509_verify_cert);
  @f_X509_find_by_issuer_and_serial := LoadFunction(fn_X509_find_by_issuer_and_serial);
  @f_X509_find_by_subject := LoadFunction(fn_X509_find_by_subject);
  @f_i2d_PBEPARAM := LoadFunction(fn_i2d_PBEPARAM);
  @f_PBEPARAM_new := LoadFunction(fn_PBEPARAM_new);
  @f_d2i_PBEPARAM := LoadFunction(fn_d2i_PBEPARAM);
  @f_PBEPARAM_free := LoadFunction(fn_PBEPARAM_free);
  @f_PKCS5_pbe_set := LoadFunction(fn_PKCS5_pbe_set);
  @f_PKCS5_pbe2_set := LoadFunction(fn_PKCS5_pbe2_set);
  @f_i2d_PBKDF2PARAM := LoadFunction(fn_i2d_PBKDF2PARAM);
  @f_PBKDF2PARAM_new := LoadFunction(fn_PBKDF2PARAM_new);
  @f_d2i_PBKDF2PARAM := LoadFunction(fn_d2i_PBKDF2PARAM);
  @f_PBKDF2PARAM_free := LoadFunction(fn_PBKDF2PARAM_free);
  @f_i2d_PBE2PARAM := LoadFunction(fn_i2d_PBE2PARAM);
  @f_PBE2PARAM_new := LoadFunction(fn_PBE2PARAM_new);
  @f_d2i_PBE2PARAM := LoadFunction(fn_d2i_PBE2PARAM);
  @f_PBE2PARAM_free := LoadFunction(fn_PBE2PARAM_free);
  @f_i2d_PKCS8_PRIV_KEY_INFO := LoadFunction(fn_i2d_PKCS8_PRIV_KEY_INFO);
  @f_PKCS8_PRIV_KEY_INFO_new := LoadFunction(fn_PKCS8_PRIV_KEY_INFO_new);
  @f_d2i_PKCS8_PRIV_KEY_INFO := LoadFunction(fn_d2i_PKCS8_PRIV_KEY_INFO);
  @f_PKCS8_PRIV_KEY_INFO_free := LoadFunction(fn_PKCS8_PRIV_KEY_INFO_free);
  @f_EVP_PKCS82PKEY := LoadFunction(fn_EVP_PKCS82PKEY);
  @f_EVP_PKEY2PKCS8 := LoadFunction(fn_EVP_PKEY2PKCS8);
  @f_PKCS8_set_broken := LoadFunction(fn_PKCS8_set_broken);
  @f_ERR_load_PEM_strings := LoadFunction(fn_ERR_load_PEM_strings);
  @f_PEM_get_EVP_CIPHER_INFO := LoadFunction(fn_PEM_get_EVP_CIPHER_INFO);
  @f_PEM_do_header := LoadFunction(fn_PEM_do_header);
  @f_PEM_read_bio := LoadFunction(fn_PEM_read_bio);
  @f_PEM_write_bio := LoadFunction(fn_PEM_write_bio);
  @f_PEM_ASN1_read_bio := LoadFunction(fn_PEM_ASN1_read_bio);
  @f_PEM_ASN1_write_bio := LoadFunction(fn_PEM_ASN1_write_bio);
  @f_PEM_X509_INFO_read_bio := LoadFunction(fn_PEM_X509_INFO_read_bio);
  @f_PEM_X509_INFO_write_bio := LoadFunction(fn_PEM_X509_INFO_write_bio);
  @f_PEM_read := LoadFunction(fn_PEM_read);
  @f_PEM_write := LoadFunction(fn_PEM_write);
  @f_PEM_ASN1_read := LoadFunction(fn_PEM_ASN1_read);
  @f_PEM_ASN1_write := LoadFunction(fn_PEM_ASN1_write);
  @f_PEM_X509_INFO_read := LoadFunction(fn_PEM_X509_INFO_read);
  @f_PEM_SealInit := LoadFunction(fn_PEM_SealInit);
  @f_PEM_SealUpdate := LoadFunction(fn_PEM_SealUpdate);
  @f_PEM_SealFinal := LoadFunction(fn_PEM_SealFinal);
  @f_PEM_SignInit := LoadFunction(fn_PEM_SignInit);
  @f_PEM_SignUpdate := LoadFunction(fn_PEM_SignUpdate);
  @f_PEM_SignFinal := LoadFunction(fn_PEM_SignFinal);
  @f_PEM_proc_type := LoadFunction(fn_PEM_proc_type);
  @f_PEM_dek_info := LoadFunction(fn_PEM_dek_info);
  @f_PEM_read_bio_X509 := LoadFunction(fn_PEM_read_bio_X509);
  @f_PEM_read_X509 := LoadFunction(fn_PEM_read_X509);
  @f_PEM_write_bio_X509 := LoadFunction(fn_PEM_write_bio_X509);
  @f_PEM_write_X509 := LoadFunction(fn_PEM_write_X509);
  @f_PEM_read_bio_X509_REQ := LoadFunction(fn_PEM_read_bio_X509_REQ);
  @f_PEM_read_X509_REQ := LoadFunction(fn_PEM_read_X509_REQ);
  @f_PEM_write_bio_X509_REQ := LoadFunction(fn_PEM_write_bio_X509_REQ);
  @f_PEM_write_X509_REQ := LoadFunction(fn_PEM_write_X509_REQ);
  @f_PEM_read_bio_X509_CRL := LoadFunction(fn_PEM_read_bio_X509_CRL);
  @f_PEM_read_X509_CRL := LoadFunction(fn_PEM_read_X509_CRL);
  @f_PEM_write_bio_X509_CRL := LoadFunction(fn_PEM_write_bio_X509_CRL);
  @f_PEM_write_X509_CRL := LoadFunction(fn_PEM_write_X509_CRL);
  @f_PEM_read_bio_PKCS7 := LoadFunction(fn_PEM_read_bio_PKCS7);
  @f_PEM_read_PKCS7 := LoadFunction(fn_PEM_read_PKCS7);
  @f_PEM_write_bio_PKCS7 := LoadFunction(fn_PEM_write_bio_PKCS7);
  @f_PEM_write_PKCS7 := LoadFunction(fn_PEM_write_PKCS7);
  @f_PEM_read_bio_NETSCAPE_CERT_SEQUENCE := LoadFunction(fn_PEM_read_bio_NETSCAPE_CERT_SEQUENCE);
  @f_PEM_read_NETSCAPE_CERT_SEQUENCE := LoadFunction(fn_PEM_read_NETSCAPE_CERT_SEQUENCE);
  @f_PEM_write_bio_NETSCAPE_CERT_SEQUENCE := LoadFunction(fn_PEM_write_bio_NETSCAPE_CERT_SEQUENCE);
  @f_PEM_write_NETSCAPE_CERT_SEQUENCE := LoadFunction(fn_PEM_write_NETSCAPE_CERT_SEQUENCE);
  @f_PEM_read_bio_PKCS8 := LoadFunction(fn_PEM_read_bio_PKCS8);
  @f_PEM_read_PKCS8 := LoadFunction(fn_PEM_read_PKCS8);
  @f_PEM_write_bio_PKCS8 := LoadFunction(fn_PEM_write_bio_PKCS8);
  @f_PEM_write_PKCS8 := LoadFunction(fn_PEM_write_PKCS8);
  @f_PEM_read_bio_PKCS8_PRIV_KEY_INFO := LoadFunction(fn_PEM_read_bio_PKCS8_PRIV_KEY_INFO);
  @f_PEM_read_PKCS8_PRIV_KEY_INFO := LoadFunction(fn_PEM_read_PKCS8_PRIV_KEY_INFO);
  @f_PEM_write_bio_PKCS8_PRIV_KEY_INFO := LoadFunction(fn_PEM_write_bio_PKCS8_PRIV_KEY_INFO);
  @f_PEM_write_PKCS8_PRIV_KEY_INFO := LoadFunction(fn_PEM_write_PKCS8_PRIV_KEY_INFO);
  @f_PEM_read_bio_RSAPrivateKey := LoadFunction(fn_PEM_read_bio_RSAPrivateKey);
  @f_PEM_read_RSAPrivateKey := LoadFunction(fn_PEM_read_RSAPrivateKey);
  @f_PEM_write_bio_RSAPrivateKey := LoadFunction(fn_PEM_write_bio_RSAPrivateKey);
  @f_PEM_write_RSAPrivateKey := LoadFunction(fn_PEM_write_RSAPrivateKey);
  @f_PEM_read_bio_RSAPublicKey := LoadFunction(fn_PEM_read_bio_RSAPublicKey);
  @f_PEM_read_RSAPublicKey := LoadFunction(fn_PEM_read_RSAPublicKey);
  @f_PEM_write_bio_RSAPublicKey := LoadFunction(fn_PEM_write_bio_RSAPublicKey);
  @f_PEM_write_RSAPublicKey := LoadFunction(fn_PEM_write_RSAPublicKey);
  @f_PEM_read_bio_DSAPrivateKey := LoadFunction(fn_PEM_read_bio_DSAPrivateKey);
  @f_PEM_read_DSAPrivateKey := LoadFunction(fn_PEM_read_DSAPrivateKey);
  @f_PEM_write_bio_DSAPrivateKey := LoadFunction(fn_PEM_write_bio_DSAPrivateKey);
  @f_PEM_write_DSAPrivateKey := LoadFunction(fn_PEM_write_DSAPrivateKey);
  @f_PEM_read_bio_DSAparams := LoadFunction(fn_PEM_read_bio_DSAparams);
  @f_PEM_read_DSAparams := LoadFunction(fn_PEM_read_DSAparams);
  @f_PEM_write_bio_DSAparams := LoadFunction(fn_PEM_write_bio_DSAparams);
  @f_PEM_write_DSAparams := LoadFunction(fn_PEM_write_DSAparams);
  @f_PEM_read_bio_DHparams := LoadFunction(fn_PEM_read_bio_DHparams);
  @f_PEM_read_DHparams := LoadFunction(fn_PEM_read_DHparams);
  @f_PEM_write_bio_DHparams := LoadFunction(fn_PEM_write_bio_DHparams);
  @f_PEM_write_DHparams := LoadFunction(fn_PEM_write_DHparams);
  @f_PEM_read_bio_PrivateKey := LoadFunction(fn_PEM_read_bio_PrivateKey);
  @f_PEM_read_PrivateKey := LoadFunction(fn_PEM_read_PrivateKey);
  @f_PEM_write_bio_PrivateKey := LoadFunction(fn_PEM_write_bio_PrivateKey);
  @f_PEM_write_PrivateKey := LoadFunction(fn_PEM_write_PrivateKey);
  @f_PEM_write_bio_PKCS8PrivateKey := LoadFunction(fn_PEM_write_bio_PKCS8PrivateKey);
  @f_PEM_write_PKCS8PrivateKey := LoadFunction(fn_PEM_write_PKCS8PrivateKey);
  @f_sk_SSL_CIPHER_new := LoadFunction(fn_sk_SSL_CIPHER_new);
  @f_sk_SSL_CIPHER_new_null := LoadFunction(fn_sk_SSL_CIPHER_new_null);
  @f_sk_SSL_CIPHER_free := LoadFunction(fn_sk_SSL_CIPHER_free);
  @f_sk_SSL_CIPHER_num := LoadFunction(fn_sk_SSL_CIPHER_num);
  @f_sk_SSL_CIPHER_value := LoadFunction(fn_sk_SSL_CIPHER_value);
  @f_sk_SSL_CIPHER_set := LoadFunction(fn_sk_SSL_CIPHER_set);
  @f_sk_SSL_CIPHER_zero := LoadFunction(fn_sk_SSL_CIPHER_zero);
  @f_sk_SSL_CIPHER_push := LoadFunction(fn_sk_SSL_CIPHER_push);
  @f_sk_SSL_CIPHER_unshift := LoadFunction(fn_sk_SSL_CIPHER_unshift);
  @f_sk_SSL_CIPHER_find := LoadFunction(fn_sk_SSL_CIPHER_find);
  @f_sk_SSL_CIPHER_delete := LoadFunction(fn_sk_SSL_CIPHER_delete);
  @f_sk_SSL_CIPHER_delete_ptr := LoadFunction(fn_sk_SSL_CIPHER_delete_ptr);
  @f_sk_SSL_CIPHER_insert := LoadFunction(fn_sk_SSL_CIPHER_insert);
  @f_sk_SSL_CIPHER_dup := LoadFunction(fn_sk_SSL_CIPHER_dup);
  @f_sk_SSL_CIPHER_pop_free := LoadFunction(fn_sk_SSL_CIPHER_pop_free);
  @f_sk_SSL_CIPHER_shift := LoadFunction(fn_sk_SSL_CIPHER_shift);
  @f_sk_SSL_CIPHER_pop := LoadFunction(fn_sk_SSL_CIPHER_pop);
  @f_sk_SSL_CIPHER_sort := LoadFunction(fn_sk_SSL_CIPHER_sort);
  @f_sk_SSL_COMP_new := LoadFunction(fn_sk_SSL_COMP_new);
  @f_sk_SSL_COMP_new_null := LoadFunction(fn_sk_SSL_COMP_new_null);
  @f_sk_SSL_COMP_free := LoadFunction(fn_sk_SSL_COMP_free);
  @f_sk_SSL_COMP_num := LoadFunction(fn_sk_SSL_COMP_num);
  @f_sk_SSL_COMP_value := LoadFunction(fn_sk_SSL_COMP_value);
  @f_sk_SSL_COMP_set := LoadFunction(fn_sk_SSL_COMP_set);
  @f_sk_SSL_COMP_zero := LoadFunction(fn_sk_SSL_COMP_zero);
  @f_sk_SSL_COMP_push := LoadFunction(fn_sk_SSL_COMP_push);
  @f_sk_SSL_COMP_unshift := LoadFunction(fn_sk_SSL_COMP_unshift);
  @f_sk_SSL_COMP_find := LoadFunction(fn_sk_SSL_COMP_find);
  @f_sk_SSL_COMP_delete := LoadFunction(fn_sk_SSL_COMP_delete);
  @f_sk_SSL_COMP_delete_ptr := LoadFunction(fn_sk_SSL_COMP_delete_ptr);
  @f_sk_SSL_COMP_insert := LoadFunction(fn_sk_SSL_COMP_insert);
  @f_sk_SSL_COMP_dup := LoadFunction(fn_sk_SSL_COMP_dup);
  @f_sk_SSL_COMP_pop_free := LoadFunction(fn_sk_SSL_COMP_pop_free);
  @f_sk_SSL_COMP_shift := LoadFunction(fn_sk_SSL_COMP_shift);
  @f_sk_SSL_COMP_pop := LoadFunction(fn_sk_SSL_COMP_pop);
  @f_sk_SSL_COMP_sort := LoadFunction(fn_sk_SSL_COMP_sort);
  @f_BIO_f_ssl := LoadFunction(fn_BIO_f_ssl);
  @f_BIO_new_ssl := LoadFunction(fn_BIO_new_ssl);
  @f_BIO_new_ssl_connect := LoadFunction(fn_BIO_new_ssl_connect);
  @f_BIO_new_buffer_ssl_connect := LoadFunction(fn_BIO_new_buffer_ssl_connect);
  @f_BIO_ssl_copy_session_id := LoadFunction(fn_BIO_ssl_copy_session_id);
  @f_BIO_ssl_shutdown := LoadFunction(fn_BIO_ssl_shutdown);
  @f_SSL_CTX_set_cipher_list := LoadFunction(fn_SSL_CTX_set_cipher_list);
  @f_SSL_CTX_new := LoadFunction(fn_SSL_CTX_new);
  @f_SSL_CTX_free := LoadFunction(fn_SSL_CTX_free);
  @f_SSL_CTX_set_timeout := LoadFunction(fn_SSL_CTX_set_timeout);
  @f_SSL_CTX_get_timeout := LoadFunction(fn_SSL_CTX_get_timeout);
  @f_SSL_CTX_get_cert_store := LoadFunction(fn_SSL_CTX_get_cert_store);
  @f_SSL_CTX_set_cert_store := LoadFunction(fn_SSL_CTX_set_cert_store);
  @f_SSL_want := LoadFunction(fn_SSL_want);
  @f_SSL_clear := LoadFunction(fn_SSL_clear);
  @f_SSL_CTX_flush_sessions := LoadFunction(fn_SSL_CTX_flush_sessions);
  @f_SSL_get_current_cipher := LoadFunction(fn_SSL_get_current_cipher);
  @f_SSL_CIPHER_get_bits := LoadFunction(fn_SSL_CIPHER_get_bits);
  @f_SSL_CIPHER_get_version := LoadFunction(fn_SSL_CIPHER_get_version);
  @f_SSL_CIPHER_get_name := LoadFunction(fn_SSL_CIPHER_get_name);
  @f_SSL_get_fd := LoadFunction(fn_SSL_get_fd);
  @f_SSL_get_cipher_list := LoadFunction(fn_SSL_get_cipher_list);
  @f_SSL_get_shared_ciphers := LoadFunction(fn_SSL_get_shared_ciphers);
  @f_SSL_get_read_ahead := LoadFunction(fn_SSL_get_read_ahead);
  @f_SSL_pending := LoadFunction(fn_SSL_pending);
  @f_SSL_set_fd := LoadFunction(fn_SSL_set_fd);
  @f_SSL_set_rfd := LoadFunction(fn_SSL_set_rfd);
  @f_SSL_set_wfd := LoadFunction(fn_SSL_set_wfd);
  @f_SSL_set_bio := LoadFunction(fn_SSL_set_bio);
  @f_SSL_get_rbio := LoadFunction(fn_SSL_get_rbio);
  @f_SSL_get_wbio := LoadFunction(fn_SSL_get_wbio);
  @f_SSL_set_cipher_list := LoadFunction(fn_SSL_set_cipher_list);
  @f_SSL_set_read_ahead := LoadFunction(fn_SSL_set_read_ahead);
  @f_SSL_get_verify_mode := LoadFunction(fn_SSL_get_verify_mode);
  @f_SSL_get_verify_depth := LoadFunction(fn_SSL_get_verify_depth);
  @f_SSL_set_verify := LoadFunction(fn_SSL_set_verify);
  @f_SSL_set_verify_depth := LoadFunction(fn_SSL_set_verify_depth);
  @f_SSL_use_RSAPrivateKey := LoadFunction(fn_SSL_use_RSAPrivateKey);
  @f_SSL_use_RSAPrivateKey_ASN1 := LoadFunction(fn_SSL_use_RSAPrivateKey_ASN1);
  @f_SSL_use_PrivateKey := LoadFunction(fn_SSL_use_PrivateKey);
  @f_SSL_use_PrivateKey_ASN1 := LoadFunction(fn_SSL_use_PrivateKey_ASN1);
  @f_SSL_use_certificate := LoadFunction(fn_SSL_use_certificate);
  @f_SSL_use_certificate_ASN1 := LoadFunction(fn_SSL_use_certificate_ASN1);
  @f_SSL_use_RSAPrivateKey_file := LoadFunction(fn_SSL_use_RSAPrivateKey_file);
  @f_SSL_use_PrivateKey_file := LoadFunction(fn_SSL_use_PrivateKey_file);
  @f_SSL_use_certificate_file := LoadFunction(fn_SSL_use_certificate_file);
  @f_SSL_CTX_use_RSAPrivateKey_file := LoadFunction(fn_SSL_CTX_use_RSAPrivateKey_file);
  @f_SSL_CTX_use_PrivateKey_file := LoadFunction(fn_SSL_CTX_use_PrivateKey_file);
  @f_SSL_CTX_use_certificate_file := LoadFunction(fn_SSL_CTX_use_certificate_file);
  @f_SSL_CTX_use_certificate_chain_file := LoadFunction(fn_SSL_CTX_use_certificate_chain_file);
  @f_SSL_load_client_CA_file := LoadFunction(fn_SSL_load_client_CA_file);
  @f_SSL_add_file_cert_subjects_to_stack := LoadFunction(fn_SSL_add_file_cert_subjects_to_stack);
  @f_ERR_load_SSL_strings := LoadFunction(fn_ERR_load_SSL_strings);
  @f_SSL_load_error_strings := LoadFunction(fn_SSL_load_error_strings);
  @f_SSL_state_string := LoadFunction(fn_SSL_state_string);
  @f_SSL_rstate_string := LoadFunction(fn_SSL_rstate_string);
  @f_SSL_state_string_long := LoadFunction(fn_SSL_state_string_long);
  @f_SSL_rstate_string_long := LoadFunction(fn_SSL_rstate_string_long);
  @f_SSL_SESSION_get_time := LoadFunction(fn_SSL_SESSION_get_time);
  @f_SSL_SESSION_set_time := LoadFunction(fn_SSL_SESSION_set_time);
  @f_SSL_SESSION_get_timeout := LoadFunction(fn_SSL_SESSION_get_timeout);
  @f_SSL_SESSION_set_timeout := LoadFunction(fn_SSL_SESSION_set_timeout);
  @f_SSL_copy_session_id := LoadFunction(fn_SSL_copy_session_id);
  @f_SSL_SESSION_new := LoadFunction(fn_SSL_SESSION_new);
  @f_SSL_SESSION_hash := LoadFunction(fn_SSL_SESSION_hash);
  @f_SSL_SESSION_cmp := LoadFunction(fn_SSL_SESSION_cmp);
  @f_SSL_SESSION_print_fp := LoadFunction(fn_SSL_SESSION_print_fp);
  @f_SSL_SESSION_print := LoadFunction(fn_SSL_SESSION_print);
  @f_SSL_SESSION_free := LoadFunction(fn_SSL_SESSION_free);
  @f_i2d_SSL_SESSION := LoadFunction(fn_i2d_SSL_SESSION);
  @f_SSL_set_session := LoadFunction(fn_SSL_set_session);
  @f_SSL_CTX_add_session := LoadFunction(fn_SSL_CTX_add_session);
  @f_SSL_CTX_remove_session := LoadFunction(fn_SSL_CTX_remove_session);
  @f_d2i_SSL_SESSION := LoadFunction(fn_d2i_SSL_SESSION);
  @f_SSL_get_peer_certificate := LoadFunction(fn_SSL_get_peer_certificate);
  @f_SSL_get_peer_cert_chain := LoadFunction(fn_SSL_get_peer_cert_chain);
  @f_SSL_CTX_get_verify_mode := LoadFunction(fn_SSL_CTX_get_verify_mode);
  @f_SSL_CTX_get_verify_depth := LoadFunction(fn_SSL_CTX_get_verify_depth);
  @f_SSL_CTX_set_verify := LoadFunction(fn_SSL_CTX_set_verify);
  @f_SSL_CTX_set_verify_depth := LoadFunction(fn_SSL_CTX_set_verify_depth);
  @f_SSL_CTX_set_cert_verify_callback := LoadFunction(fn_SSL_CTX_set_cert_verify_callback);
  @f_SSL_CTX_use_RSAPrivateKey := LoadFunction(fn_SSL_CTX_use_RSAPrivateKey);
  @f_SSL_CTX_use_RSAPrivateKey_ASN1 := LoadFunction(fn_SSL_CTX_use_RSAPrivateKey_ASN1);
  @f_SSL_CTX_use_PrivateKey := LoadFunction(fn_SSL_CTX_use_PrivateKey);
  @f_SSL_CTX_use_PrivateKey_ASN1 := LoadFunction(fn_SSL_CTX_use_PrivateKey_ASN1);
  @f_SSL_CTX_use_certificate := LoadFunction(fn_SSL_CTX_use_certificate);
  @f_SSL_CTX_use_certificate_ASN1 := LoadFunction(fn_SSL_CTX_use_certificate_ASN1);
  @f_SSL_CTX_set_default_passwd_cb := LoadFunction(fn_SSL_CTX_set_default_passwd_cb);
  @f_SSL_CTX_set_default_passwd_cb_userdata := LoadFunction(fn_SSL_CTX_set_default_passwd_cb_userdata);
  @f_SSL_CTX_check_private_key := LoadFunction(fn_SSL_CTX_check_private_key);
  @f_SSL_check_private_key := LoadFunction(fn_SSL_check_private_key);
  @f_SSL_CTX_set_session_id_context := LoadFunction(fn_SSL_CTX_set_session_id_context);
  @f_SSL_new := LoadFunction(fn_SSL_new);
  @f_SSL_set_session_id_context := LoadFunction(fn_SSL_set_session_id_context);
  @f_SSL_free := LoadFunction(fn_SSL_free);
  @f_SSL_accept := LoadFunction(fn_SSL_accept);
  @f_SSL_connect := LoadFunction(fn_SSL_connect);
  @f_SSL_read := LoadFunction(fn_SSL_read);
  @f_SSL_peek := LoadFunction(fn_SSL_peek);
  @f_SSL_write := LoadFunction(fn_SSL_write);
  @f_SSL_ctrl := LoadFunction(fn_SSL_ctrl);
  @f_SSL_CTX_ctrl := LoadFunction(fn_SSL_CTX_ctrl);
  @f_SSL_get_error := LoadFunction(fn_SSL_get_error);
  @f_SSL_get_version := LoadFunction(fn_SSL_get_version);
  @f_SSL_CTX_set_ssl_version := LoadFunction(fn_SSL_CTX_set_ssl_version);
  @f_SSLv2_method := LoadFunction(fn_SSLv2_method);
  @f_SSLv2_server_method := LoadFunction(fn_SSLv2_server_method);
  @f_SSLv2_client_method := LoadFunction(fn_SSLv2_client_method);
  @f_SSLv3_method := LoadFunction(fn_SSLv3_method);
  @f_SSLv3_server_method := LoadFunction(fn_SSLv3_server_method);
  @f_SSLv3_client_method := LoadFunction(fn_SSLv3_client_method);
  @f_SSLv23_method := LoadFunction(fn_SSLv23_method);
  @f_SSLv23_server_method := LoadFunction(fn_SSLv23_server_method);
  @f_SSLv23_client_method := LoadFunction(fn_SSLv23_client_method);
  @f_TLSv1_method := LoadFunction(fn_TLSv1_method);
  @f_TLSv1_server_method := LoadFunction(fn_TLSv1_server_method);
  @f_TLSv1_client_method := LoadFunction(fn_TLSv1_client_method);
  @f_SSL_get_ciphers := LoadFunction(fn_SSL_get_ciphers);
  @f_SSL_do_handshake := LoadFunction(fn_SSL_do_handshake);
  @f_SSL_renegotiate := LoadFunction(fn_SSL_renegotiate);
  @f_SSL_shutdown := LoadFunction(fn_SSL_shutdown);
  @f_SSL_get_ssl_method := LoadFunction(fn_SSL_get_ssl_method);
  @f_SSL_set_ssl_method := LoadFunction(fn_SSL_set_ssl_method);
  @f_SSL_alert_type_string_long := LoadFunction(fn_SSL_alert_type_string_long);
  @f_SSL_alert_type_string := LoadFunction(fn_SSL_alert_type_string);
  @f_SSL_alert_desc_string_long := LoadFunction(fn_SSL_alert_desc_string_long);
  @f_SSL_alert_desc_string := LoadFunction(fn_SSL_alert_desc_string);
  @f_SSL_set_client_CA_list := LoadFunction(fn_SSL_set_client_CA_list);
  @f_SSL_CTX_set_client_CA_list := LoadFunction(fn_SSL_CTX_set_client_CA_list);
  @f_SSL_get_client_CA_list := LoadFunction(fn_SSL_get_client_CA_list);
  @f_SSL_CTX_get_client_CA_list := LoadFunction(fn_SSL_CTX_get_client_CA_list);
  @f_SSL_add_client_CA := LoadFunction(fn_SSL_add_client_CA);
  @f_SSL_CTX_add_client_CA := LoadFunction(fn_SSL_CTX_add_client_CA);
  @f_SSL_set_connect_state := LoadFunction(fn_SSL_set_connect_state);
  @f_SSL_set_accept_state := LoadFunction(fn_SSL_set_accept_state);
  @f_SSL_get_default_timeout := LoadFunction(fn_SSL_get_default_timeout);
  @f_SSL_library_init := LoadFunction(fn_SSL_library_init);
  @f_SSL_CIPHER_description := LoadFunction(fn_SSL_CIPHER_description);
  @f_SSL_dup_CA_list := LoadFunction(fn_SSL_dup_CA_list);
  @f_SSL_dup := LoadFunction(fn_SSL_dup);
  @f_SSL_get_certificate := LoadFunction(fn_SSL_get_certificate);
  @f_SSL_get_privatekey := LoadFunction(fn_SSL_get_privatekey);
  @f_SSL_CTX_set_quiet_shutdown := LoadFunction(fn_SSL_CTX_set_quiet_shutdown);
  @f_SSL_CTX_get_quiet_shutdown := LoadFunction(fn_SSL_CTX_get_quiet_shutdown);
  @f_SSL_set_quiet_shutdown := LoadFunction(fn_SSL_set_quiet_shutdown);
  @f_SSL_get_quiet_shutdown := LoadFunction(fn_SSL_get_quiet_shutdown);
  @f_SSL_set_shutdown := LoadFunction(fn_SSL_set_shutdown);
  @f_SSL_get_shutdown := LoadFunction(fn_SSL_get_shutdown);
  @f_SSL_version := LoadFunction(fn_SSL_version);
  @f_SSL_CTX_set_default_verify_paths := LoadFunction(fn_SSL_CTX_set_default_verify_paths);
  @f_SSL_CTX_load_verify_locations := LoadFunction(fn_SSL_CTX_load_verify_locations);
  @f_SSL_get_session := LoadFunction(fn_SSL_get_session);
  @f_SSL_get_SSL_CTX := LoadFunction(fn_SSL_get_SSL_CTX);
  @f_SSL_set_info_callback := LoadFunction(fn_SSL_set_info_callback);
  @f_SSL_state := LoadFunction(fn_SSL_state);
  @f_SSL_set_verify_result := LoadFunction(fn_SSL_set_verify_result);
  @f_SSL_get_verify_result := LoadFunction(fn_SSL_get_verify_result);
  @f_SSL_set_ex_data := LoadFunction(fn_SSL_set_ex_data);
  @f_SSL_get_ex_data := LoadFunction(fn_SSL_get_ex_data);
  @f_SSL_get_ex_new_index := LoadFunction(fn_SSL_get_ex_new_index);
  @f_SSL_SESSION_set_ex_data := LoadFunction(fn_SSL_SESSION_set_ex_data);
  @f_SSL_SESSION_get_ex_data := LoadFunction(fn_SSL_SESSION_get_ex_data);
  @f_SSL_SESSION_get_ex_new_index := LoadFunction(fn_SSL_SESSION_get_ex_new_index);
  @f_SSL_CTX_set_ex_data := LoadFunction(fn_SSL_CTX_set_ex_data);
  @f_SSL_CTX_get_ex_data := LoadFunction(fn_SSL_CTX_get_ex_data);
  @f_SSL_CTX_get_ex_new_index := LoadFunction(fn_SSL_CTX_get_ex_new_index);
  @f_SSL_get_ex_data_X509_STORE_CTX_idx := LoadFunction(fn_SSL_get_ex_data_X509_STORE_CTX_idx);
  @f_SSL_CTX_set_tmp_rsa_callback := LoadFunction(fn_SSL_CTX_set_tmp_rsa_callback);
  @f_SSL_set_tmp_rsa_callback := LoadFunction(fn_SSL_set_tmp_rsa_callback);
  @f_SSL_CTX_set_tmp_dh_callback := LoadFunction(fn_SSL_CTX_set_tmp_dh_callback);
  @f_SSL_set_tmp_dh_callback := LoadFunction(fn_SSL_set_tmp_dh_callback);
  @f_SSL_COMP_add_compression_method := LoadFunction(fn_SSL_COMP_add_compression_method);
  @f_SSLeay_add_ssl_algorithms := LoadFunction(fn_SSLeay_add_ssl_algorithms);
  @f_SSL_set_app_data := LoadFunction(fn_SSL_set_app_data);
  @f_SSL_get_app_data := LoadFunction(fn_SSL_get_app_data);
  @f_SSL_CTX_set_info_callback := LoadFunction(fn_SSL_CTX_set_info_callback);
  @f_SSL_CTX_set_options := LoadFunction(fn_SSL_CTX_set_options);
  @f_SSL_is_init_finished := LoadFunction(fn_SSL_is_init_finished);
  @f_SSL_in_init := LoadFunction(fn_SSL_in_init);
  @f_SSL_in_before := LoadFunction(fn_SSL_in_before);
  @f_SSL_in_connect_init := LoadFunction(fn_SSL_in_connect_init);
  @f_SSL_in_accept_init := LoadFunction(fn_SSL_in_accept_init);
  @f_X509_STORE_CTX_get_app_data := LoadFunction(fn_X509_STORE_CTX_get_app_data);
  @f_X509_get_notBefore := LoadFunction(fn_X509_get_notBefore);
  @f_X509_get_notAfter := LoadFunction(fn_X509_get_notAfter);
  @f_UCTTimeDecode := LoadFunction(fn_UCTTimeDecode);
  @f_SSL_CTX_get_version := LoadFunction(fn_SSL_CTX_get_version);
  @f_SSL_SESSION_get_id := LoadFunction(fn_SSL_SESSION_get_id);
  @f_SSL_SESSION_get_id_ctx := LoadFunction(fn_SSL_SESSION_get_id_ctx);
  @f_fopen := LoadFunction(fn_fopen);
  @f_fclose := LoadFunction(fn_fclose);

  result := (@f_sk_num<>nil) and (@f_sk_value<>nil) and (@f_sk_set<>nil) and 
   (@f_sk_new<>nil) and (@f_sk_free<>nil) and (@f_sk_pop_free<>nil) and (@f_sk_insert<>nil) and 
   (@f_sk_delete<>nil) and (@f_sk_delete_ptr<>nil) and (@f_sk_find<>nil) and (@f_sk_push<>nil) and 
   (@f_sk_unshift<>nil) and (@f_sk_shift<>nil) and (@f_sk_pop<>nil) and (@f_sk_zero<>nil) and 
   (@f_sk_dup<>nil) and (@f_sk_sort<>nil) and (@f_SSLeay_version<>nil) and (@f_SSLeay<>nil) and 
   (@f_CRYPTO_get_ex_new_index<>nil) and (@f_CRYPTO_set_ex_data<>nil) and (@f_CRYPTO_get_ex_data<>nil) and (@f_CRYPTO_dup_ex_data<>nil) and 
   (@f_CRYPTO_free_ex_data<>nil) and (@f_CRYPTO_new_ex_data<>nil) and (@f_CRYPTO_mem_ctrl<>nil) and (@f_CRYPTO_get_new_lockid<>nil) and 
   (@f_CRYPTO_num_locks<>nil) and (@f_CRYPTO_lock<>nil) and (@f_CRYPTO_set_locking_callback<>nil) and (@f_CRYPTO_set_add_lock_callback<>nil) and 
   (@f_CRYPTO_set_id_callback<>nil) and (@f_CRYPTO_thread_id<>nil) and (@f_CRYPTO_get_lock_name<>nil) and (@f_CRYPTO_add_lock<>nil) and 
   (@f_CRYPTO_set_mem_functions<>nil) and (@f_CRYPTO_get_mem_functions<>nil) and (@f_CRYPTO_set_locked_mem_functions<>nil) and (@f_CRYPTO_get_locked_mem_functions<>nil) and 
   (@f_CRYPTO_malloc_locked<>nil) and (@f_CRYPTO_free_locked<>nil) and (@f_CRYPTO_malloc<>nil) and (@f_CRYPTO_free<>nil) and 
   (@f_CRYPTO_realloc<>nil) and (@f_CRYPTO_remalloc<>nil) and (@f_CRYPTO_dbg_malloc<>nil) and (@f_CRYPTO_dbg_realloc<>nil) and 
   (@f_CRYPTO_dbg_free<>nil) and (@f_CRYPTO_dbg_remalloc<>nil) and (@f_CRYPTO_mem_leaks_fp<>nil) and (@f_CRYPTO_mem_leaks<>nil) and 
   (@f_CRYPTO_mem_leaks_cb<>nil) and (@f_ERR_load_CRYPTO_strings<>nil) and (@f_lh_new<>nil) and (@f_lh_free<>nil) and 
   (@f_lh_insert<>nil) and (@f_lh_delete<>nil) and (@f_lh_retrieve<>nil) and (@f_lh_doall<>nil) and 
   (@f_lh_doall_arg<>nil) and (@f_lh_strhash<>nil) and (@f_lh_stats<>nil) and (@f_lh_node_stats<>nil) and 
   (@f_lh_node_usage_stats<>nil) and (@f_BUF_MEM_new<>nil) and (@f_BUF_MEM_free<>nil) and (@f_BUF_MEM_grow<>nil) and 
   (@f_BUF_strdup<>nil) and (@f_ERR_load_BUF_strings<>nil) and (@f_BIO_ctrl_pending<>nil) and (@f_BIO_ctrl_wpending<>nil) and 
   (@f_BIO_ctrl_get_write_guarantee<>nil) and (@f_BIO_ctrl_get_read_request<>nil) and (@f_BIO_set_ex_data<>nil) and (@f_BIO_get_ex_data<>nil) and 
   (@f_BIO_get_ex_new_index<>nil) and (@f_BIO_s_file<>nil) and (@f_BIO_new_file<>nil) and (@f_BIO_new_fp<>nil) and 
   (@f_BIO_new<>nil) and (@f_BIO_set<>nil) and (@f_BIO_free<>nil) and (@f_BIO_read<>nil) and 
   (@f_BIO_gets<>nil) and (@f_BIO_write<>nil) and (@f_BIO_puts<>nil) and (@f_BIO_ctrl<>nil) and 
   (@f_BIO_ptr_ctrl<>nil) and (@f_BIO_int_ctrl<>nil) and (@f_BIO_push<>nil) and (@f_BIO_pop<>nil) and 
   (@f_BIO_free_all<>nil) and (@f_BIO_find_type<>nil) and (@f_BIO_get_retry_BIO<>nil) and (@f_BIO_get_retry_reason<>nil) and 
   (@f_BIO_dup_chain<>nil) and (@f_BIO_debug_callback<>nil) and (@f_BIO_s_mem<>nil) and (@f_BIO_s_socket<>nil) and 
   (@f_BIO_s_connect<>nil) and (@f_BIO_s_accept<>nil) and (@f_BIO_s_fd<>nil) and (@f_BIO_s_bio<>nil) and 
   (@f_BIO_s_null<>nil) and (@f_BIO_f_null<>nil) and (@f_BIO_f_buffer<>nil) and (@f_BIO_f_nbio_test<>nil) and 
   (@f_BIO_sock_should_retry<>nil) and (@f_BIO_sock_non_fatal_error<>nil) and (@f_BIO_fd_should_retry<>nil) and (@f_BIO_fd_non_fatal_error<>nil) and 
   (@f_BIO_dump<>nil) and (@f_BIO_gethostbyname<>nil) and (@f_BIO_sock_error<>nil) and (@f_BIO_socket_ioctl<>nil) and 
   (@f_BIO_socket_nbio<>nil) and (@f_BIO_get_port<>nil) and (@f_BIO_get_host_ip<>nil) and (@f_BIO_get_accept_socket<>nil) and 
   (@f_BIO_accept<>nil) and (@f_BIO_sock_init<>nil) and (@f_BIO_sock_cleanup<>nil) and (@f_BIO_set_tcp_ndelay<>nil) and 
   (@f_ERR_load_BIO_strings<>nil) and (@f_BIO_new_socket<>nil) and (@f_BIO_new_fd<>nil) and (@f_BIO_new_connect<>nil) and 
   (@f_BIO_new_accept<>nil) and (@f_BIO_new_bio_pair<>nil) and (@f_BIO_copy_next_retry<>nil) and (@f_BIO_ghbn_ctrl<>nil) and 
   (@f_MD2_options<>nil) and (@f_MD2_Init<>nil) and (@f_MD2_Update<>nil) and (@f_MD2_Final<>nil) and 
   (@f_MD2<>nil) and (@f_MD5_Init<>nil) and (@f_MD5_Update<>nil) and (@f_MD5_Final<>nil) and 
   (@f_MD5<>nil) and (@f_MD5_Transform<>nil) and (@f_SHA_Init<>nil) and (@f_SHA_Update<>nil) and 
   (@f_SHA_Final<>nil) and (@f_SHA<>nil) and (@f_SHA_Transform<>nil) and (@f_SHA1_Init<>nil) and 
   (@f_SHA1_Update<>nil) and (@f_SHA1_Final<>nil) and (@f_SHA1<>nil) and (@f_SHA1_Transform<>nil) and 
   (@f_RIPEMD160_Init<>nil) and (@f_RIPEMD160_Update<>nil) and (@f_RIPEMD160_Final<>nil) and (@f_RIPEMD160<>nil) and 
   (@f_RIPEMD160_Transform<>nil) and (@f_des_options<>nil) and (@f_des_ecb3_encrypt<>nil) and (@f_des_cbc_cksum<>nil) and 
   (@f_des_cbc_encrypt<>nil) and (@f_des_ncbc_encrypt<>nil) and (@f_des_xcbc_encrypt<>nil) and (@f_des_cfb_encrypt<>nil) and 
   (@f_des_ecb_encrypt<>nil) and (@f_des_encrypt<>nil) and (@f_des_encrypt2<>nil) and (@f_des_encrypt3<>nil) and 
   (@f_des_decrypt3<>nil) and (@f_des_ede3_cbc_encrypt<>nil) and (@f_des_ede3_cbcm_encrypt<>nil) and (@f_des_ede3_cfb64_encrypt<>nil) and 
   (@f_des_ede3_ofb64_encrypt<>nil) and (@f_des_xwhite_in2out<>nil) and (@f_des_enc_read<>nil) and (@f_des_enc_write<>nil) and 
   (@f_des_fcrypt<>nil) and (@f_crypt<>nil) and (@f_des_ofb_encrypt<>nil) and (@f_des_pcbc_encrypt<>nil) and 
   (@f_des_quad_cksum<>nil) and (@f_des_random_seed<>nil) and (@f_des_random_key<>nil) and (@f_des_read_password<>nil) and 
   (@f_des_read_2passwords<>nil) and (@f_des_read_pw_string<>nil) and (@f_des_set_odd_parity<>nil) and (@f_des_is_weak_key<>nil) and 
   (@f_des_set_key<>nil) and (@f_des_key_sched<>nil) and (@f_des_string_to_key<>nil) and (@f_des_string_to_2keys<>nil) and 
   (@f_des_cfb64_encrypt<>nil) and (@f_des_ofb64_encrypt<>nil) and (@f_des_read_pw<>nil) and (@f_des_cblock_print_file<>nil) and 
   (@f_RC4_options<>nil) and (@f_RC4_set_key<>nil) and (@f_RC4<>nil) and (@f_RC2_set_key<>nil) and 
   (@f_RC2_ecb_encrypt<>nil) and (@f_RC2_encrypt<>nil) and (@f_RC2_decrypt<>nil) and (@f_RC2_cbc_encrypt<>nil) and 
   (@f_RC2_cfb64_encrypt<>nil) and (@f_RC2_ofb64_encrypt<>nil) and (@f_RC5_32_set_key<>nil) and (@f_RC5_32_ecb_encrypt<>nil) and 
   (@f_RC5_32_encrypt<>nil) and (@f_RC5_32_decrypt<>nil) and (@f_RC5_32_cbc_encrypt<>nil) and (@f_RC5_32_cfb64_encrypt<>nil) and 
   (@f_RC5_32_ofb64_encrypt<>nil) and (@f_BF_set_key<>nil) and (@f_BF_ecb_encrypt<>nil) and (@f_BF_encrypt<>nil) and 
   (@f_BF_decrypt<>nil) and (@f_BF_cbc_encrypt<>nil) and (@f_BF_cfb64_encrypt<>nil) and (@f_BF_ofb64_encrypt<>nil) and 
   (@f_BF_options<>nil) and (@f_CAST_set_key<>nil) and (@f_CAST_ecb_encrypt<>nil) and (@f_CAST_encrypt<>nil) and 
   (@f_CAST_decrypt<>nil) and (@f_CAST_cbc_encrypt<>nil) and (@f_CAST_cfb64_encrypt<>nil) and (@f_CAST_ofb64_encrypt<>nil) and 
   (@f_idea_options<>nil) and (@f_idea_ecb_encrypt<>nil) and (@f_idea_set_encrypt_key<>nil) and (@f_idea_set_decrypt_key<>nil) and 
   (@f_idea_cbc_encrypt<>nil) and (@f_idea_cfb64_encrypt<>nil) and (@f_idea_ofb64_encrypt<>nil) and (@f_idea_encrypt<>nil) and 
   (@f_MDC2_Init<>nil) and (@f_MDC2_Update<>nil) and (@f_MDC2_Final<>nil) and (@f_MDC2<>nil) and 
   (@f_BN_value_one<>nil) and (@f_BN_options<>nil) and (@f_BN_CTX_new<>nil) and (@f_BN_CTX_init<>nil) and 
   (@f_BN_CTX_free<>nil) and (@f_BN_rand<>nil) and (@f_BN_num_bits<>nil) and (@f_BN_num_bits_word<>nil) and 
   (@f_BN_new<>nil) and (@f_BN_init<>nil) and (@f_BN_clear_free<>nil) and (@f_BN_copy<>nil) and 
   (@f_BN_bin2bn<>nil) and (@f_BN_bn2bin<>nil) and (@f_BN_mpi2bn<>nil) and (@f_BN_bn2mpi<>nil) and 
   (@f_BN_sub<>nil) and (@f_BN_usub<>nil) and (@f_BN_uadd<>nil) and (@f_BN_add<>nil) and 
   (@f_BN_mod<>nil) and (@f_BN_div<>nil) and (@f_BN_mul<>nil) and (@f_BN_sqr<>nil) and 
   (@f_BN_mod_word<>nil) and (@f_BN_div_word<>nil) and (@f_BN_mul_word<>nil) and (@f_BN_add_word<>nil) and 
   (@f_BN_sub_word<>nil) and (@f_BN_set_word<>nil) and (@f_BN_get_word<>nil) and (@f_BN_cmp<>nil) and 
   (@f_BN_free<>nil) and (@f_BN_is_bit_set<>nil) and (@f_BN_lshift<>nil) and (@f_BN_lshift1<>nil) and 
   (@f_BN_exp<>nil) and (@f_BN_mod_exp<>nil) and (@f_BN_mod_exp_mont<>nil) and (@f_BN_mod_exp2_mont<>nil) and 
   (@f_BN_mod_exp_simple<>nil) and (@f_BN_mask_bits<>nil) and (@f_BN_mod_mul<>nil) and (@f_BN_print_fp<>nil) and 
   (@f_BN_print<>nil) and (@f_BN_reciprocal<>nil) and (@f_BN_rshift<>nil) and (@f_BN_rshift1<>nil) and 
   (@f_BN_clear<>nil) and (@f_bn_expand2<>nil) and (@f_BN_dup<>nil) and (@f_BN_ucmp<>nil) and 
   (@f_BN_set_bit<>nil) and (@f_BN_clear_bit<>nil) and (@f_BN_bn2hex<>nil) and (@f_BN_bn2dec<>nil) and 
   (@f_BN_hex2bn<>nil) and (@f_BN_dec2bn<>nil) and (@f_BN_gcd<>nil) and (@f_BN_mod_inverse<>nil) and 
   (@f_BN_generate_prime<>nil) and (@f_BN_is_prime<>nil) and (@f_ERR_load_BN_strings<>nil) and (@f_bn_mul_add_words<>nil) and 
   (@f_bn_mul_words<>nil) and (@f_bn_sqr_words<>nil) and (@f_bn_div_words<>nil) and (@f_bn_add_words<>nil) and 
   (@f_bn_sub_words<>nil) and (@f_BN_MONT_CTX_new<>nil) and (@f_BN_MONT_CTX_init<>nil) and (@f_BN_mod_mul_montgomery<>nil) and 
   (@f_BN_from_montgomery<>nil) and (@f_BN_MONT_CTX_free<>nil) and (@f_BN_MONT_CTX_set<>nil) and (@f_BN_MONT_CTX_copy<>nil) and 
   (@f_BN_BLINDING_new<>nil) and (@f_BN_BLINDING_free<>nil) and (@f_BN_BLINDING_update<>nil) and (@f_BN_BLINDING_convert<>nil) and 
   (@f_BN_BLINDING_invert<>nil) and (@f_BN_set_params<>nil) and (@f_BN_get_params<>nil) and (@f_BN_RECP_CTX_init<>nil) and 
   (@f_BN_RECP_CTX_new<>nil) and (@f_BN_RECP_CTX_free<>nil) and (@f_BN_RECP_CTX_set<>nil) and (@f_BN_mod_mul_reciprocal<>nil) and 
   (@f_BN_mod_exp_recp<>nil) and (@f_BN_div_recp<>nil) and (@f_RSA_new<>nil) and (@f_RSA_new_method<>nil) and 
   (@f_RSA_size<>nil) and (@f_RSA_generate_key<>nil) and (@f_RSA_check_key<>nil) and (@f_RSA_public_encrypt<>nil) and 
   (@f_RSA_private_encrypt<>nil) and (@f_RSA_public_decrypt<>nil) and (@f_RSA_private_decrypt<>nil) and (@f_RSA_free<>nil) and 
   (@f_RSA_flags<>nil) and (@f_RSA_set_default_method<>nil) and (@f_RSA_get_default_method<>nil) and (@f_RSA_get_method<>nil) and 
   (@f_RSA_set_method<>nil) and (@f_RSA_memory_lock<>nil) and (@f_RSA_PKCS1_SSLeay<>nil) and (@f_ERR_load_RSA_strings<>nil) and 
   (@f_d2i_RSAPublicKey<>nil) and (@f_i2d_RSAPublicKey<>nil) and (@f_d2i_RSAPrivateKey<>nil) and (@f_i2d_RSAPrivateKey<>nil) and 
   (@f_RSA_print_fp<>nil) and (@f_RSA_print<>nil) and (@f_i2d_Netscape_RSA<>nil) and (@f_d2i_Netscape_RSA<>nil) and 
   (@f_d2i_Netscape_RSA_2<>nil) and (@f_RSA_sign<>nil) and (@f_RSA_verify<>nil) and (@f_RSA_sign_ASN1_OCTET_STRING<>nil) and 
   (@f_RSA_verify_ASN1_OCTET_STRING<>nil) and (@f_RSA_blinding_on<>nil) and (@f_RSA_blinding_off<>nil) and (@f_RSA_padding_add_PKCS1_type_1<>nil) and 
   (@f_RSA_padding_check_PKCS1_type_1<>nil) and (@f_RSA_padding_add_PKCS1_type_2<>nil) and (@f_RSA_padding_check_PKCS1_type_2<>nil) and (@f_RSA_padding_add_PKCS1_OAEP<>nil) and 
   (@f_RSA_padding_check_PKCS1_OAEP<>nil) and (@f_RSA_padding_add_SSLv23<>nil) and (@f_RSA_padding_check_SSLv23<>nil) and (@f_RSA_padding_add_none<>nil) and 
   (@f_RSA_padding_check_none<>nil) and (@f_RSA_get_ex_new_index<>nil) and (@f_RSA_set_ex_data<>nil) and (@f_RSA_get_ex_data<>nil) and 
   (@f_DH_new<>nil) and (@f_DH_free<>nil) and (@f_DH_size<>nil) and (@f_DH_generate_parameters<>nil) and 
   (@f_DH_check<>nil) and (@f_DH_generate_key<>nil) and (@f_DH_compute_key<>nil) and (@f_d2i_DHparams<>nil) and 
   (@f_i2d_DHparams<>nil) and (@f_DHparams_print_fp<>nil) and (@f_DHparams_print<>nil) and (@f_ERR_load_DH_strings<>nil) and 
   (@f_DSA_SIG_new<>nil) and (@f_DSA_SIG_free<>nil) and (@f_i2d_DSA_SIG<>nil) and (@f_d2i_DSA_SIG<>nil) and 
   (@f_DSA_do_sign<>nil) and (@f_DSA_do_verify<>nil) and (@f_DSA_new<>nil) and (@f_DSA_size<>nil) and 
   (@f_DSA_sign_setup<>nil) and (@f_DSA_sign<>nil) and (@f_DSA_verify<>nil) and (@f_DSA_free<>nil) and 
   (@f_ERR_load_DSA_strings<>nil) and (@f_d2i_DSAPublicKey<>nil) and (@f_d2i_DSAPrivateKey<>nil) and (@f_d2i_DSAparams<>nil) and 
   (@f_DSA_generate_parameters<>nil) and (@f_DSA_generate_key<>nil) and (@f_i2d_DSAPublicKey<>nil) and (@f_i2d_DSAPrivateKey<>nil) and 
   (@f_i2d_DSAparams<>nil) and (@f_DSAparams_print<>nil) and (@f_DSA_print<>nil) and (@f_DSAparams_print_fp<>nil) and 
   (@f_DSA_print_fp<>nil) and (@f_DSA_is_prime<>nil) and (@f_DSA_dup_DH<>nil) and (@f_sk_ASN1_TYPE_new<>nil) and 
   (@f_sk_ASN1_TYPE_new_null<>nil) and (@f_sk_ASN1_TYPE_free<>nil) and (@f_sk_ASN1_TYPE_num<>nil) and (@f_sk_ASN1_TYPE_value<>nil) and 
   (@f_sk_ASN1_TYPE_set<>nil) and (@f_sk_ASN1_TYPE_zero<>nil) and (@f_sk_ASN1_TYPE_push<>nil) and (@f_sk_ASN1_TYPE_unshift<>nil) and 
   (@f_sk_ASN1_TYPE_find<>nil) and (@f_sk_ASN1_TYPE_delete<>nil) and (@f_sk_ASN1_TYPE_delete_ptr<>nil) and (@f_sk_ASN1_TYPE_insert<>nil) and 
   (@f_sk_ASN1_TYPE_dup<>nil) and (@f_sk_ASN1_TYPE_pop_free<>nil) and (@f_sk_ASN1_TYPE_shift<>nil) and (@f_sk_ASN1_TYPE_pop<>nil) and 
   (@f_sk_ASN1_TYPE_sort<>nil) and (@f_i2d_ASN1_SET_OF_ASN1_TYPE<>nil) and (@f_d2i_ASN1_SET_OF_ASN1_TYPE<>nil) and (@f_ASN1_TYPE_new<>nil) and 
   (@f_ASN1_TYPE_free<>nil) and (@f_i2d_ASN1_TYPE<>nil) and (@f_d2i_ASN1_TYPE<>nil) and (@f_ASN1_TYPE_get<>nil) and 
   (@f_ASN1_TYPE_set<>nil) and (@f_ASN1_OBJECT_new<>nil) and (@f_ASN1_OBJECT_free<>nil) and (@f_i2d_ASN1_OBJECT<>nil) and 
   (@f_d2i_ASN1_OBJECT<>nil) and (@f_sk_ASN1_OBJECT_new<>nil) and (@f_sk_ASN1_OBJECT_new_null<>nil) and (@f_sk_ASN1_OBJECT_free<>nil) and 
   (@f_sk_ASN1_OBJECT_num<>nil) and (@f_sk_ASN1_OBJECT_value<>nil) and (@f_sk_ASN1_OBJECT_set<>nil) and (@f_sk_ASN1_OBJECT_zero<>nil) and 
   (@f_sk_ASN1_OBJECT_push<>nil) and (@f_sk_ASN1_OBJECT_unshift<>nil) and (@f_sk_ASN1_OBJECT_find<>nil) and (@f_sk_ASN1_OBJECT_delete<>nil) and 
   (@f_sk_ASN1_OBJECT_delete_ptr<>nil) and (@f_sk_ASN1_OBJECT_insert<>nil) and (@f_sk_ASN1_OBJECT_dup<>nil) and (@f_sk_ASN1_OBJECT_pop_free<>nil) and 
   (@f_sk_ASN1_OBJECT_shift<>nil) and (@f_sk_ASN1_OBJECT_pop<>nil) and (@f_sk_ASN1_OBJECT_sort<>nil) and (@f_i2d_ASN1_SET_OF_ASN1_OBJECT<>nil) and 
   (@f_d2i_ASN1_SET_OF_ASN1_OBJECT<>nil) and (@f_ASN1_STRING_new<>nil) and (@f_ASN1_STRING_free<>nil) and (@f_ASN1_STRING_dup<>nil) and 
   (@f_ASN1_STRING_type_new<>nil) and (@f_ASN1_STRING_cmp<>nil) and (@f_ASN1_STRING_set<>nil) and (@f_i2d_ASN1_BIT_STRING<>nil) and 
   (@f_d2i_ASN1_BIT_STRING<>nil) and (@f_ASN1_BIT_STRING_set_bit<>nil) and (@f_ASN1_BIT_STRING_get_bit<>nil) and (@f_i2d_ASN1_BOOLEAN<>nil) and 
   (@f_d2i_ASN1_BOOLEAN<>nil) and (@f_i2d_ASN1_INTEGER<>nil) and (@f_d2i_ASN1_INTEGER<>nil) and (@f_d2i_ASN1_UINTEGER<>nil) and 
   (@f_i2d_ASN1_ENUMERATED<>nil) and (@f_d2i_ASN1_ENUMERATED<>nil) and (@f_ASN1_UTCTIME_check<>nil) and (@f_ASN1_UTCTIME_set<>nil) and 
   (@f_ASN1_UTCTIME_set_string<>nil) and (@f_ASN1_GENERALIZEDTIME_check<>nil) and (@f_ASN1_GENERALIZEDTIME_set<>nil) and (@f_ASN1_GENERALIZEDTIME_set_string<>nil) and 
   (@f_i2d_ASN1_OCTET_STRING<>nil) and (@f_d2i_ASN1_OCTET_STRING<>nil) and (@f_i2d_ASN1_VISIBLESTRING<>nil) and (@f_d2i_ASN1_VISIBLESTRING<>nil) and 
   (@f_i2d_ASN1_UTF8STRING<>nil) and (@f_d2i_ASN1_UTF8STRING<>nil) and (@f_i2d_ASN1_BMPSTRING<>nil) and (@f_d2i_ASN1_BMPSTRING<>nil) and 
   (@f_i2d_ASN1_PRINTABLE<>nil) and (@f_d2i_ASN1_PRINTABLE<>nil) and (@f_d2i_ASN1_PRINTABLESTRING<>nil) and (@f_i2d_DIRECTORYSTRING<>nil) and 
   (@f_d2i_DIRECTORYSTRING<>nil) and (@f_i2d_DISPLAYTEXT<>nil) and (@f_d2i_DISPLAYTEXT<>nil) and (@f_d2i_ASN1_T61STRING<>nil) and 
   (@f_i2d_ASN1_IA5STRING<>nil) and (@f_d2i_ASN1_IA5STRING<>nil) and (@f_i2d_ASN1_UTCTIME<>nil) and (@f_d2i_ASN1_UTCTIME<>nil) and 
   (@f_i2d_ASN1_GENERALIZEDTIME<>nil) and (@f_d2i_ASN1_GENERALIZEDTIME<>nil) and (@f_i2d_ASN1_TIME<>nil) and (@f_d2i_ASN1_TIME<>nil) and 
   (@f_ASN1_TIME_set<>nil) and (@f_i2d_ASN1_SET<>nil) and (@f_d2i_ASN1_SET<>nil) and (@f_i2a_ASN1_INTEGER<>nil) and 
   (@f_a2i_ASN1_INTEGER<>nil) and (@f_i2a_ASN1_ENUMERATED<>nil) and (@f_a2i_ASN1_ENUMERATED<>nil) and (@f_i2a_ASN1_OBJECT<>nil) and 
   (@f_a2i_ASN1_STRING<>nil) and (@f_i2a_ASN1_STRING<>nil) and (@f_i2t_ASN1_OBJECT<>nil) and (@f_a2d_ASN1_OBJECT<>nil) and 
   (@f_ASN1_OBJECT_create<>nil) and (@f_ASN1_INTEGER_set<>nil) and (@f_ASN1_INTEGER_get<>nil) and (@f_BN_to_ASN1_INTEGER<>nil) and 
   (@f_ASN1_INTEGER_to_BN<>nil) and (@f_ASN1_ENUMERATED_set<>nil) and (@f_ASN1_ENUMERATED_get<>nil) and (@f_BN_to_ASN1_ENUMERATED<>nil) and 
   (@f_ASN1_ENUMERATED_to_BN<>nil) and (@f_ASN1_PRINTABLE_type<>nil) and (@f_i2d_ASN1_bytes<>nil) and (@f_d2i_ASN1_bytes<>nil) and 
   (@f_d2i_ASN1_type_bytes<>nil) and (@f_asn1_Finish<>nil) and (@f_ASN1_get_object<>nil) and (@f_ASN1_check_infinite_end<>nil) and 
   (@f_ASN1_put_object<>nil) and (@f_ASN1_object_size<>nil) and (@f_ASN1_dup<>nil) and (@f_ASN1_d2i_fp<>nil) and 
   (@f_ASN1_i2d_fp<>nil) and (@f_ASN1_d2i_bio<>nil) and (@f_ASN1_i2d_bio<>nil) and (@f_ASN1_UTCTIME_print<>nil) and 
   (@f_ASN1_GENERALIZEDTIME_print<>nil) and (@f_ASN1_TIME_print<>nil) and (@f_ASN1_STRING_print<>nil) and (@f_ASN1_parse<>nil) and 
   (@f_i2d_ASN1_HEADER<>nil) and (@f_d2i_ASN1_HEADER<>nil) and (@f_ASN1_HEADER_new<>nil) and (@f_ASN1_HEADER_free<>nil) and 
   (@f_ASN1_UNIVERSALSTRING_to_string<>nil) and (@f_ERR_load_ASN1_strings<>nil) and (@f_X509_asn1_meth<>nil) and (@f_RSAPrivateKey_asn1_meth<>nil) and 
   (@f_ASN1_IA5STRING_asn1_meth<>nil) and (@f_ASN1_BIT_STRING_asn1_meth<>nil) and (@f_ASN1_TYPE_set_octetstring<>nil) and (@f_ASN1_TYPE_get_octetstring<>nil) and 
   (@f_ASN1_TYPE_set_int_octetstring<>nil) and (@f_ASN1_TYPE_get_int_octetstring<>nil) and (@f_ASN1_seq_unpack<>nil) and (@f_ASN1_seq_pack<>nil) and 
   (@f_ASN1_unpack_string<>nil) and (@f_ASN1_pack_string<>nil) and (@f_OBJ_NAME_init<>nil) and (@f_OBJ_NAME_new_index<>nil) and 
   (@f_OBJ_NAME_get<>nil) and (@f_OBJ_NAME_add<>nil) and (@f_OBJ_NAME_remove<>nil) and (@f_OBJ_NAME_cleanup<>nil) and 
   (@f_OBJ_dup<>nil) and (@f_OBJ_nid2obj<>nil) and (@f_OBJ_nid2ln<>nil) and (@f_OBJ_nid2sn<>nil) and 
   (@f_OBJ_obj2nid<>nil) and (@f_OBJ_txt2obj<>nil) and (@f_OBJ_obj2txt<>nil) and (@f_OBJ_txt2nid<>nil) and 
   (@f_OBJ_ln2nid<>nil) and (@f_OBJ_sn2nid<>nil) and (@f_OBJ_cmp<>nil) and (@f_OBJ_bsearch<>nil) and 
   (@f_ERR_load_OBJ_strings<>nil) and (@f_OBJ_new_nid<>nil) and (@f_OBJ_add_object<>nil) and (@f_OBJ_create<>nil) and 
   (@f_OBJ_cleanup<>nil) and (@f_OBJ_create_objects<>nil) and (@f_EVP_MD_CTX_copy<>nil) and (@f_EVP_DigestInit<>nil) and 
   (@f_EVP_DigestUpdate<>nil) and (@f_EVP_DigestFinal<>nil) and (@f_EVP_read_pw_string<>nil) and (@f_EVP_set_pw_prompt<>nil) and 
   (@f_EVP_get_pw_prompt<>nil) and (@f_EVP_BytesToKey<>nil) and (@f_EVP_EncryptInit<>nil) and (@f_EVP_EncryptUpdate<>nil) and 
   (@f_EVP_EncryptFinal<>nil) and (@f_EVP_DecryptInit<>nil) and (@f_EVP_DecryptUpdate<>nil) and (@f_EVP_DecryptFinal<>nil) and 
   (@f_EVP_CipherInit<>nil) and (@f_EVP_CipherUpdate<>nil) and (@f_EVP_CipherFinal<>nil) and (@f_EVP_SignFinal<>nil) and 
   (@f_EVP_VerifyFinal<>nil) and (@f_EVP_OpenInit<>nil) and (@f_EVP_OpenFinal<>nil) and (@f_EVP_SealInit<>nil) and 
   (@f_EVP_SealFinal<>nil) and (@f_EVP_EncodeInit<>nil) and (@f_EVP_EncodeUpdate<>nil) and (@f_EVP_EncodeFinal<>nil) and 
   (@f_EVP_EncodeBlock<>nil) and (@f_EVP_DecodeInit<>nil) and (@f_EVP_DecodeUpdate<>nil) and (@f_EVP_DecodeFinal<>nil) and 
   (@f_EVP_DecodeBlock<>nil) and (@f_ERR_load_EVP_strings<>nil) and (@f_EVP_CIPHER_CTX_init<>nil) and (@f_EVP_CIPHER_CTX_cleanup<>nil) and 
   (@f_BIO_f_md<>nil) and (@f_BIO_f_base64<>nil) and (@f_BIO_f_cipher<>nil) and (@f_BIO_f_reliable<>nil) and 
   (@f_BIO_set_cipher<>nil) and (@f_EVP_md_null<>nil) and (@f_EVP_md2<>nil) and (@f_EVP_md5<>nil) and 
   (@f_EVP_sha<>nil) and (@f_EVP_sha1<>nil) and (@f_EVP_dss<>nil) and (@f_EVP_dss1<>nil) and 
   (@f_EVP_mdc2<>nil) and (@f_EVP_ripemd160<>nil) and (@f_EVP_enc_null<>nil) and (@f_EVP_des_ecb<>nil) and 
   (@f_EVP_des_ede<>nil) and (@f_EVP_des_ede3<>nil) and (@f_EVP_des_cfb<>nil) and (@f_EVP_des_ede_cfb<>nil) and 
   (@f_EVP_des_ede3_cfb<>nil) and (@f_EVP_des_ofb<>nil) and (@f_EVP_des_ede_ofb<>nil) and (@f_EVP_des_ede3_ofb<>nil) and 
   (@f_EVP_des_cbc<>nil) and (@f_EVP_des_ede_cbc<>nil) and (@f_EVP_des_ede3_cbc<>nil) and (@f_EVP_desx_cbc<>nil) and 
   (@f_EVP_rc4<>nil) and (@f_EVP_rc4_40<>nil) and (@f_EVP_idea_ecb<>nil) and (@f_EVP_idea_cfb<>nil) and 
   (@f_EVP_idea_ofb<>nil) and (@f_EVP_idea_cbc<>nil) and (@f_EVP_rc2_ecb<>nil) and (@f_EVP_rc2_cbc<>nil) and 
   (@f_EVP_rc2_40_cbc<>nil) and (@f_EVP_rc2_64_cbc<>nil) and (@f_EVP_rc2_cfb<>nil) and (@f_EVP_rc2_ofb<>nil) and 
   (@f_EVP_bf_ecb<>nil) and (@f_EVP_bf_cbc<>nil) and (@f_EVP_bf_cfb<>nil) and (@f_EVP_bf_ofb<>nil) and 
   (@f_EVP_cast5_ecb<>nil) and (@f_EVP_cast5_cbc<>nil) and (@f_EVP_cast5_cfb<>nil) and (@f_EVP_cast5_ofb<>nil) and 
   (@f_EVP_rc5_32_12_16_cbc<>nil) and (@f_EVP_rc5_32_12_16_ecb<>nil) and (@f_EVP_rc5_32_12_16_cfb<>nil) and (@f_EVP_rc5_32_12_16_ofb<>nil) and 
   (@f_SSLeay_add_all_algorithms<>nil) and (@f_SSLeay_add_all_ciphers<>nil) and (@f_SSLeay_add_all_digests<>nil) and (@f_EVP_add_cipher<>nil) and 
   (@f_EVP_add_digest<>nil) and (@f_EVP_get_cipherbyname<>nil) and (@f_EVP_get_digestbyname<>nil) and (@f_EVP_cleanup<>nil) and 
   (@f_EVP_PKEY_decrypt<>nil) and (@f_EVP_PKEY_encrypt<>nil) and (@f_EVP_PKEY_type<>nil) and (@f_EVP_PKEY_bits<>nil) and 
   (@f_EVP_PKEY_size<>nil) and (@f_EVP_PKEY_assign<>nil) and (@f_EVP_PKEY_new<>nil) and (@f_EVP_PKEY_free<>nil) and 
   (@f_d2i_PublicKey<>nil) and (@f_i2d_PublicKey<>nil) and (@f_d2i_PrivateKey<>nil) and (@f_i2d_PrivateKey<>nil) and 
   (@f_EVP_PKEY_copy_parameters<>nil) and (@f_EVP_PKEY_missing_parameters<>nil) and (@f_EVP_PKEY_save_parameters<>nil) and (@f_EVP_PKEY_cmp_parameters<>nil) and 
   (@f_EVP_CIPHER_type<>nil) and (@f_EVP_CIPHER_param_to_asn1<>nil) and (@f_EVP_CIPHER_asn1_to_param<>nil) and (@f_EVP_CIPHER_set_asn1_iv<>nil) and 
   (@f_EVP_CIPHER_get_asn1_iv<>nil) and (@f_PKCS5_PBE_keyivgen<>nil) and (@f_PKCS5_PBKDF2_HMAC_SHA1<>nil) and (@f_PKCS5_v2_PBE_keyivgen<>nil) and 
   (@f_PKCS5_PBE_add<>nil) and (@f_EVP_PBE_CipherInit<>nil) and (@f_EVP_PBE_alg_add<>nil) and (@f_EVP_PBE_cleanup<>nil) and 
   (@f_sk_X509_ALGOR_new<>nil) and (@f_sk_X509_ALGOR_new_null<>nil) and (@f_sk_X509_ALGOR_free<>nil) and (@f_sk_X509_ALGOR_num<>nil) and 
   (@f_sk_X509_ALGOR_value<>nil) and (@f_sk_X509_ALGOR_set<>nil) and (@f_sk_X509_ALGOR_zero<>nil) and (@f_sk_X509_ALGOR_push<>nil) and 
   (@f_sk_X509_ALGOR_unshift<>nil) and (@f_sk_X509_ALGOR_find<>nil) and (@f_sk_X509_ALGOR_delete<>nil) and (@f_sk_X509_ALGOR_delete_ptr<>nil) and 
   (@f_sk_X509_ALGOR_insert<>nil) and (@f_sk_X509_ALGOR_dup<>nil) and (@f_sk_X509_ALGOR_pop_free<>nil) and (@f_sk_X509_ALGOR_shift<>nil) and 
   (@f_sk_X509_ALGOR_pop<>nil) and (@f_sk_X509_ALGOR_sort<>nil) and (@f_i2d_ASN1_SET_OF_X509_ALGOR<>nil) and (@f_d2i_ASN1_SET_OF_X509_ALGOR<>nil) and 
   (@f_sk_X509_NAME_ENTRY_new<>nil) and (@f_sk_X509_NAME_ENTRY_new_null<>nil) and (@f_sk_X509_NAME_ENTRY_free<>nil) and (@f_sk_X509_NAME_ENTRY_num<>nil) and 
   (@f_sk_X509_NAME_ENTRY_value<>nil) and (@f_sk_X509_NAME_ENTRY_set<>nil) and (@f_sk_X509_NAME_ENTRY_zero<>nil) and (@f_sk_X509_NAME_ENTRY_push<>nil) and 
   (@f_sk_X509_NAME_ENTRY_unshift<>nil) and (@f_sk_X509_NAME_ENTRY_find<>nil) and (@f_sk_X509_NAME_ENTRY_delete<>nil) and (@f_sk_X509_NAME_ENTRY_delete_ptr<>nil) and 
   (@f_sk_X509_NAME_ENTRY_insert<>nil) and (@f_sk_X509_NAME_ENTRY_dup<>nil) and (@f_sk_X509_NAME_ENTRY_pop_free<>nil) and (@f_sk_X509_NAME_ENTRY_shift<>nil) and 
   (@f_sk_X509_NAME_ENTRY_pop<>nil) and (@f_sk_X509_NAME_ENTRY_sort<>nil) and (@f_i2d_ASN1_SET_OF_X509_NAME_ENTRY<>nil) and (@f_d2i_ASN1_SET_OF_X509_NAME_ENTRY<>nil) and 
   (@f_sk_X509_NAME_new<>nil) and (@f_sk_X509_NAME_new_null<>nil) and (@f_sk_X509_NAME_free<>nil) and (@f_sk_X509_NAME_num<>nil) and 
   (@f_sk_X509_NAME_value<>nil) and (@f_sk_X509_NAME_set<>nil) and (@f_sk_X509_NAME_zero<>nil) and (@f_sk_X509_NAME_push<>nil) and 
   (@f_sk_X509_NAME_unshift<>nil) and (@f_sk_X509_NAME_find<>nil) and (@f_sk_X509_NAME_delete<>nil) and (@f_sk_X509_NAME_delete_ptr<>nil) and 
   (@f_sk_X509_NAME_insert<>nil) and (@f_sk_X509_NAME_dup<>nil) and (@f_sk_X509_NAME_pop_free<>nil) and (@f_sk_X509_NAME_shift<>nil) and 
   (@f_sk_X509_NAME_pop<>nil) and (@f_sk_X509_NAME_sort<>nil) and (@f_sk_X509_EXTENSION_new<>nil) and (@f_sk_X509_EXTENSION_new_null<>nil) and 
   (@f_sk_X509_EXTENSION_free<>nil) and (@f_sk_X509_EXTENSION_num<>nil) and (@f_sk_X509_EXTENSION_value<>nil) and (@f_sk_X509_EXTENSION_set<>nil) and 
   (@f_sk_X509_EXTENSION_zero<>nil) and (@f_sk_X509_EXTENSION_push<>nil) and (@f_sk_X509_EXTENSION_unshift<>nil) and (@f_sk_X509_EXTENSION_find<>nil) and 
   (@f_sk_X509_EXTENSION_delete<>nil) and (@f_sk_X509_EXTENSION_delete_ptr<>nil) and (@f_sk_X509_EXTENSION_insert<>nil) and (@f_sk_X509_EXTENSION_dup<>nil) and 
   (@f_sk_X509_EXTENSION_pop_free<>nil) and (@f_sk_X509_EXTENSION_shift<>nil) and (@f_sk_X509_EXTENSION_pop<>nil) and (@f_sk_X509_EXTENSION_sort<>nil) and 
   (@f_i2d_ASN1_SET_OF_X509_EXTENSION<>nil) and (@f_d2i_ASN1_SET_OF_X509_EXTENSION<>nil) and (@f_sk_X509_ATTRIBUTE_new<>nil) and (@f_sk_X509_ATTRIBUTE_new_null<>nil) and 
   (@f_sk_X509_ATTRIBUTE_free<>nil) and (@f_sk_X509_ATTRIBUTE_num<>nil) and (@f_sk_X509_ATTRIBUTE_value<>nil) and (@f_sk_X509_ATTRIBUTE_set<>nil) and 
   (@f_sk_X509_ATTRIBUTE_zero<>nil) and (@f_sk_X509_ATTRIBUTE_push<>nil) and (@f_sk_X509_ATTRIBUTE_unshift<>nil) and (@f_sk_X509_ATTRIBUTE_find<>nil) and 
   (@f_sk_X509_ATTRIBUTE_delete<>nil) and (@f_sk_X509_ATTRIBUTE_delete_ptr<>nil) and (@f_sk_X509_ATTRIBUTE_insert<>nil) and (@f_sk_X509_ATTRIBUTE_dup<>nil) and 
   (@f_sk_X509_ATTRIBUTE_pop_free<>nil) and (@f_sk_X509_ATTRIBUTE_shift<>nil) and (@f_sk_X509_ATTRIBUTE_pop<>nil) and (@f_sk_X509_ATTRIBUTE_sort<>nil) and 
   (@f_i2d_ASN1_SET_OF_X509_ATTRIBUTE<>nil) and (@f_d2i_ASN1_SET_OF_X509_ATTRIBUTE<>nil) and (@f_sk_X509_new<>nil) and (@f_sk_X509_new_null<>nil) and 
   (@f_sk_X509_free<>nil) and (@f_sk_X509_num<>nil) and (@f_sk_X509_value<>nil) and (@f_sk_X509_set<>nil) and 
   (@f_sk_X509_zero<>nil) and (@f_sk_X509_push<>nil) and (@f_sk_X509_unshift<>nil) and (@f_sk_X509_find<>nil) and 
   (@f_sk_X509_delete<>nil) and (@f_sk_X509_delete_ptr<>nil) and (@f_sk_X509_insert<>nil) and (@f_sk_X509_dup<>nil) and 
   (@f_sk_X509_pop_free<>nil) and (@f_sk_X509_shift<>nil) and (@f_sk_X509_pop<>nil) and (@f_sk_X509_sort<>nil) and 
   (@f_i2d_ASN1_SET_OF_X509<>nil) and (@f_d2i_ASN1_SET_OF_X509<>nil) and (@f_sk_X509_REVOKED_new<>nil) and (@f_sk_X509_REVOKED_new_null<>nil) and 
   (@f_sk_X509_REVOKED_free<>nil) and (@f_sk_X509_REVOKED_num<>nil) and (@f_sk_X509_REVOKED_value<>nil) and (@f_sk_X509_REVOKED_set<>nil) and 
   (@f_sk_X509_REVOKED_zero<>nil) and (@f_sk_X509_REVOKED_push<>nil) and (@f_sk_X509_REVOKED_unshift<>nil) and (@f_sk_X509_REVOKED_find<>nil) and 
   (@f_sk_X509_REVOKED_delete<>nil) and (@f_sk_X509_REVOKED_delete_ptr<>nil) and (@f_sk_X509_REVOKED_insert<>nil) and (@f_sk_X509_REVOKED_dup<>nil) and 
   (@f_sk_X509_REVOKED_pop_free<>nil) and (@f_sk_X509_REVOKED_shift<>nil) and (@f_sk_X509_REVOKED_pop<>nil) and (@f_sk_X509_REVOKED_sort<>nil) and 
   (@f_i2d_ASN1_SET_OF_X509_REVOKED<>nil) and (@f_d2i_ASN1_SET_OF_X509_REVOKED<>nil) and (@f_sk_X509_CRL_new<>nil) and (@f_sk_X509_CRL_new_null<>nil) and 
   (@f_sk_X509_CRL_free<>nil) and (@f_sk_X509_CRL_num<>nil) and (@f_sk_X509_CRL_value<>nil) and (@f_sk_X509_CRL_set<>nil) and 
   (@f_sk_X509_CRL_zero<>nil) and (@f_sk_X509_CRL_push<>nil) and (@f_sk_X509_CRL_unshift<>nil) and (@f_sk_X509_CRL_find<>nil) and 
   (@f_sk_X509_CRL_delete<>nil) and (@f_sk_X509_CRL_delete_ptr<>nil) and (@f_sk_X509_CRL_insert<>nil) and (@f_sk_X509_CRL_dup<>nil) and 
   (@f_sk_X509_CRL_pop_free<>nil) and (@f_sk_X509_CRL_shift<>nil) and (@f_sk_X509_CRL_pop<>nil) and (@f_sk_X509_CRL_sort<>nil) and 
   (@f_i2d_ASN1_SET_OF_X509_CRL<>nil) and (@f_d2i_ASN1_SET_OF_X509_CRL<>nil) and (@f_sk_X509_INFO_new<>nil) and (@f_sk_X509_INFO_new_null<>nil) and 
   (@f_sk_X509_INFO_free<>nil) and (@f_sk_X509_INFO_num<>nil) and (@f_sk_X509_INFO_value<>nil) and (@f_sk_X509_INFO_set<>nil) and 
   (@f_sk_X509_INFO_zero<>nil) and (@f_sk_X509_INFO_push<>nil) and (@f_sk_X509_INFO_unshift<>nil) and (@f_sk_X509_INFO_find<>nil) and 
   (@f_sk_X509_INFO_delete<>nil) and (@f_sk_X509_INFO_delete_ptr<>nil) and (@f_sk_X509_INFO_insert<>nil) and (@f_sk_X509_INFO_dup<>nil) and 
   (@f_sk_X509_INFO_pop_free<>nil) and (@f_sk_X509_INFO_shift<>nil) and (@f_sk_X509_INFO_pop<>nil) and (@f_sk_X509_INFO_sort<>nil) and 
   (@f_sk_X509_LOOKUP_new<>nil) and (@f_sk_X509_LOOKUP_new_null<>nil) and (@f_sk_X509_LOOKUP_free<>nil) and (@f_sk_X509_LOOKUP_num<>nil) and 
   (@f_sk_X509_LOOKUP_value<>nil) and (@f_sk_X509_LOOKUP_set<>nil) and (@f_sk_X509_LOOKUP_zero<>nil) and (@f_sk_X509_LOOKUP_push<>nil) and 
   (@f_sk_X509_LOOKUP_unshift<>nil) and (@f_sk_X509_LOOKUP_find<>nil) and (@f_sk_X509_LOOKUP_delete<>nil) and (@f_sk_X509_LOOKUP_delete_ptr<>nil) and 
   (@f_sk_X509_LOOKUP_insert<>nil) and (@f_sk_X509_LOOKUP_dup<>nil) and (@f_sk_X509_LOOKUP_pop_free<>nil) and (@f_sk_X509_LOOKUP_shift<>nil) and 
   (@f_sk_X509_LOOKUP_pop<>nil) and (@f_sk_X509_LOOKUP_sort<>nil) and (@f_X509_OBJECT_retrieve_by_subject<>nil) and (@f_X509_OBJECT_up_ref_count<>nil) and 
   (@f_X509_OBJECT_free_contents<>nil) and (@f_X509_STORE_new<>nil) and (@f_X509_STORE_free<>nil) and (@f_X509_STORE_CTX_init<>nil) and 
   (@f_X509_STORE_CTX_cleanup<>nil) and (@f_X509_STORE_add_lookup<>nil) and (@f_X509_LOOKUP_hash_dir<>nil) and (@f_X509_LOOKUP_file<>nil) and 
   (@f_X509_STORE_add_cert<>nil) and (@f_X509_STORE_add_crl<>nil) and (@f_X509_STORE_get_by_subject<>nil) and (@f_X509_LOOKUP_ctrl<>nil) and 
   (@f_X509_load_cert_file<>nil) and (@f_X509_load_crl_file<>nil) and (@f_X509_LOOKUP_new<>nil) and (@f_X509_LOOKUP_free<>nil) and 
   (@f_X509_LOOKUP_init<>nil) and (@f_X509_LOOKUP_by_subject<>nil) and (@f_X509_LOOKUP_by_issuer_serial<>nil) and (@f_X509_LOOKUP_by_fingerprint<>nil) and 
   (@f_X509_LOOKUP_by_alias<>nil) and (@f_X509_LOOKUP_shutdown<>nil) and (@f_X509_STORE_load_locations<>nil) and (@f_X509_STORE_set_default_paths<>nil) and 
   (@f_X509_STORE_CTX_get_ex_new_index<>nil) and (@f_X509_STORE_CTX_set_ex_data<>nil) and (@f_X509_STORE_CTX_get_ex_data<>nil) and (@f_X509_STORE_CTX_get_error<>nil) and 
   (@f_X509_STORE_CTX_set_error<>nil) and (@f_X509_STORE_CTX_get_error_depth<>nil) and (@f_X509_STORE_CTX_get_current_cert<>nil) and (@f_X509_STORE_CTX_get_chain<>nil) and 
   (@f_X509_STORE_CTX_set_cert<>nil) and (@f_X509_STORE_CTX_set_chain<>nil) and (@f_sk_PKCS7_SIGNER_INFO_new<>nil) and (@f_sk_PKCS7_SIGNER_INFO_new_null<>nil) and 
   (@f_sk_PKCS7_SIGNER_INFO_free<>nil) and (@f_sk_PKCS7_SIGNER_INFO_num<>nil) and (@f_sk_PKCS7_SIGNER_INFO_value<>nil) and (@f_sk_PKCS7_SIGNER_INFO_set<>nil) and 
   (@f_sk_PKCS7_SIGNER_INFO_zero<>nil) and (@f_sk_PKCS7_SIGNER_INFO_push<>nil) and (@f_sk_PKCS7_SIGNER_INFO_unshift<>nil) and (@f_sk_PKCS7_SIGNER_INFO_find<>nil) and 
   (@f_sk_PKCS7_SIGNER_INFO_delete<>nil) and (@f_sk_PKCS7_SIGNER_INFO_delete_ptr<>nil) and (@f_sk_PKCS7_SIGNER_INFO_insert<>nil) and (@f_sk_PKCS7_SIGNER_INFO_dup<>nil) and 
   (@f_sk_PKCS7_SIGNER_INFO_pop_free<>nil) and (@f_sk_PKCS7_SIGNER_INFO_shift<>nil) and (@f_sk_PKCS7_SIGNER_INFO_pop<>nil) and (@f_sk_PKCS7_SIGNER_INFO_sort<>nil) and 
   (@f_i2d_ASN1_SET_OF_PKCS7_SIGNER_INFO<>nil) and (@f_d2i_ASN1_SET_OF_PKCS7_SIGNER_INFO<>nil) and (@f_sk_PKCS7_RECIP_INFO_new<>nil) and (@f_sk_PKCS7_RECIP_INFO_new_null<>nil) and 
   (@f_sk_PKCS7_RECIP_INFO_free<>nil) and (@f_sk_PKCS7_RECIP_INFO_num<>nil) and (@f_sk_PKCS7_RECIP_INFO_value<>nil) and (@f_sk_PKCS7_RECIP_INFO_set<>nil) and 
   (@f_sk_PKCS7_RECIP_INFO_zero<>nil) and (@f_sk_PKCS7_RECIP_INFO_push<>nil) and (@f_sk_PKCS7_RECIP_INFO_unshift<>nil) and (@f_sk_PKCS7_RECIP_INFO_find<>nil) and 
   (@f_sk_PKCS7_RECIP_INFO_delete<>nil) and (@f_sk_PKCS7_RECIP_INFO_delete_ptr<>nil) and (@f_sk_PKCS7_RECIP_INFO_insert<>nil) and (@f_sk_PKCS7_RECIP_INFO_dup<>nil) and 
   (@f_sk_PKCS7_RECIP_INFO_pop_free<>nil) and (@f_sk_PKCS7_RECIP_INFO_shift<>nil) and (@f_sk_PKCS7_RECIP_INFO_pop<>nil) and (@f_sk_PKCS7_RECIP_INFO_sort<>nil) and 
   (@f_i2d_ASN1_SET_OF_PKCS7_RECIP_INFO<>nil) and (@f_d2i_ASN1_SET_OF_PKCS7_RECIP_INFO<>nil) and (@f_PKCS7_ISSUER_AND_SERIAL_new<>nil) and (@f_PKCS7_ISSUER_AND_SERIAL_free<>nil) and 
   (@f_i2d_PKCS7_ISSUER_AND_SERIAL<>nil) and (@f_d2i_PKCS7_ISSUER_AND_SERIAL<>nil) and (@f_PKCS7_ISSUER_AND_SERIAL_digest<>nil) and (@f_d2i_PKCS7_fp<>nil) and 
   (@f_i2d_PKCS7_fp<>nil) and (@f_PKCS7_dup<>nil) and (@f_d2i_PKCS7_bio<>nil) and (@f_i2d_PKCS7_bio<>nil) and 
   (@f_PKCS7_SIGNER_INFO_new<>nil) and (@f_PKCS7_SIGNER_INFO_free<>nil) and (@f_i2d_PKCS7_SIGNER_INFO<>nil) and (@f_d2i_PKCS7_SIGNER_INFO<>nil) and 
   (@f_PKCS7_RECIP_INFO_new<>nil) and (@f_PKCS7_RECIP_INFO_free<>nil) and (@f_i2d_PKCS7_RECIP_INFO<>nil) and (@f_d2i_PKCS7_RECIP_INFO<>nil) and 
   (@f_PKCS7_SIGNED_new<>nil) and (@f_PKCS7_SIGNED_free<>nil) and (@f_i2d_PKCS7_SIGNED<>nil) and (@f_d2i_PKCS7_SIGNED<>nil) and 
   (@f_PKCS7_ENC_CONTENT_new<>nil) and (@f_PKCS7_ENC_CONTENT_free<>nil) and (@f_i2d_PKCS7_ENC_CONTENT<>nil) and (@f_d2i_PKCS7_ENC_CONTENT<>nil) and 
   (@f_PKCS7_ENVELOPE_new<>nil) and (@f_PKCS7_ENVELOPE_free<>nil) and (@f_i2d_PKCS7_ENVELOPE<>nil) and (@f_d2i_PKCS7_ENVELOPE<>nil) and 
   (@f_PKCS7_SIGN_ENVELOPE_new<>nil) and (@f_PKCS7_SIGN_ENVELOPE_free<>nil) and (@f_i2d_PKCS7_SIGN_ENVELOPE<>nil) and (@f_d2i_PKCS7_SIGN_ENVELOPE<>nil) and 
   (@f_PKCS7_DIGEST_new<>nil) and (@f_PKCS7_DIGEST_free<>nil) and (@f_i2d_PKCS7_DIGEST<>nil) and (@f_d2i_PKCS7_DIGEST<>nil) and 
   (@f_PKCS7_ENCRYPT_new<>nil) and (@f_PKCS7_ENCRYPT_free<>nil) and (@f_i2d_PKCS7_ENCRYPT<>nil) and (@f_d2i_PKCS7_ENCRYPT<>nil) and 
   (@f_PKCS7_new<>nil) and (@f_PKCS7_free<>nil) and (@f_PKCS7_content_free<>nil) and (@f_i2d_PKCS7<>nil) and 
   (@f_d2i_PKCS7<>nil) and (@f_ERR_load_PKCS7_strings<>nil) and (@f_PKCS7_ctrl<>nil) and (@f_PKCS7_set_type<>nil) and 
   (@f_PKCS7_set_content<>nil) and (@f_PKCS7_SIGNER_INFO_set<>nil) and (@f_PKCS7_add_signer<>nil) and (@f_PKCS7_add_certificate<>nil) and 
   (@f_PKCS7_add_crl<>nil) and (@f_PKCS7_content_new<>nil) and (@f_PKCS7_dataVerify<>nil) and (@f_PKCS7_signatureVerify<>nil) and 
   (@f_PKCS7_dataInit<>nil) and (@f_PKCS7_dataFinal<>nil) and (@f_PKCS7_dataDecode<>nil) and (@f_PKCS7_add_signature<>nil) and 
   (@f_PKCS7_cert_from_signer_info<>nil) and (@f_PKCS7_get_signer_info<>nil) and (@f_PKCS7_add_recipient<>nil) and (@f_PKCS7_add_recipient_info<>nil) and 
   (@f_PKCS7_RECIP_INFO_set<>nil) and (@f_PKCS7_set_cipher<>nil) and (@f_PKCS7_get_issuer_and_serial<>nil) and (@f_PKCS7_digest_from_attributes<>nil) and 
   (@f_PKCS7_add_signed_attribute<>nil) and (@f_PKCS7_add_attribute<>nil) and (@f_PKCS7_get_attribute<>nil) and (@f_PKCS7_get_signed_attribute<>nil) and 
   (@f_PKCS7_set_signed_attributes<>nil) and (@f_PKCS7_set_attributes<>nil) and (@f_X509_verify_cert_error_string<>nil) and (@f_X509_verify<>nil) and 
   (@f_X509_REQ_verify<>nil) and (@f_X509_CRL_verify<>nil) and (@f_NETSCAPE_SPKI_verify<>nil) and (@f_X509_sign<>nil) and 
   (@f_X509_REQ_sign<>nil) and (@f_X509_CRL_sign<>nil) and (@f_NETSCAPE_SPKI_sign<>nil) and (@f_X509_digest<>nil) and 
   (@f_X509_NAME_digest<>nil) and (@f_d2i_X509_fp<>nil) and (@f_i2d_X509_fp<>nil) and (@f_d2i_X509_CRL_fp<>nil) and 
   (@f_i2d_X509_CRL_fp<>nil) and (@f_d2i_X509_REQ_fp<>nil) and (@f_i2d_X509_REQ_fp<>nil) and (@f_d2i_RSAPrivateKey_fp<>nil) and 
   (@f_i2d_RSAPrivateKey_fp<>nil) and (@f_d2i_RSAPublicKey_fp<>nil) and (@f_i2d_RSAPublicKey_fp<>nil) and (@f_d2i_DSAPrivateKey_fp<>nil) and 
   (@f_i2d_DSAPrivateKey_fp<>nil) and (@f_d2i_PKCS8_fp<>nil) and (@f_i2d_PKCS8_fp<>nil) and (@f_d2i_PKCS8_PRIV_KEY_INFO_fp<>nil) and 
   (@f_i2d_PKCS8_PRIV_KEY_INFO_fp<>nil) and (@f_d2i_X509_bio<>nil) and (@f_i2d_X509_bio<>nil) and (@f_d2i_X509_CRL_bio<>nil) and 
   (@f_i2d_X509_CRL_bio<>nil) and (@f_d2i_X509_REQ_bio<>nil) and (@f_i2d_X509_REQ_bio<>nil) and (@f_d2i_RSAPrivateKey_bio<>nil) and 
   (@f_i2d_RSAPrivateKey_bio<>nil) and (@f_d2i_RSAPublicKey_bio<>nil) and (@f_i2d_RSAPublicKey_bio<>nil) and (@f_d2i_DSAPrivateKey_bio<>nil) and 
   (@f_i2d_DSAPrivateKey_bio<>nil) and (@f_d2i_PKCS8_bio<>nil) and (@f_i2d_PKCS8_bio<>nil) and (@f_d2i_PKCS8_PRIV_KEY_INFO_bio<>nil) and 
   (@f_i2d_PKCS8_PRIV_KEY_INFO_bio<>nil) and (@f_X509_dup<>nil) and (@f_X509_ATTRIBUTE_dup<>nil) and (@f_X509_EXTENSION_dup<>nil) and 
   (@f_X509_CRL_dup<>nil) and (@f_X509_REQ_dup<>nil) and (@f_X509_ALGOR_dup<>nil) and (@f_X509_NAME_dup<>nil) and 
   (@f_X509_NAME_ENTRY_dup<>nil) and (@f_RSAPublicKey_dup<>nil) and (@f_RSAPrivateKey_dup<>nil) and (@f_X509_cmp_current_time<>nil) and 
   (@f_X509_gmtime_adj<>nil) and (@f_X509_get_default_cert_area<>nil) and (@f_X509_get_default_cert_dir<>nil) and (@f_X509_get_default_cert_file<>nil) and 
   (@f_X509_get_default_cert_dir_env<>nil) and (@f_X509_get_default_cert_file_env<>nil) and (@f_X509_get_default_private_dir<>nil) and (@f_X509_to_X509_REQ<>nil) and 
   (@f_X509_REQ_to_X509<>nil) and (@f_ERR_load_X509_strings<>nil) and (@f_X509_ALGOR_new<>nil) and (@f_X509_ALGOR_free<>nil) and 
   (@f_i2d_X509_ALGOR<>nil) and (@f_d2i_X509_ALGOR<>nil) and (@f_X509_VAL_new<>nil) and (@f_X509_VAL_free<>nil) and 
   (@f_i2d_X509_VAL<>nil) and (@f_d2i_X509_VAL<>nil) and (@f_X509_PUBKEY_new<>nil) and (@f_X509_PUBKEY_free<>nil) and 
   (@f_i2d_X509_PUBKEY<>nil) and (@f_d2i_X509_PUBKEY<>nil) and (@f_X509_PUBKEY_set<>nil) and (@f_X509_PUBKEY_get<>nil) and 
   (@f_X509_get_pubkey_parameters<>nil) and (@f_X509_SIG_new<>nil) and (@f_X509_SIG_free<>nil) and (@f_i2d_X509_SIG<>nil) and 
   (@f_d2i_X509_SIG<>nil) and (@f_X509_REQ_INFO_new<>nil) and (@f_X509_REQ_INFO_free<>nil) and (@f_i2d_X509_REQ_INFO<>nil) and 
   (@f_d2i_X509_REQ_INFO<>nil) and (@f_X509_REQ_new<>nil) and (@f_X509_REQ_free<>nil) and (@f_i2d_X509_REQ<>nil) and 
   (@f_d2i_X509_REQ<>nil) and (@f_X509_ATTRIBUTE_new<>nil) and (@f_X509_ATTRIBUTE_free<>nil) and (@f_i2d_X509_ATTRIBUTE<>nil) and 
   (@f_d2i_X509_ATTRIBUTE<>nil) and (@f_X509_ATTRIBUTE_create<>nil) and (@f_X509_EXTENSION_new<>nil) and (@f_X509_EXTENSION_free<>nil) and 
   (@f_i2d_X509_EXTENSION<>nil) and (@f_d2i_X509_EXTENSION<>nil) and (@f_X509_NAME_ENTRY_new<>nil) and (@f_X509_NAME_ENTRY_free<>nil) and 
   (@f_i2d_X509_NAME_ENTRY<>nil) and (@f_d2i_X509_NAME_ENTRY<>nil) and (@f_X509_NAME_new<>nil) and (@f_X509_NAME_free<>nil) and 
   (@f_i2d_X509_NAME<>nil) and (@f_d2i_X509_NAME<>nil) and (@f_X509_NAME_set<>nil) and (@f_X509_CINF_new<>nil) and 
   (@f_X509_CINF_free<>nil) and (@f_i2d_X509_CINF<>nil) and (@f_d2i_X509_CINF<>nil) and (@f_X509_new<>nil) and 
   (@f_X509_free<>nil) and (@f_i2d_X509<>nil) and (@f_d2i_X509<>nil) and (@f_X509_REVOKED_new<>nil) and 
   (@f_X509_REVOKED_free<>nil) and (@f_i2d_X509_REVOKED<>nil) and (@f_d2i_X509_REVOKED<>nil) and (@f_X509_CRL_INFO_new<>nil) and 
   (@f_X509_CRL_INFO_free<>nil) and (@f_i2d_X509_CRL_INFO<>nil) and (@f_d2i_X509_CRL_INFO<>nil) and (@f_X509_CRL_new<>nil) and 
   (@f_X509_CRL_free<>nil) and (@f_i2d_X509_CRL<>nil) and (@f_d2i_X509_CRL<>nil) and (@f_X509_PKEY_new<>nil) and 
   (@f_X509_PKEY_free<>nil) and (@f_i2d_X509_PKEY<>nil) and (@f_d2i_X509_PKEY<>nil) and (@f_NETSCAPE_SPKI_new<>nil) and 
   (@f_NETSCAPE_SPKI_free<>nil) and (@f_i2d_NETSCAPE_SPKI<>nil) and (@f_d2i_NETSCAPE_SPKI<>nil) and (@f_NETSCAPE_SPKAC_new<>nil) and 
   (@f_NETSCAPE_SPKAC_free<>nil) and (@f_i2d_NETSCAPE_SPKAC<>nil) and (@f_d2i_NETSCAPE_SPKAC<>nil) and (@f_i2d_NETSCAPE_CERT_SEQUENCE<>nil) and 
   (@f_NETSCAPE_CERT_SEQUENCE_new<>nil) and (@f_d2i_NETSCAPE_CERT_SEQUENCE<>nil) and (@f_NETSCAPE_CERT_SEQUENCE_free<>nil) and (@f_X509_INFO_new<>nil) and 
   (@f_X509_INFO_free<>nil) and (@f_X509_NAME_oneline<>nil) and (@f_ASN1_verify<>nil) and (@f_ASN1_digest<>nil) and 
   (@f_ASN1_sign<>nil) and (@f_X509_set_version<>nil) and (@f_X509_set_serialNumber<>nil) and (@f_X509_get_serialNumber<>nil) and 
   (@f_X509_set_issuer_name<>nil) and (@f_X509_get_issuer_name<>nil) and (@f_X509_set_subject_name<>nil) and (@f_X509_get_subject_name<>nil) and 
   (@f_X509_set_notBefore<>nil) and (@f_X509_set_notAfter<>nil) and (@f_X509_set_pubkey<>nil) and (@f_X509_get_pubkey<>nil) and 
   (@f_X509_certificate_type<>nil) and (@f_X509_REQ_set_version<>nil) and (@f_X509_REQ_set_subject_name<>nil) and (@f_X509_REQ_set_pubkey<>nil) and 
   (@f_X509_REQ_get_pubkey<>nil) and (@f_X509_check_private_key<>nil) and (@f_X509_issuer_and_serial_cmp<>nil) and (@f_X509_issuer_and_serial_hash<>nil) and 
   (@f_X509_issuer_name_cmp<>nil) and (@f_X509_issuer_name_hash<>nil) and (@f_X509_subject_name_cmp<>nil) and (@f_X509_subject_name_hash<>nil) and 
   (@f_X509_NAME_cmp<>nil) and (@f_X509_NAME_hash<>nil) and (@f_X509_CRL_cmp<>nil) and (@f_X509_print_fp<>nil) and 
   (@f_X509_CRL_print_fp<>nil) and (@f_X509_REQ_print_fp<>nil) and (@f_X509_NAME_print<>nil) and (@f_X509_print<>nil) and 
   (@f_X509_CRL_print<>nil) and (@f_X509_REQ_print<>nil) and (@f_X509_NAME_entry_count<>nil) and (@f_X509_NAME_get_text_by_NID<>nil) and 
   (@f_X509_NAME_get_text_by_OBJ<>nil) and (@f_X509_NAME_get_index_by_NID<>nil) and (@f_X509_NAME_get_index_by_OBJ<>nil) and (@f_X509_NAME_get_entry<>nil) and 
   (@f_X509_NAME_delete_entry<>nil) and (@f_X509_NAME_add_entry<>nil) and (@f_X509_NAME_ENTRY_create_by_NID<>nil) and (@f_X509_NAME_ENTRY_create_by_OBJ<>nil) and 
   (@f_X509_NAME_ENTRY_set_object<>nil) and (@f_X509_NAME_ENTRY_set_data<>nil) and (@f_X509_NAME_ENTRY_get_object<>nil) and (@f_X509_NAME_ENTRY_get_data<>nil) and 
   (@f_X509v3_get_ext_count<>nil) and (@f_X509v3_get_ext_by_NID<>nil) and (@f_X509v3_get_ext_by_OBJ<>nil) and (@f_X509v3_get_ext_by_critical<>nil) and 
   (@f_X509v3_get_ext<>nil) and (@f_X509v3_delete_ext<>nil) and (@f_X509v3_add_ext<>nil) and (@f_X509_get_ext_count<>nil) and 
   (@f_X509_get_ext_by_NID<>nil) and (@f_X509_get_ext_by_OBJ<>nil) and (@f_X509_get_ext_by_critical<>nil) and (@f_X509_get_ext<>nil) and 
   (@f_X509_delete_ext<>nil) and (@f_X509_add_ext<>nil) and (@f_X509_CRL_get_ext_count<>nil) and (@f_X509_CRL_get_ext_by_NID<>nil) and 
   (@f_X509_CRL_get_ext_by_OBJ<>nil) and (@f_X509_CRL_get_ext_by_critical<>nil) and (@f_X509_CRL_get_ext<>nil) and (@f_X509_CRL_delete_ext<>nil) and 
   (@f_X509_CRL_add_ext<>nil) and (@f_X509_REVOKED_get_ext_count<>nil) and (@f_X509_REVOKED_get_ext_by_NID<>nil) and (@f_X509_REVOKED_get_ext_by_OBJ<>nil) and 
   (@f_X509_REVOKED_get_ext_by_critical<>nil) and (@f_X509_REVOKED_get_ext<>nil) and (@f_X509_REVOKED_delete_ext<>nil) and (@f_X509_REVOKED_add_ext<>nil) and 
   (@f_X509_EXTENSION_create_by_NID<>nil) and (@f_X509_EXTENSION_create_by_OBJ<>nil) and (@f_X509_EXTENSION_set_object<>nil) and (@f_X509_EXTENSION_set_critical<>nil) and 
   (@f_X509_EXTENSION_set_data<>nil) and (@f_X509_EXTENSION_get_object<>nil) and (@f_X509_EXTENSION_get_data<>nil) and (@f_X509_EXTENSION_get_critical<>nil) and 
   (@f_X509_verify_cert<>nil) and (@f_X509_find_by_issuer_and_serial<>nil) and (@f_X509_find_by_subject<>nil) and (@f_i2d_PBEPARAM<>nil) and 
   (@f_PBEPARAM_new<>nil) and (@f_d2i_PBEPARAM<>nil) and (@f_PBEPARAM_free<>nil) and (@f_PKCS5_pbe_set<>nil) and 
   (@f_PKCS5_pbe2_set<>nil) and (@f_i2d_PBKDF2PARAM<>nil) and (@f_PBKDF2PARAM_new<>nil) and (@f_d2i_PBKDF2PARAM<>nil) and 
   (@f_PBKDF2PARAM_free<>nil) and (@f_i2d_PBE2PARAM<>nil) and (@f_PBE2PARAM_new<>nil) and (@f_d2i_PBE2PARAM<>nil) and 
   (@f_PBE2PARAM_free<>nil) and (@f_i2d_PKCS8_PRIV_KEY_INFO<>nil) and (@f_PKCS8_PRIV_KEY_INFO_new<>nil) and (@f_d2i_PKCS8_PRIV_KEY_INFO<>nil) and 
   (@f_PKCS8_PRIV_KEY_INFO_free<>nil) and (@f_EVP_PKCS82PKEY<>nil) and (@f_EVP_PKEY2PKCS8<>nil) and (@f_PKCS8_set_broken<>nil) and 
   (@f_ERR_load_PEM_strings<>nil) and (@f_PEM_get_EVP_CIPHER_INFO<>nil) and (@f_PEM_do_header<>nil) and (@f_PEM_read_bio<>nil) and 
   (@f_PEM_write_bio<>nil) and (@f_PEM_ASN1_read_bio<>nil) and (@f_PEM_ASN1_write_bio<>nil) and (@f_PEM_X509_INFO_read_bio<>nil) and 
   (@f_PEM_X509_INFO_write_bio<>nil) and (@f_PEM_read<>nil) and (@f_PEM_write<>nil) and (@f_PEM_ASN1_read<>nil) and 
   (@f_PEM_ASN1_write<>nil) and (@f_PEM_X509_INFO_read<>nil) and (@f_PEM_SealInit<>nil) and (@f_PEM_SealUpdate<>nil) and 
   (@f_PEM_SealFinal<>nil) and (@f_PEM_SignInit<>nil) and (@f_PEM_SignUpdate<>nil) and (@f_PEM_SignFinal<>nil) and 
   (@f_PEM_proc_type<>nil) and (@f_PEM_dek_info<>nil) and (@f_PEM_read_bio_X509<>nil) and (@f_PEM_read_X509<>nil) and 
   (@f_PEM_write_bio_X509<>nil) and (@f_PEM_write_X509<>nil) and (@f_PEM_read_bio_X509_REQ<>nil) and (@f_PEM_read_X509_REQ<>nil) and 
   (@f_PEM_write_bio_X509_REQ<>nil) and (@f_PEM_write_X509_REQ<>nil) and (@f_PEM_read_bio_X509_CRL<>nil) and (@f_PEM_read_X509_CRL<>nil) and 
   (@f_PEM_write_bio_X509_CRL<>nil) and (@f_PEM_write_X509_CRL<>nil) and (@f_PEM_read_bio_PKCS7<>nil) and (@f_PEM_read_PKCS7<>nil) and 
   (@f_PEM_write_bio_PKCS7<>nil) and (@f_PEM_write_PKCS7<>nil) and (@f_PEM_read_bio_NETSCAPE_CERT_SEQUENCE<>nil) and (@f_PEM_read_NETSCAPE_CERT_SEQUENCE<>nil) and 
   (@f_PEM_write_bio_NETSCAPE_CERT_SEQUENCE<>nil) and (@f_PEM_write_NETSCAPE_CERT_SEQUENCE<>nil) and (@f_PEM_read_bio_PKCS8<>nil) and (@f_PEM_read_PKCS8<>nil) and 
   (@f_PEM_write_bio_PKCS8<>nil) and (@f_PEM_write_PKCS8<>nil) and (@f_PEM_read_bio_PKCS8_PRIV_KEY_INFO<>nil) and (@f_PEM_read_PKCS8_PRIV_KEY_INFO<>nil) and 
   (@f_PEM_write_bio_PKCS8_PRIV_KEY_INFO<>nil) and (@f_PEM_write_PKCS8_PRIV_KEY_INFO<>nil) and (@f_PEM_read_bio_RSAPrivateKey<>nil) and (@f_PEM_read_RSAPrivateKey<>nil) and 
   (@f_PEM_write_bio_RSAPrivateKey<>nil) and (@f_PEM_write_RSAPrivateKey<>nil) and (@f_PEM_read_bio_RSAPublicKey<>nil) and (@f_PEM_read_RSAPublicKey<>nil) and 
   (@f_PEM_write_bio_RSAPublicKey<>nil) and (@f_PEM_write_RSAPublicKey<>nil) and (@f_PEM_read_bio_DSAPrivateKey<>nil) and (@f_PEM_read_DSAPrivateKey<>nil) and 
   (@f_PEM_write_bio_DSAPrivateKey<>nil) and (@f_PEM_write_DSAPrivateKey<>nil) and (@f_PEM_read_bio_DSAparams<>nil) and (@f_PEM_read_DSAparams<>nil) and 
   (@f_PEM_write_bio_DSAparams<>nil) and (@f_PEM_write_DSAparams<>nil) and (@f_PEM_read_bio_DHparams<>nil) and (@f_PEM_read_DHparams<>nil) and 
   (@f_PEM_write_bio_DHparams<>nil) and (@f_PEM_write_DHparams<>nil) and (@f_PEM_read_bio_PrivateKey<>nil) and (@f_PEM_read_PrivateKey<>nil) and 
   (@f_PEM_write_bio_PrivateKey<>nil) and (@f_PEM_write_PrivateKey<>nil) and (@f_PEM_write_bio_PKCS8PrivateKey<>nil) and (@f_PEM_write_PKCS8PrivateKey<>nil) and 
   (@f_sk_SSL_CIPHER_new<>nil) and (@f_sk_SSL_CIPHER_new_null<>nil) and (@f_sk_SSL_CIPHER_free<>nil) and (@f_sk_SSL_CIPHER_num<>nil) and 
   (@f_sk_SSL_CIPHER_value<>nil) and (@f_sk_SSL_CIPHER_set<>nil) and (@f_sk_SSL_CIPHER_zero<>nil) and (@f_sk_SSL_CIPHER_push<>nil) and 
   (@f_sk_SSL_CIPHER_unshift<>nil) and (@f_sk_SSL_CIPHER_find<>nil) and (@f_sk_SSL_CIPHER_delete<>nil) and (@f_sk_SSL_CIPHER_delete_ptr<>nil) and 
   (@f_sk_SSL_CIPHER_insert<>nil) and (@f_sk_SSL_CIPHER_dup<>nil) and (@f_sk_SSL_CIPHER_pop_free<>nil) and (@f_sk_SSL_CIPHER_shift<>nil) and 
   (@f_sk_SSL_CIPHER_pop<>nil) and (@f_sk_SSL_CIPHER_sort<>nil) and (@f_sk_SSL_COMP_new<>nil) and (@f_sk_SSL_COMP_new_null<>nil) and 
   (@f_sk_SSL_COMP_free<>nil) and (@f_sk_SSL_COMP_num<>nil) and (@f_sk_SSL_COMP_value<>nil) and (@f_sk_SSL_COMP_set<>nil) and 
   (@f_sk_SSL_COMP_zero<>nil) and (@f_sk_SSL_COMP_push<>nil) and (@f_sk_SSL_COMP_unshift<>nil) and (@f_sk_SSL_COMP_find<>nil) and 
   (@f_sk_SSL_COMP_delete<>nil) and (@f_sk_SSL_COMP_delete_ptr<>nil) and (@f_sk_SSL_COMP_insert<>nil) and (@f_sk_SSL_COMP_dup<>nil) and 
   (@f_sk_SSL_COMP_pop_free<>nil) and (@f_sk_SSL_COMP_shift<>nil) and (@f_sk_SSL_COMP_pop<>nil) and (@f_sk_SSL_COMP_sort<>nil) and 
   (@f_BIO_f_ssl<>nil) and (@f_BIO_new_ssl<>nil) and (@f_BIO_new_ssl_connect<>nil) and (@f_BIO_new_buffer_ssl_connect<>nil) and 
   (@f_BIO_ssl_copy_session_id<>nil) and (@f_BIO_ssl_shutdown<>nil) and (@f_SSL_CTX_set_cipher_list<>nil) and (@f_SSL_CTX_new<>nil) and 
   (@f_SSL_CTX_free<>nil) and (@f_SSL_CTX_set_timeout<>nil) and (@f_SSL_CTX_get_timeout<>nil) and (@f_SSL_CTX_get_cert_store<>nil) and 
   (@f_SSL_CTX_set_cert_store<>nil) and (@f_SSL_want<>nil) and (@f_SSL_clear<>nil) and (@f_SSL_CTX_flush_sessions<>nil) and 
   (@f_SSL_get_current_cipher<>nil) and (@f_SSL_CIPHER_get_bits<>nil) and (@f_SSL_CIPHER_get_version<>nil) and (@f_SSL_CIPHER_get_name<>nil) and 
   (@f_SSL_get_fd<>nil) and (@f_SSL_get_cipher_list<>nil) and (@f_SSL_get_shared_ciphers<>nil) and (@f_SSL_get_read_ahead<>nil) and 
   (@f_SSL_pending<>nil) and (@f_SSL_set_fd<>nil) and (@f_SSL_set_rfd<>nil) and (@f_SSL_set_wfd<>nil) and 
   (@f_SSL_set_bio<>nil) and (@f_SSL_get_rbio<>nil) and (@f_SSL_get_wbio<>nil) and (@f_SSL_set_cipher_list<>nil) and 
   (@f_SSL_set_read_ahead<>nil) and (@f_SSL_get_verify_mode<>nil) and (@f_SSL_get_verify_depth<>nil) and (@f_SSL_set_verify<>nil) and 
   (@f_SSL_set_verify_depth<>nil) and (@f_SSL_use_RSAPrivateKey<>nil) and (@f_SSL_use_RSAPrivateKey_ASN1<>nil) and (@f_SSL_use_PrivateKey<>nil) and 
   (@f_SSL_use_PrivateKey_ASN1<>nil) and (@f_SSL_use_certificate<>nil) and (@f_SSL_use_certificate_ASN1<>nil) and (@f_SSL_use_RSAPrivateKey_file<>nil) and 
   (@f_SSL_use_PrivateKey_file<>nil) and (@f_SSL_use_certificate_file<>nil) and (@f_SSL_CTX_use_RSAPrivateKey_file<>nil) and (@f_SSL_CTX_use_PrivateKey_file<>nil) and 
   (@f_SSL_CTX_use_certificate_file<>nil) and (@f_SSL_CTX_use_certificate_chain_file<>nil) and (@f_SSL_load_client_CA_file<>nil) and (@f_SSL_add_file_cert_subjects_to_stack<>nil) and 
   (@f_ERR_load_SSL_strings<>nil) and (@f_SSL_load_error_strings<>nil) and (@f_SSL_state_string<>nil) and (@f_SSL_rstate_string<>nil) and 
   (@f_SSL_state_string_long<>nil) and (@f_SSL_rstate_string_long<>nil) and (@f_SSL_SESSION_get_time<>nil) and (@f_SSL_SESSION_set_time<>nil) and 
   (@f_SSL_SESSION_get_timeout<>nil) and (@f_SSL_SESSION_set_timeout<>nil) and (@f_SSL_copy_session_id<>nil) and (@f_SSL_SESSION_new<>nil) and 
   (@f_SSL_SESSION_hash<>nil) and (@f_SSL_SESSION_cmp<>nil) and (@f_SSL_SESSION_print_fp<>nil) and (@f_SSL_SESSION_print<>nil) and 
   (@f_SSL_SESSION_free<>nil) and (@f_i2d_SSL_SESSION<>nil) and (@f_SSL_set_session<>nil) and (@f_SSL_CTX_add_session<>nil) and 
   (@f_SSL_CTX_remove_session<>nil) and (@f_d2i_SSL_SESSION<>nil) and (@f_SSL_get_peer_certificate<>nil) and (@f_SSL_get_peer_cert_chain<>nil) and 
   (@f_SSL_CTX_get_verify_mode<>nil) and (@f_SSL_CTX_get_verify_depth<>nil) and (@f_SSL_CTX_set_verify<>nil) and (@f_SSL_CTX_set_verify_depth<>nil) and 
   (@f_SSL_CTX_set_cert_verify_callback<>nil) and (@f_SSL_CTX_use_RSAPrivateKey<>nil) and (@f_SSL_CTX_use_RSAPrivateKey_ASN1<>nil) and (@f_SSL_CTX_use_PrivateKey<>nil) and 
   (@f_SSL_CTX_use_PrivateKey_ASN1<>nil) and (@f_SSL_CTX_use_certificate<>nil) and (@f_SSL_CTX_use_certificate_ASN1<>nil) and (@f_SSL_CTX_set_default_passwd_cb<>nil) and 
   (@f_SSL_CTX_set_default_passwd_cb_userdata<>nil) and (@f_SSL_CTX_check_private_key<>nil) and (@f_SSL_check_private_key<>nil) and (@f_SSL_CTX_set_session_id_context<>nil) and 
   (@f_SSL_new<>nil) and (@f_SSL_set_session_id_context<>nil) and (@f_SSL_free<>nil) and (@f_SSL_accept<>nil) and 
   (@f_SSL_connect<>nil) and (@f_SSL_read<>nil) and (@f_SSL_peek<>nil) and (@f_SSL_write<>nil) and 
   (@f_SSL_ctrl<>nil) and (@f_SSL_CTX_ctrl<>nil) and (@f_SSL_get_error<>nil) and (@f_SSL_get_version<>nil) and 
   (@f_SSL_CTX_set_ssl_version<>nil) and (@f_SSLv2_method<>nil) and (@f_SSLv2_server_method<>nil) and (@f_SSLv2_client_method<>nil) and 
   (@f_SSLv3_method<>nil) and (@f_SSLv3_server_method<>nil) and (@f_SSLv3_client_method<>nil) and (@f_SSLv23_method<>nil) and 
   (@f_SSLv23_server_method<>nil) and (@f_SSLv23_client_method<>nil) and (@f_TLSv1_method<>nil) and (@f_TLSv1_server_method<>nil) and 
   (@f_TLSv1_client_method<>nil) and (@f_SSL_get_ciphers<>nil) and (@f_SSL_do_handshake<>nil) and (@f_SSL_renegotiate<>nil) and 
   (@f_SSL_shutdown<>nil) and (@f_SSL_get_ssl_method<>nil) and (@f_SSL_set_ssl_method<>nil) and (@f_SSL_alert_type_string_long<>nil) and 
   (@f_SSL_alert_type_string<>nil) and (@f_SSL_alert_desc_string_long<>nil) and (@f_SSL_alert_desc_string<>nil) and (@f_SSL_set_client_CA_list<>nil) and 
   (@f_SSL_CTX_set_client_CA_list<>nil) and (@f_SSL_get_client_CA_list<>nil) and (@f_SSL_CTX_get_client_CA_list<>nil) and (@f_SSL_add_client_CA<>nil) and 
   (@f_SSL_CTX_add_client_CA<>nil) and (@f_SSL_set_connect_state<>nil) and (@f_SSL_set_accept_state<>nil) and (@f_SSL_get_default_timeout<>nil) and 
   (@f_SSL_library_init<>nil) and (@f_SSL_CIPHER_description<>nil) and (@f_SSL_dup_CA_list<>nil) and (@f_SSL_dup<>nil) and 
   (@f_SSL_get_certificate<>nil) and (@f_SSL_get_privatekey<>nil) and (@f_SSL_CTX_set_quiet_shutdown<>nil) and (@f_SSL_CTX_get_quiet_shutdown<>nil) and 
   (@f_SSL_set_quiet_shutdown<>nil) and (@f_SSL_get_quiet_shutdown<>nil) and (@f_SSL_set_shutdown<>nil) and (@f_SSL_get_shutdown<>nil) and 
   (@f_SSL_version<>nil) and (@f_SSL_CTX_set_default_verify_paths<>nil) and (@f_SSL_CTX_load_verify_locations<>nil) and (@f_SSL_get_session<>nil) and 
   (@f_SSL_get_SSL_CTX<>nil) and (@f_SSL_set_info_callback<>nil) and (@f_SSL_state<>nil) and (@f_SSL_set_verify_result<>nil) and 
   (@f_SSL_get_verify_result<>nil) and (@f_SSL_set_ex_data<>nil) and (@f_SSL_get_ex_data<>nil) and (@f_SSL_get_ex_new_index<>nil) and 
   (@f_SSL_SESSION_set_ex_data<>nil) and (@f_SSL_SESSION_get_ex_data<>nil) and (@f_SSL_SESSION_get_ex_new_index<>nil) and (@f_SSL_CTX_set_ex_data<>nil) and 
   (@f_SSL_CTX_get_ex_data<>nil) and (@f_SSL_CTX_get_ex_new_index<>nil) and (@f_SSL_get_ex_data_X509_STORE_CTX_idx<>nil) and (@f_SSL_CTX_set_tmp_rsa_callback<>nil) and 
   (@f_SSL_set_tmp_rsa_callback<>nil) and (@f_SSL_CTX_set_tmp_dh_callback<>nil) and (@f_SSL_set_tmp_dh_callback<>nil) and (@f_SSL_COMP_add_compression_method<>nil) and 
   (@f_SSLeay_add_ssl_algorithms<>nil) and (@f_SSL_set_app_data<>nil) and (@f_SSL_get_app_data<>nil) and (@f_SSL_CTX_set_info_callback<>nil) and 
   (@f_SSL_CTX_set_options<>nil) and (@f_SSL_is_init_finished<>nil) and (@f_SSL_in_init<>nil) and (@f_SSL_in_before<>nil) and 
   (@f_SSL_in_connect_init<>nil) and (@f_SSL_in_accept_init<>nil) and (@f_X509_STORE_CTX_get_app_data<>nil) and (@f_X509_get_notBefore<>nil) and 
   (@f_X509_get_notAfter<>nil) and (@f_UCTTimeDecode<>nil) and (@f_SSL_CTX_get_version<>nil) and (@f_SSL_SESSION_get_id<>nil) and 
   (@f_SSL_SESSION_get_id_ctx<>nil) and (@f_fopen<>nil) and (@f_fclose<>nil);
  {$ENDIF}
  If Result Then f_SSL_load_error_strings;
end;

Procedure Unload;
begin
  If hMySSL>0 Then FreeLibrary(hMySSL);
// GREGOR
  hMySSL := 0;
// END GREGOR
end;

Function WhichFailedToLoad:String;
Begin
 If hMySSL=0 Then 
   result := 'Failed to load '+MySSL_DLL_name+'.'
 Else Begin
  result := '';
  {$IFNDEF MySSL_STATIC}
  If @f_sk_num=nil Then result := result + ' ' + fn_sk_num;
  If @f_sk_value=nil Then result := result + ' ' + fn_sk_value;
  If @f_sk_set=nil Then result := result + ' ' + fn_sk_set;
  If @f_sk_new=nil Then result := result + ' ' + fn_sk_new;
  If @f_sk_free=nil Then result := result + ' ' + fn_sk_free;
  If @f_sk_pop_free=nil Then result := result + ' ' + fn_sk_pop_free;
  If @f_sk_insert=nil Then result := result + ' ' + fn_sk_insert;
  If @f_sk_delete=nil Then result := result + ' ' + fn_sk_delete;
  If @f_sk_delete_ptr=nil Then result := result + ' ' + fn_sk_delete_ptr;
  If @f_sk_find=nil Then result := result + ' ' + fn_sk_find;
  If @f_sk_push=nil Then result := result + ' ' + fn_sk_push;
  If @f_sk_unshift=nil Then result := result + ' ' + fn_sk_unshift;
  If @f_sk_shift=nil Then result := result + ' ' + fn_sk_shift;
  If @f_sk_pop=nil Then result := result + ' ' + fn_sk_pop;
  If @f_sk_zero=nil Then result := result + ' ' + fn_sk_zero;
  If @f_sk_dup=nil Then result := result + ' ' + fn_sk_dup;
  If @f_sk_sort=nil Then result := result + ' ' + fn_sk_sort;
  If @f_SSLeay_version=nil Then result := result + ' ' + fn_SSLeay_version;
  If @f_SSLeay=nil Then result := result + ' ' + fn_SSLeay;
  If @f_CRYPTO_get_ex_new_index=nil Then result := result + ' ' + fn_CRYPTO_get_ex_new_index;
  If @f_CRYPTO_set_ex_data=nil Then result := result + ' ' + fn_CRYPTO_set_ex_data;
  If @f_CRYPTO_get_ex_data=nil Then result := result + ' ' + fn_CRYPTO_get_ex_data;
  If @f_CRYPTO_dup_ex_data=nil Then result := result + ' ' + fn_CRYPTO_dup_ex_data;
  If @f_CRYPTO_free_ex_data=nil Then result := result + ' ' + fn_CRYPTO_free_ex_data;
  If @f_CRYPTO_new_ex_data=nil Then result := result + ' ' + fn_CRYPTO_new_ex_data;
  If @f_CRYPTO_mem_ctrl=nil Then result := result + ' ' + fn_CRYPTO_mem_ctrl;
  If @f_CRYPTO_get_new_lockid=nil Then result := result + ' ' + fn_CRYPTO_get_new_lockid;
  If @f_CRYPTO_num_locks=nil Then result := result + ' ' + fn_CRYPTO_num_locks;
  If @f_CRYPTO_lock=nil Then result := result + ' ' + fn_CRYPTO_lock;
  If @f_CRYPTO_set_locking_callback=nil Then result := result + ' ' + fn_CRYPTO_set_locking_callback;
  If @f_CRYPTO_set_add_lock_callback=nil Then result := result + ' ' + fn_CRYPTO_set_add_lock_callback;
  If @f_CRYPTO_set_id_callback=nil Then result := result + ' ' + fn_CRYPTO_set_id_callback;
  If @f_CRYPTO_thread_id=nil Then result := result + ' ' + fn_CRYPTO_thread_id;
  If @f_CRYPTO_get_lock_name=nil Then result := result + ' ' + fn_CRYPTO_get_lock_name;
  If @f_CRYPTO_add_lock=nil Then result := result + ' ' + fn_CRYPTO_add_lock;
  If @f_CRYPTO_set_mem_functions=nil Then result := result + ' ' + fn_CRYPTO_set_mem_functions;
  If @f_CRYPTO_get_mem_functions=nil Then result := result + ' ' + fn_CRYPTO_get_mem_functions;
  If @f_CRYPTO_set_locked_mem_functions=nil Then result := result + ' ' + fn_CRYPTO_set_locked_mem_functions;
  If @f_CRYPTO_get_locked_mem_functions=nil Then result := result + ' ' + fn_CRYPTO_get_locked_mem_functions;
  If @f_CRYPTO_malloc_locked=nil Then result := result + ' ' + fn_CRYPTO_malloc_locked;
  If @f_CRYPTO_free_locked=nil Then result := result + ' ' + fn_CRYPTO_free_locked;
  If @f_CRYPTO_malloc=nil Then result := result + ' ' + fn_CRYPTO_malloc;
  If @f_CRYPTO_free=nil Then result := result + ' ' + fn_CRYPTO_free;
  If @f_CRYPTO_realloc=nil Then result := result + ' ' + fn_CRYPTO_realloc;
  If @f_CRYPTO_remalloc=nil Then result := result + ' ' + fn_CRYPTO_remalloc;
  If @f_CRYPTO_dbg_malloc=nil Then result := result + ' ' + fn_CRYPTO_dbg_malloc;
  If @f_CRYPTO_dbg_realloc=nil Then result := result + ' ' + fn_CRYPTO_dbg_realloc;
  If @f_CRYPTO_dbg_free=nil Then result := result + ' ' + fn_CRYPTO_dbg_free;
  If @f_CRYPTO_dbg_remalloc=nil Then result := result + ' ' + fn_CRYPTO_dbg_remalloc;
  If @f_CRYPTO_mem_leaks_fp=nil Then result := result + ' ' + fn_CRYPTO_mem_leaks_fp;
  If @f_CRYPTO_mem_leaks=nil Then result := result + ' ' + fn_CRYPTO_mem_leaks;
  If @f_CRYPTO_mem_leaks_cb=nil Then result := result + ' ' + fn_CRYPTO_mem_leaks_cb;
  If @f_ERR_load_CRYPTO_strings=nil Then result := result + ' ' + fn_ERR_load_CRYPTO_strings;
  If @f_lh_new=nil Then result := result + ' ' + fn_lh_new;
  If @f_lh_free=nil Then result := result + ' ' + fn_lh_free;
  If @f_lh_insert=nil Then result := result + ' ' + fn_lh_insert;
  If @f_lh_delete=nil Then result := result + ' ' + fn_lh_delete;
  If @f_lh_retrieve=nil Then result := result + ' ' + fn_lh_retrieve;
  If @f_lh_doall=nil Then result := result + ' ' + fn_lh_doall;
  If @f_lh_doall_arg=nil Then result := result + ' ' + fn_lh_doall_arg;
  If @f_lh_strhash=nil Then result := result + ' ' + fn_lh_strhash;
  If @f_lh_stats=nil Then result := result + ' ' + fn_lh_stats;
  If @f_lh_node_stats=nil Then result := result + ' ' + fn_lh_node_stats;
  If @f_lh_node_usage_stats=nil Then result := result + ' ' + fn_lh_node_usage_stats;
  If @f_BUF_MEM_new=nil Then result := result + ' ' + fn_BUF_MEM_new;
  If @f_BUF_MEM_free=nil Then result := result + ' ' + fn_BUF_MEM_free;
  If @f_BUF_MEM_grow=nil Then result := result + ' ' + fn_BUF_MEM_grow;
  If @f_BUF_strdup=nil Then result := result + ' ' + fn_BUF_strdup;
  If @f_ERR_load_BUF_strings=nil Then result := result + ' ' + fn_ERR_load_BUF_strings;
  If @f_BIO_ctrl_pending=nil Then result := result + ' ' + fn_BIO_ctrl_pending;
  If @f_BIO_ctrl_wpending=nil Then result := result + ' ' + fn_BIO_ctrl_wpending;
  If @f_BIO_ctrl_get_write_guarantee=nil Then result := result + ' ' + fn_BIO_ctrl_get_write_guarantee;
  If @f_BIO_ctrl_get_read_request=nil Then result := result + ' ' + fn_BIO_ctrl_get_read_request;
  If @f_BIO_set_ex_data=nil Then result := result + ' ' + fn_BIO_set_ex_data;
  If @f_BIO_get_ex_data=nil Then result := result + ' ' + fn_BIO_get_ex_data;
  If @f_BIO_get_ex_new_index=nil Then result := result + ' ' + fn_BIO_get_ex_new_index;
  If @f_BIO_s_file=nil Then result := result + ' ' + fn_BIO_s_file;
  If @f_BIO_new_file=nil Then result := result + ' ' + fn_BIO_new_file;
  If @f_BIO_new_fp=nil Then result := result + ' ' + fn_BIO_new_fp;
  If @f_BIO_new=nil Then result := result + ' ' + fn_BIO_new;
  If @f_BIO_set=nil Then result := result + ' ' + fn_BIO_set;
  If @f_BIO_free=nil Then result := result + ' ' + fn_BIO_free;
  If @f_BIO_read=nil Then result := result + ' ' + fn_BIO_read;
  If @f_BIO_gets=nil Then result := result + ' ' + fn_BIO_gets;
  If @f_BIO_write=nil Then result := result + ' ' + fn_BIO_write;
  If @f_BIO_puts=nil Then result := result + ' ' + fn_BIO_puts;
  If @f_BIO_ctrl=nil Then result := result + ' ' + fn_BIO_ctrl;
  If @f_BIO_ptr_ctrl=nil Then result := result + ' ' + fn_BIO_ptr_ctrl;
  If @f_BIO_int_ctrl=nil Then result := result + ' ' + fn_BIO_int_ctrl;
  If @f_BIO_push=nil Then result := result + ' ' + fn_BIO_push;
  If @f_BIO_pop=nil Then result := result + ' ' + fn_BIO_pop;
  If @f_BIO_free_all=nil Then result := result + ' ' + fn_BIO_free_all;
  If @f_BIO_find_type=nil Then result := result + ' ' + fn_BIO_find_type;
  If @f_BIO_get_retry_BIO=nil Then result := result + ' ' + fn_BIO_get_retry_BIO;
  If @f_BIO_get_retry_reason=nil Then result := result + ' ' + fn_BIO_get_retry_reason;
  If @f_BIO_dup_chain=nil Then result := result + ' ' + fn_BIO_dup_chain;
  If @f_BIO_debug_callback=nil Then result := result + ' ' + fn_BIO_debug_callback;
  If @f_BIO_s_mem=nil Then result := result + ' ' + fn_BIO_s_mem;
  If @f_BIO_s_socket=nil Then result := result + ' ' + fn_BIO_s_socket;
  If @f_BIO_s_connect=nil Then result := result + ' ' + fn_BIO_s_connect;
  If @f_BIO_s_accept=nil Then result := result + ' ' + fn_BIO_s_accept;
  If @f_BIO_s_fd=nil Then result := result + ' ' + fn_BIO_s_fd;
  If @f_BIO_s_bio=nil Then result := result + ' ' + fn_BIO_s_bio;
  If @f_BIO_s_null=nil Then result := result + ' ' + fn_BIO_s_null;
  If @f_BIO_f_null=nil Then result := result + ' ' + fn_BIO_f_null;
  If @f_BIO_f_buffer=nil Then result := result + ' ' + fn_BIO_f_buffer;
  If @f_BIO_f_nbio_test=nil Then result := result + ' ' + fn_BIO_f_nbio_test;
  If @f_BIO_sock_should_retry=nil Then result := result + ' ' + fn_BIO_sock_should_retry;
  If @f_BIO_sock_non_fatal_error=nil Then result := result + ' ' + fn_BIO_sock_non_fatal_error;
  If @f_BIO_fd_should_retry=nil Then result := result + ' ' + fn_BIO_fd_should_retry;
  If @f_BIO_fd_non_fatal_error=nil Then result := result + ' ' + fn_BIO_fd_non_fatal_error;
  If @f_BIO_dump=nil Then result := result + ' ' + fn_BIO_dump;
  If @f_BIO_gethostbyname=nil Then result := result + ' ' + fn_BIO_gethostbyname;
  If @f_BIO_sock_error=nil Then result := result + ' ' + fn_BIO_sock_error;
  If @f_BIO_socket_ioctl=nil Then result := result + ' ' + fn_BIO_socket_ioctl;
  If @f_BIO_socket_nbio=nil Then result := result + ' ' + fn_BIO_socket_nbio;
  If @f_BIO_get_port=nil Then result := result + ' ' + fn_BIO_get_port;
  If @f_BIO_get_host_ip=nil Then result := result + ' ' + fn_BIO_get_host_ip;
  If @f_BIO_get_accept_socket=nil Then result := result + ' ' + fn_BIO_get_accept_socket;
  If @f_BIO_accept=nil Then result := result + ' ' + fn_BIO_accept;
  If @f_BIO_sock_init=nil Then result := result + ' ' + fn_BIO_sock_init;
  If @f_BIO_sock_cleanup=nil Then result := result + ' ' + fn_BIO_sock_cleanup;
  If @f_BIO_set_tcp_ndelay=nil Then result := result + ' ' + fn_BIO_set_tcp_ndelay;
  If @f_ERR_load_BIO_strings=nil Then result := result + ' ' + fn_ERR_load_BIO_strings;
  If @f_BIO_new_socket=nil Then result := result + ' ' + fn_BIO_new_socket;
  If @f_BIO_new_fd=nil Then result := result + ' ' + fn_BIO_new_fd;
  If @f_BIO_new_connect=nil Then result := result + ' ' + fn_BIO_new_connect;
  If @f_BIO_new_accept=nil Then result := result + ' ' + fn_BIO_new_accept;
  If @f_BIO_new_bio_pair=nil Then result := result + ' ' + fn_BIO_new_bio_pair;
  If @f_BIO_copy_next_retry=nil Then result := result + ' ' + fn_BIO_copy_next_retry;
  If @f_BIO_ghbn_ctrl=nil Then result := result + ' ' + fn_BIO_ghbn_ctrl;
  If @f_MD2_options=nil Then result := result + ' ' + fn_MD2_options;
  If @f_MD2_Init=nil Then result := result + ' ' + fn_MD2_Init;
  If @f_MD2_Update=nil Then result := result + ' ' + fn_MD2_Update;
  If @f_MD2_Final=nil Then result := result + ' ' + fn_MD2_Final;
  If @f_MD2=nil Then result := result + ' ' + fn_MD2;
  If @f_MD5_Init=nil Then result := result + ' ' + fn_MD5_Init;
  If @f_MD5_Update=nil Then result := result + ' ' + fn_MD5_Update;
  If @f_MD5_Final=nil Then result := result + ' ' + fn_MD5_Final;
  If @f_MD5=nil Then result := result + ' ' + fn_MD5;
  If @f_MD5_Transform=nil Then result := result + ' ' + fn_MD5_Transform;
  If @f_SHA_Init=nil Then result := result + ' ' + fn_SHA_Init;
  If @f_SHA_Update=nil Then result := result + ' ' + fn_SHA_Update;
  If @f_SHA_Final=nil Then result := result + ' ' + fn_SHA_Final;
  If @f_SHA=nil Then result := result + ' ' + fn_SHA;
  If @f_SHA_Transform=nil Then result := result + ' ' + fn_SHA_Transform;
  If @f_SHA1_Init=nil Then result := result + ' ' + fn_SHA1_Init;
  If @f_SHA1_Update=nil Then result := result + ' ' + fn_SHA1_Update;
  If @f_SHA1_Final=nil Then result := result + ' ' + fn_SHA1_Final;
  If @f_SHA1=nil Then result := result + ' ' + fn_SHA1;
  If @f_SHA1_Transform=nil Then result := result + ' ' + fn_SHA1_Transform;
  If @f_RIPEMD160_Init=nil Then result := result + ' ' + fn_RIPEMD160_Init;
  If @f_RIPEMD160_Update=nil Then result := result + ' ' + fn_RIPEMD160_Update;
  If @f_RIPEMD160_Final=nil Then result := result + ' ' + fn_RIPEMD160_Final;
  If @f_RIPEMD160=nil Then result := result + ' ' + fn_RIPEMD160;
  If @f_RIPEMD160_Transform=nil Then result := result + ' ' + fn_RIPEMD160_Transform;
  If @f_des_options=nil Then result := result + ' ' + fn_des_options;
  If @f_des_ecb3_encrypt=nil Then result := result + ' ' + fn_des_ecb3_encrypt;
  If @f_des_cbc_cksum=nil Then result := result + ' ' + fn_des_cbc_cksum;
  If @f_des_cbc_encrypt=nil Then result := result + ' ' + fn_des_cbc_encrypt;
  If @f_des_ncbc_encrypt=nil Then result := result + ' ' + fn_des_ncbc_encrypt;
  If @f_des_xcbc_encrypt=nil Then result := result + ' ' + fn_des_xcbc_encrypt;
  If @f_des_cfb_encrypt=nil Then result := result + ' ' + fn_des_cfb_encrypt;
  If @f_des_ecb_encrypt=nil Then result := result + ' ' + fn_des_ecb_encrypt;
  If @f_des_encrypt=nil Then result := result + ' ' + fn_des_encrypt;
  If @f_des_encrypt2=nil Then result := result + ' ' + fn_des_encrypt2;
  If @f_des_encrypt3=nil Then result := result + ' ' + fn_des_encrypt3;
  If @f_des_decrypt3=nil Then result := result + ' ' + fn_des_decrypt3;
  If @f_des_ede3_cbc_encrypt=nil Then result := result + ' ' + fn_des_ede3_cbc_encrypt;
  If @f_des_ede3_cbcm_encrypt=nil Then result := result + ' ' + fn_des_ede3_cbcm_encrypt;
  If @f_des_ede3_cfb64_encrypt=nil Then result := result + ' ' + fn_des_ede3_cfb64_encrypt;
  If @f_des_ede3_ofb64_encrypt=nil Then result := result + ' ' + fn_des_ede3_ofb64_encrypt;
  If @f_des_xwhite_in2out=nil Then result := result + ' ' + fn_des_xwhite_in2out;
  If @f_des_enc_read=nil Then result := result + ' ' + fn_des_enc_read;
  If @f_des_enc_write=nil Then result := result + ' ' + fn_des_enc_write;
  If @f_des_fcrypt=nil Then result := result + ' ' + fn_des_fcrypt;
  If @f_crypt=nil Then result := result + ' ' + fn_crypt;
  If @f_des_ofb_encrypt=nil Then result := result + ' ' + fn_des_ofb_encrypt;
  If @f_des_pcbc_encrypt=nil Then result := result + ' ' + fn_des_pcbc_encrypt;
  If @f_des_quad_cksum=nil Then result := result + ' ' + fn_des_quad_cksum;
  If @f_des_random_seed=nil Then result := result + ' ' + fn_des_random_seed;
  If @f_des_random_key=nil Then result := result + ' ' + fn_des_random_key;
  If @f_des_read_password=nil Then result := result + ' ' + fn_des_read_password;
  If @f_des_read_2passwords=nil Then result := result + ' ' + fn_des_read_2passwords;
  If @f_des_read_pw_string=nil Then result := result + ' ' + fn_des_read_pw_string;
  If @f_des_set_odd_parity=nil Then result := result + ' ' + fn_des_set_odd_parity;
  If @f_des_is_weak_key=nil Then result := result + ' ' + fn_des_is_weak_key;
  If @f_des_set_key=nil Then result := result + ' ' + fn_des_set_key;
  If @f_des_key_sched=nil Then result := result + ' ' + fn_des_key_sched;
  If @f_des_string_to_key=nil Then result := result + ' ' + fn_des_string_to_key;
  If @f_des_string_to_2keys=nil Then result := result + ' ' + fn_des_string_to_2keys;
  If @f_des_cfb64_encrypt=nil Then result := result + ' ' + fn_des_cfb64_encrypt;
  If @f_des_ofb64_encrypt=nil Then result := result + ' ' + fn_des_ofb64_encrypt;
  If @f_des_read_pw=nil Then result := result + ' ' + fn_des_read_pw;
  If @f_des_cblock_print_file=nil Then result := result + ' ' + fn_des_cblock_print_file;
  If @f_RC4_options=nil Then result := result + ' ' + fn_RC4_options;
  If @f_RC4_set_key=nil Then result := result + ' ' + fn_RC4_set_key;
  If @f_RC4=nil Then result := result + ' ' + fn_RC4;
  If @f_RC2_set_key=nil Then result := result + ' ' + fn_RC2_set_key;
  If @f_RC2_ecb_encrypt=nil Then result := result + ' ' + fn_RC2_ecb_encrypt;
  If @f_RC2_encrypt=nil Then result := result + ' ' + fn_RC2_encrypt;
  If @f_RC2_decrypt=nil Then result := result + ' ' + fn_RC2_decrypt;
  If @f_RC2_cbc_encrypt=nil Then result := result + ' ' + fn_RC2_cbc_encrypt;
  If @f_RC2_cfb64_encrypt=nil Then result := result + ' ' + fn_RC2_cfb64_encrypt;
  If @f_RC2_ofb64_encrypt=nil Then result := result + ' ' + fn_RC2_ofb64_encrypt;
  If @f_RC5_32_set_key=nil Then result := result + ' ' + fn_RC5_32_set_key;
  If @f_RC5_32_ecb_encrypt=nil Then result := result + ' ' + fn_RC5_32_ecb_encrypt;
  If @f_RC5_32_encrypt=nil Then result := result + ' ' + fn_RC5_32_encrypt;
  If @f_RC5_32_decrypt=nil Then result := result + ' ' + fn_RC5_32_decrypt;
  If @f_RC5_32_cbc_encrypt=nil Then result := result + ' ' + fn_RC5_32_cbc_encrypt;
  If @f_RC5_32_cfb64_encrypt=nil Then result := result + ' ' + fn_RC5_32_cfb64_encrypt;
  If @f_RC5_32_ofb64_encrypt=nil Then result := result + ' ' + fn_RC5_32_ofb64_encrypt;
  If @f_BF_set_key=nil Then result := result + ' ' + fn_BF_set_key;
  If @f_BF_ecb_encrypt=nil Then result := result + ' ' + fn_BF_ecb_encrypt;
  If @f_BF_encrypt=nil Then result := result + ' ' + fn_BF_encrypt;
  If @f_BF_decrypt=nil Then result := result + ' ' + fn_BF_decrypt;
  If @f_BF_cbc_encrypt=nil Then result := result + ' ' + fn_BF_cbc_encrypt;
  If @f_BF_cfb64_encrypt=nil Then result := result + ' ' + fn_BF_cfb64_encrypt;
  If @f_BF_ofb64_encrypt=nil Then result := result + ' ' + fn_BF_ofb64_encrypt;
  If @f_BF_options=nil Then result := result + ' ' + fn_BF_options;
  If @f_CAST_set_key=nil Then result := result + ' ' + fn_CAST_set_key;
  If @f_CAST_ecb_encrypt=nil Then result := result + ' ' + fn_CAST_ecb_encrypt;
  If @f_CAST_encrypt=nil Then result := result + ' ' + fn_CAST_encrypt;
  If @f_CAST_decrypt=nil Then result := result + ' ' + fn_CAST_decrypt;
  If @f_CAST_cbc_encrypt=nil Then result := result + ' ' + fn_CAST_cbc_encrypt;
  If @f_CAST_cfb64_encrypt=nil Then result := result + ' ' + fn_CAST_cfb64_encrypt;
  If @f_CAST_ofb64_encrypt=nil Then result := result + ' ' + fn_CAST_ofb64_encrypt;
  If @f_idea_options=nil Then result := result + ' ' + fn_idea_options;
  If @f_idea_ecb_encrypt=nil Then result := result + ' ' + fn_idea_ecb_encrypt;
  If @f_idea_set_encrypt_key=nil Then result := result + ' ' + fn_idea_set_encrypt_key;
  If @f_idea_set_decrypt_key=nil Then result := result + ' ' + fn_idea_set_decrypt_key;
  If @f_idea_cbc_encrypt=nil Then result := result + ' ' + fn_idea_cbc_encrypt;
  If @f_idea_cfb64_encrypt=nil Then result := result + ' ' + fn_idea_cfb64_encrypt;
  If @f_idea_ofb64_encrypt=nil Then result := result + ' ' + fn_idea_ofb64_encrypt;
  If @f_idea_encrypt=nil Then result := result + ' ' + fn_idea_encrypt;
  If @f_MDC2_Init=nil Then result := result + ' ' + fn_MDC2_Init;
  If @f_MDC2_Update=nil Then result := result + ' ' + fn_MDC2_Update;
  If @f_MDC2_Final=nil Then result := result + ' ' + fn_MDC2_Final;
  If @f_MDC2=nil Then result := result + ' ' + fn_MDC2;
  If @f_BN_value_one=nil Then result := result + ' ' + fn_BN_value_one;
  If @f_BN_options=nil Then result := result + ' ' + fn_BN_options;
  If @f_BN_CTX_new=nil Then result := result + ' ' + fn_BN_CTX_new;
  If @f_BN_CTX_init=nil Then result := result + ' ' + fn_BN_CTX_init;
  If @f_BN_CTX_free=nil Then result := result + ' ' + fn_BN_CTX_free;
  If @f_BN_rand=nil Then result := result + ' ' + fn_BN_rand;
  If @f_BN_num_bits=nil Then result := result + ' ' + fn_BN_num_bits;
  If @f_BN_num_bits_word=nil Then result := result + ' ' + fn_BN_num_bits_word;
  If @f_BN_new=nil Then result := result + ' ' + fn_BN_new;
  If @f_BN_init=nil Then result := result + ' ' + fn_BN_init;
  If @f_BN_clear_free=nil Then result := result + ' ' + fn_BN_clear_free;
  If @f_BN_copy=nil Then result := result + ' ' + fn_BN_copy;
  If @f_BN_bin2bn=nil Then result := result + ' ' + fn_BN_bin2bn;
  If @f_BN_bn2bin=nil Then result := result + ' ' + fn_BN_bn2bin;
  If @f_BN_mpi2bn=nil Then result := result + ' ' + fn_BN_mpi2bn;
  If @f_BN_bn2mpi=nil Then result := result + ' ' + fn_BN_bn2mpi;
  If @f_BN_sub=nil Then result := result + ' ' + fn_BN_sub;
  If @f_BN_usub=nil Then result := result + ' ' + fn_BN_usub;
  If @f_BN_uadd=nil Then result := result + ' ' + fn_BN_uadd;
  If @f_BN_add=nil Then result := result + ' ' + fn_BN_add;
  If @f_BN_mod=nil Then result := result + ' ' + fn_BN_mod;
  If @f_BN_div=nil Then result := result + ' ' + fn_BN_div;
  If @f_BN_mul=nil Then result := result + ' ' + fn_BN_mul;
  If @f_BN_sqr=nil Then result := result + ' ' + fn_BN_sqr;
  If @f_BN_mod_word=nil Then result := result + ' ' + fn_BN_mod_word;
  If @f_BN_div_word=nil Then result := result + ' ' + fn_BN_div_word;
  If @f_BN_mul_word=nil Then result := result + ' ' + fn_BN_mul_word;
  If @f_BN_add_word=nil Then result := result + ' ' + fn_BN_add_word;
  If @f_BN_sub_word=nil Then result := result + ' ' + fn_BN_sub_word;
  If @f_BN_set_word=nil Then result := result + ' ' + fn_BN_set_word;
  If @f_BN_get_word=nil Then result := result + ' ' + fn_BN_get_word;
  If @f_BN_cmp=nil Then result := result + ' ' + fn_BN_cmp;
  If @f_BN_free=nil Then result := result + ' ' + fn_BN_free;
  If @f_BN_is_bit_set=nil Then result := result + ' ' + fn_BN_is_bit_set;
  If @f_BN_lshift=nil Then result := result + ' ' + fn_BN_lshift;
  If @f_BN_lshift1=nil Then result := result + ' ' + fn_BN_lshift1;
  If @f_BN_exp=nil Then result := result + ' ' + fn_BN_exp;
  If @f_BN_mod_exp=nil Then result := result + ' ' + fn_BN_mod_exp;
  If @f_BN_mod_exp_mont=nil Then result := result + ' ' + fn_BN_mod_exp_mont;
  If @f_BN_mod_exp2_mont=nil Then result := result + ' ' + fn_BN_mod_exp2_mont;
  If @f_BN_mod_exp_simple=nil Then result := result + ' ' + fn_BN_mod_exp_simple;
  If @f_BN_mask_bits=nil Then result := result + ' ' + fn_BN_mask_bits;
  If @f_BN_mod_mul=nil Then result := result + ' ' + fn_BN_mod_mul;
  If @f_BN_print_fp=nil Then result := result + ' ' + fn_BN_print_fp;
  If @f_BN_print=nil Then result := result + ' ' + fn_BN_print;
  If @f_BN_reciprocal=nil Then result := result + ' ' + fn_BN_reciprocal;
  If @f_BN_rshift=nil Then result := result + ' ' + fn_BN_rshift;
  If @f_BN_rshift1=nil Then result := result + ' ' + fn_BN_rshift1;
  If @f_BN_clear=nil Then result := result + ' ' + fn_BN_clear;
  If @f_bn_expand2=nil Then result := result + ' ' + fn_bn_expand2;
  If @f_BN_dup=nil Then result := result + ' ' + fn_BN_dup;
  If @f_BN_ucmp=nil Then result := result + ' ' + fn_BN_ucmp;
  If @f_BN_set_bit=nil Then result := result + ' ' + fn_BN_set_bit;
  If @f_BN_clear_bit=nil Then result := result + ' ' + fn_BN_clear_bit;
  If @f_BN_bn2hex=nil Then result := result + ' ' + fn_BN_bn2hex;
  If @f_BN_bn2dec=nil Then result := result + ' ' + fn_BN_bn2dec;
  If @f_BN_hex2bn=nil Then result := result + ' ' + fn_BN_hex2bn;
  If @f_BN_dec2bn=nil Then result := result + ' ' + fn_BN_dec2bn;
  If @f_BN_gcd=nil Then result := result + ' ' + fn_BN_gcd;
  If @f_BN_mod_inverse=nil Then result := result + ' ' + fn_BN_mod_inverse;
  If @f_BN_generate_prime=nil Then result := result + ' ' + fn_BN_generate_prime;
  If @f_BN_is_prime=nil Then result := result + ' ' + fn_BN_is_prime;
  If @f_ERR_load_BN_strings=nil Then result := result + ' ' + fn_ERR_load_BN_strings;
  If @f_bn_mul_add_words=nil Then result := result + ' ' + fn_bn_mul_add_words;
  If @f_bn_mul_words=nil Then result := result + ' ' + fn_bn_mul_words;
  If @f_bn_sqr_words=nil Then result := result + ' ' + fn_bn_sqr_words;
  If @f_bn_div_words=nil Then result := result + ' ' + fn_bn_div_words;
  If @f_bn_add_words=nil Then result := result + ' ' + fn_bn_add_words;
  If @f_bn_sub_words=nil Then result := result + ' ' + fn_bn_sub_words;
  If @f_BN_MONT_CTX_new=nil Then result := result + ' ' + fn_BN_MONT_CTX_new;
  If @f_BN_MONT_CTX_init=nil Then result := result + ' ' + fn_BN_MONT_CTX_init;
  If @f_BN_mod_mul_montgomery=nil Then result := result + ' ' + fn_BN_mod_mul_montgomery;
  If @f_BN_from_montgomery=nil Then result := result + ' ' + fn_BN_from_montgomery;
  If @f_BN_MONT_CTX_free=nil Then result := result + ' ' + fn_BN_MONT_CTX_free;
  If @f_BN_MONT_CTX_set=nil Then result := result + ' ' + fn_BN_MONT_CTX_set;
  If @f_BN_MONT_CTX_copy=nil Then result := result + ' ' + fn_BN_MONT_CTX_copy;
  If @f_BN_BLINDING_new=nil Then result := result + ' ' + fn_BN_BLINDING_new;
  If @f_BN_BLINDING_free=nil Then result := result + ' ' + fn_BN_BLINDING_free;
  If @f_BN_BLINDING_update=nil Then result := result + ' ' + fn_BN_BLINDING_update;
  If @f_BN_BLINDING_convert=nil Then result := result + ' ' + fn_BN_BLINDING_convert;
  If @f_BN_BLINDING_invert=nil Then result := result + ' ' + fn_BN_BLINDING_invert;
  If @f_BN_set_params=nil Then result := result + ' ' + fn_BN_set_params;
  If @f_BN_get_params=nil Then result := result + ' ' + fn_BN_get_params;
  If @f_BN_RECP_CTX_init=nil Then result := result + ' ' + fn_BN_RECP_CTX_init;
  If @f_BN_RECP_CTX_new=nil Then result := result + ' ' + fn_BN_RECP_CTX_new;
  If @f_BN_RECP_CTX_free=nil Then result := result + ' ' + fn_BN_RECP_CTX_free;
  If @f_BN_RECP_CTX_set=nil Then result := result + ' ' + fn_BN_RECP_CTX_set;
  If @f_BN_mod_mul_reciprocal=nil Then result := result + ' ' + fn_BN_mod_mul_reciprocal;
  If @f_BN_mod_exp_recp=nil Then result := result + ' ' + fn_BN_mod_exp_recp;
  If @f_BN_div_recp=nil Then result := result + ' ' + fn_BN_div_recp;
  If @f_RSA_new=nil Then result := result + ' ' + fn_RSA_new;
  If @f_RSA_new_method=nil Then result := result + ' ' + fn_RSA_new_method;
  If @f_RSA_size=nil Then result := result + ' ' + fn_RSA_size;
  If @f_RSA_generate_key=nil Then result := result + ' ' + fn_RSA_generate_key;
  If @f_RSA_check_key=nil Then result := result + ' ' + fn_RSA_check_key;
  If @f_RSA_public_encrypt=nil Then result := result + ' ' + fn_RSA_public_encrypt;
  If @f_RSA_private_encrypt=nil Then result := result + ' ' + fn_RSA_private_encrypt;
  If @f_RSA_public_decrypt=nil Then result := result + ' ' + fn_RSA_public_decrypt;
  If @f_RSA_private_decrypt=nil Then result := result + ' ' + fn_RSA_private_decrypt;
  If @f_RSA_free=nil Then result := result + ' ' + fn_RSA_free;
  If @f_RSA_flags=nil Then result := result + ' ' + fn_RSA_flags;
  If @f_RSA_set_default_method=nil Then result := result + ' ' + fn_RSA_set_default_method;
  If @f_RSA_get_default_method=nil Then result := result + ' ' + fn_RSA_get_default_method;
  If @f_RSA_get_method=nil Then result := result + ' ' + fn_RSA_get_method;
  If @f_RSA_set_method=nil Then result := result + ' ' + fn_RSA_set_method;
  If @f_RSA_memory_lock=nil Then result := result + ' ' + fn_RSA_memory_lock;
  If @f_RSA_PKCS1_SSLeay=nil Then result := result + ' ' + fn_RSA_PKCS1_SSLeay;
  If @f_ERR_load_RSA_strings=nil Then result := result + ' ' + fn_ERR_load_RSA_strings;
  If @f_d2i_RSAPublicKey=nil Then result := result + ' ' + fn_d2i_RSAPublicKey;
  If @f_i2d_RSAPublicKey=nil Then result := result + ' ' + fn_i2d_RSAPublicKey;
  If @f_d2i_RSAPrivateKey=nil Then result := result + ' ' + fn_d2i_RSAPrivateKey;
  If @f_i2d_RSAPrivateKey=nil Then result := result + ' ' + fn_i2d_RSAPrivateKey;
  If @f_RSA_print_fp=nil Then result := result + ' ' + fn_RSA_print_fp;
  If @f_RSA_print=nil Then result := result + ' ' + fn_RSA_print;
  If @f_i2d_Netscape_RSA=nil Then result := result + ' ' + fn_i2d_Netscape_RSA;
  If @f_d2i_Netscape_RSA=nil Then result := result + ' ' + fn_d2i_Netscape_RSA;
  If @f_d2i_Netscape_RSA_2=nil Then result := result + ' ' + fn_d2i_Netscape_RSA_2;
  If @f_RSA_sign=nil Then result := result + ' ' + fn_RSA_sign;
  If @f_RSA_verify=nil Then result := result + ' ' + fn_RSA_verify;
  If @f_RSA_sign_ASN1_OCTET_STRING=nil Then result := result + ' ' + fn_RSA_sign_ASN1_OCTET_STRING;
  If @f_RSA_verify_ASN1_OCTET_STRING=nil Then result := result + ' ' + fn_RSA_verify_ASN1_OCTET_STRING;
  If @f_RSA_blinding_on=nil Then result := result + ' ' + fn_RSA_blinding_on;
  If @f_RSA_blinding_off=nil Then result := result + ' ' + fn_RSA_blinding_off;
  If @f_RSA_padding_add_PKCS1_type_1=nil Then result := result + ' ' + fn_RSA_padding_add_PKCS1_type_1;
  If @f_RSA_padding_check_PKCS1_type_1=nil Then result := result + ' ' + fn_RSA_padding_check_PKCS1_type_1;
  If @f_RSA_padding_add_PKCS1_type_2=nil Then result := result + ' ' + fn_RSA_padding_add_PKCS1_type_2;
  If @f_RSA_padding_check_PKCS1_type_2=nil Then result := result + ' ' + fn_RSA_padding_check_PKCS1_type_2;
  If @f_RSA_padding_add_PKCS1_OAEP=nil Then result := result + ' ' + fn_RSA_padding_add_PKCS1_OAEP;
  If @f_RSA_padding_check_PKCS1_OAEP=nil Then result := result + ' ' + fn_RSA_padding_check_PKCS1_OAEP;
  If @f_RSA_padding_add_SSLv23=nil Then result := result + ' ' + fn_RSA_padding_add_SSLv23;
  If @f_RSA_padding_check_SSLv23=nil Then result := result + ' ' + fn_RSA_padding_check_SSLv23;
  If @f_RSA_padding_add_none=nil Then result := result + ' ' + fn_RSA_padding_add_none;
  If @f_RSA_padding_check_none=nil Then result := result + ' ' + fn_RSA_padding_check_none;
  If @f_RSA_get_ex_new_index=nil Then result := result + ' ' + fn_RSA_get_ex_new_index;
  If @f_RSA_set_ex_data=nil Then result := result + ' ' + fn_RSA_set_ex_data;
  If @f_RSA_get_ex_data=nil Then result := result + ' ' + fn_RSA_get_ex_data;
  If @f_DH_new=nil Then result := result + ' ' + fn_DH_new;
  If @f_DH_free=nil Then result := result + ' ' + fn_DH_free;
  If @f_DH_size=nil Then result := result + ' ' + fn_DH_size;
  If @f_DH_generate_parameters=nil Then result := result + ' ' + fn_DH_generate_parameters;
  If @f_DH_check=nil Then result := result + ' ' + fn_DH_check;
  If @f_DH_generate_key=nil Then result := result + ' ' + fn_DH_generate_key;
  If @f_DH_compute_key=nil Then result := result + ' ' + fn_DH_compute_key;
  If @f_d2i_DHparams=nil Then result := result + ' ' + fn_d2i_DHparams;
  If @f_i2d_DHparams=nil Then result := result + ' ' + fn_i2d_DHparams;
  If @f_DHparams_print_fp=nil Then result := result + ' ' + fn_DHparams_print_fp;
  If @f_DHparams_print=nil Then result := result + ' ' + fn_DHparams_print;
  If @f_ERR_load_DH_strings=nil Then result := result + ' ' + fn_ERR_load_DH_strings;
  If @f_DSA_SIG_new=nil Then result := result + ' ' + fn_DSA_SIG_new;
  If @f_DSA_SIG_free=nil Then result := result + ' ' + fn_DSA_SIG_free;
  If @f_i2d_DSA_SIG=nil Then result := result + ' ' + fn_i2d_DSA_SIG;
  If @f_d2i_DSA_SIG=nil Then result := result + ' ' + fn_d2i_DSA_SIG;
  If @f_DSA_do_sign=nil Then result := result + ' ' + fn_DSA_do_sign;
  If @f_DSA_do_verify=nil Then result := result + ' ' + fn_DSA_do_verify;
  If @f_DSA_new=nil Then result := result + ' ' + fn_DSA_new;
  If @f_DSA_size=nil Then result := result + ' ' + fn_DSA_size;
  If @f_DSA_sign_setup=nil Then result := result + ' ' + fn_DSA_sign_setup;
  If @f_DSA_sign=nil Then result := result + ' ' + fn_DSA_sign;
  If @f_DSA_verify=nil Then result := result + ' ' + fn_DSA_verify;
  If @f_DSA_free=nil Then result := result + ' ' + fn_DSA_free;
  If @f_ERR_load_DSA_strings=nil Then result := result + ' ' + fn_ERR_load_DSA_strings;
  If @f_d2i_DSAPublicKey=nil Then result := result + ' ' + fn_d2i_DSAPublicKey;
  If @f_d2i_DSAPrivateKey=nil Then result := result + ' ' + fn_d2i_DSAPrivateKey;
  If @f_d2i_DSAparams=nil Then result := result + ' ' + fn_d2i_DSAparams;
  If @f_DSA_generate_parameters=nil Then result := result + ' ' + fn_DSA_generate_parameters;
  If @f_DSA_generate_key=nil Then result := result + ' ' + fn_DSA_generate_key;
  If @f_i2d_DSAPublicKey=nil Then result := result + ' ' + fn_i2d_DSAPublicKey;
  If @f_i2d_DSAPrivateKey=nil Then result := result + ' ' + fn_i2d_DSAPrivateKey;
  If @f_i2d_DSAparams=nil Then result := result + ' ' + fn_i2d_DSAparams;
  If @f_DSAparams_print=nil Then result := result + ' ' + fn_DSAparams_print;
  If @f_DSA_print=nil Then result := result + ' ' + fn_DSA_print;
  If @f_DSAparams_print_fp=nil Then result := result + ' ' + fn_DSAparams_print_fp;
  If @f_DSA_print_fp=nil Then result := result + ' ' + fn_DSA_print_fp;
  If @f_DSA_is_prime=nil Then result := result + ' ' + fn_DSA_is_prime;
  If @f_DSA_dup_DH=nil Then result := result + ' ' + fn_DSA_dup_DH;
  If @f_sk_ASN1_TYPE_new=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_new;
  If @f_sk_ASN1_TYPE_new_null=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_new_null;
  If @f_sk_ASN1_TYPE_free=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_free;
  If @f_sk_ASN1_TYPE_num=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_num;
  If @f_sk_ASN1_TYPE_value=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_value;
  If @f_sk_ASN1_TYPE_set=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_set;
  If @f_sk_ASN1_TYPE_zero=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_zero;
  If @f_sk_ASN1_TYPE_push=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_push;
  If @f_sk_ASN1_TYPE_unshift=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_unshift;
  If @f_sk_ASN1_TYPE_find=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_find;
  If @f_sk_ASN1_TYPE_delete=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_delete;
  If @f_sk_ASN1_TYPE_delete_ptr=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_delete_ptr;
  If @f_sk_ASN1_TYPE_insert=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_insert;
  If @f_sk_ASN1_TYPE_dup=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_dup;
  If @f_sk_ASN1_TYPE_pop_free=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_pop_free;
  If @f_sk_ASN1_TYPE_shift=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_shift;
  If @f_sk_ASN1_TYPE_pop=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_pop;
  If @f_sk_ASN1_TYPE_sort=nil Then result := result + ' ' + fn_sk_ASN1_TYPE_sort;
  If @f_i2d_ASN1_SET_OF_ASN1_TYPE=nil Then result := result + ' ' + fn_i2d_ASN1_SET_OF_ASN1_TYPE;
  If @f_d2i_ASN1_SET_OF_ASN1_TYPE=nil Then result := result + ' ' + fn_d2i_ASN1_SET_OF_ASN1_TYPE;
  If @f_ASN1_TYPE_new=nil Then result := result + ' ' + fn_ASN1_TYPE_new;
  If @f_ASN1_TYPE_free=nil Then result := result + ' ' + fn_ASN1_TYPE_free;
  If @f_i2d_ASN1_TYPE=nil Then result := result + ' ' + fn_i2d_ASN1_TYPE;
  If @f_d2i_ASN1_TYPE=nil Then result := result + ' ' + fn_d2i_ASN1_TYPE;
  If @f_ASN1_TYPE_get=nil Then result := result + ' ' + fn_ASN1_TYPE_get;
  If @f_ASN1_TYPE_set=nil Then result := result + ' ' + fn_ASN1_TYPE_set;
  If @f_ASN1_OBJECT_new=nil Then result := result + ' ' + fn_ASN1_OBJECT_new;
  If @f_ASN1_OBJECT_free=nil Then result := result + ' ' + fn_ASN1_OBJECT_free;
  If @f_i2d_ASN1_OBJECT=nil Then result := result + ' ' + fn_i2d_ASN1_OBJECT;
  If @f_d2i_ASN1_OBJECT=nil Then result := result + ' ' + fn_d2i_ASN1_OBJECT;
  If @f_sk_ASN1_OBJECT_new=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_new;
  If @f_sk_ASN1_OBJECT_new_null=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_new_null;
  If @f_sk_ASN1_OBJECT_free=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_free;
  If @f_sk_ASN1_OBJECT_num=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_num;
  If @f_sk_ASN1_OBJECT_value=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_value;
  If @f_sk_ASN1_OBJECT_set=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_set;
  If @f_sk_ASN1_OBJECT_zero=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_zero;
  If @f_sk_ASN1_OBJECT_push=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_push;
  If @f_sk_ASN1_OBJECT_unshift=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_unshift;
  If @f_sk_ASN1_OBJECT_find=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_find;
  If @f_sk_ASN1_OBJECT_delete=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_delete;
  If @f_sk_ASN1_OBJECT_delete_ptr=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_delete_ptr;
  If @f_sk_ASN1_OBJECT_insert=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_insert;
  If @f_sk_ASN1_OBJECT_dup=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_dup;
  If @f_sk_ASN1_OBJECT_pop_free=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_pop_free;
  If @f_sk_ASN1_OBJECT_shift=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_shift;
  If @f_sk_ASN1_OBJECT_pop=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_pop;
  If @f_sk_ASN1_OBJECT_sort=nil Then result := result + ' ' + fn_sk_ASN1_OBJECT_sort;
  If @f_i2d_ASN1_SET_OF_ASN1_OBJECT=nil Then result := result + ' ' + fn_i2d_ASN1_SET_OF_ASN1_OBJECT;
  If @f_d2i_ASN1_SET_OF_ASN1_OBJECT=nil Then result := result + ' ' + fn_d2i_ASN1_SET_OF_ASN1_OBJECT;
  If @f_ASN1_STRING_new=nil Then result := result + ' ' + fn_ASN1_STRING_new;
  If @f_ASN1_STRING_free=nil Then result := result + ' ' + fn_ASN1_STRING_free;
  If @f_ASN1_STRING_dup=nil Then result := result + ' ' + fn_ASN1_STRING_dup;
  If @f_ASN1_STRING_type_new=nil Then result := result + ' ' + fn_ASN1_STRING_type_new;
  If @f_ASN1_STRING_cmp=nil Then result := result + ' ' + fn_ASN1_STRING_cmp;
  If @f_ASN1_STRING_set=nil Then result := result + ' ' + fn_ASN1_STRING_set;
  If @f_i2d_ASN1_BIT_STRING=nil Then result := result + ' ' + fn_i2d_ASN1_BIT_STRING;
  If @f_d2i_ASN1_BIT_STRING=nil Then result := result + ' ' + fn_d2i_ASN1_BIT_STRING;
  If @f_ASN1_BIT_STRING_set_bit=nil Then result := result + ' ' + fn_ASN1_BIT_STRING_set_bit;
  If @f_ASN1_BIT_STRING_get_bit=nil Then result := result + ' ' + fn_ASN1_BIT_STRING_get_bit;
  If @f_i2d_ASN1_BOOLEAN=nil Then result := result + ' ' + fn_i2d_ASN1_BOOLEAN;
  If @f_d2i_ASN1_BOOLEAN=nil Then result := result + ' ' + fn_d2i_ASN1_BOOLEAN;
  If @f_i2d_ASN1_INTEGER=nil Then result := result + ' ' + fn_i2d_ASN1_INTEGER;
  If @f_d2i_ASN1_INTEGER=nil Then result := result + ' ' + fn_d2i_ASN1_INTEGER;
  If @f_d2i_ASN1_UINTEGER=nil Then result := result + ' ' + fn_d2i_ASN1_UINTEGER;
  If @f_i2d_ASN1_ENUMERATED=nil Then result := result + ' ' + fn_i2d_ASN1_ENUMERATED;
  If @f_d2i_ASN1_ENUMERATED=nil Then result := result + ' ' + fn_d2i_ASN1_ENUMERATED;
  If @f_ASN1_UTCTIME_check=nil Then result := result + ' ' + fn_ASN1_UTCTIME_check;
  If @f_ASN1_UTCTIME_set=nil Then result := result + ' ' + fn_ASN1_UTCTIME_set;
  If @f_ASN1_UTCTIME_set_string=nil Then result := result + ' ' + fn_ASN1_UTCTIME_set_string;
  If @f_ASN1_GENERALIZEDTIME_check=nil Then result := result + ' ' + fn_ASN1_GENERALIZEDTIME_check;
  If @f_ASN1_GENERALIZEDTIME_set=nil Then result := result + ' ' + fn_ASN1_GENERALIZEDTIME_set;
  If @f_ASN1_GENERALIZEDTIME_set_string=nil Then result := result + ' ' + fn_ASN1_GENERALIZEDTIME_set_string;
  If @f_i2d_ASN1_OCTET_STRING=nil Then result := result + ' ' + fn_i2d_ASN1_OCTET_STRING;
  If @f_d2i_ASN1_OCTET_STRING=nil Then result := result + ' ' + fn_d2i_ASN1_OCTET_STRING;
  If @f_i2d_ASN1_VISIBLESTRING=nil Then result := result + ' ' + fn_i2d_ASN1_VISIBLESTRING;
  If @f_d2i_ASN1_VISIBLESTRING=nil Then result := result + ' ' + fn_d2i_ASN1_VISIBLESTRING;
  If @f_i2d_ASN1_UTF8STRING=nil Then result := result + ' ' + fn_i2d_ASN1_UTF8STRING;
  If @f_d2i_ASN1_UTF8STRING=nil Then result := result + ' ' + fn_d2i_ASN1_UTF8STRING;
  If @f_i2d_ASN1_BMPSTRING=nil Then result := result + ' ' + fn_i2d_ASN1_BMPSTRING;
  If @f_d2i_ASN1_BMPSTRING=nil Then result := result + ' ' + fn_d2i_ASN1_BMPSTRING;
  If @f_i2d_ASN1_PRINTABLE=nil Then result := result + ' ' + fn_i2d_ASN1_PRINTABLE;
  If @f_d2i_ASN1_PRINTABLE=nil Then result := result + ' ' + fn_d2i_ASN1_PRINTABLE;
  If @f_d2i_ASN1_PRINTABLESTRING=nil Then result := result + ' ' + fn_d2i_ASN1_PRINTABLESTRING;
  If @f_i2d_DIRECTORYSTRING=nil Then result := result + ' ' + fn_i2d_DIRECTORYSTRING;
  If @f_d2i_DIRECTORYSTRING=nil Then result := result + ' ' + fn_d2i_DIRECTORYSTRING;
  If @f_i2d_DISPLAYTEXT=nil Then result := result + ' ' + fn_i2d_DISPLAYTEXT;
  If @f_d2i_DISPLAYTEXT=nil Then result := result + ' ' + fn_d2i_DISPLAYTEXT;
  If @f_d2i_ASN1_T61STRING=nil Then result := result + ' ' + fn_d2i_ASN1_T61STRING;
  If @f_i2d_ASN1_IA5STRING=nil Then result := result + ' ' + fn_i2d_ASN1_IA5STRING;
  If @f_d2i_ASN1_IA5STRING=nil Then result := result + ' ' + fn_d2i_ASN1_IA5STRING;
  If @f_i2d_ASN1_UTCTIME=nil Then result := result + ' ' + fn_i2d_ASN1_UTCTIME;
  If @f_d2i_ASN1_UTCTIME=nil Then result := result + ' ' + fn_d2i_ASN1_UTCTIME;
  If @f_i2d_ASN1_GENERALIZEDTIME=nil Then result := result + ' ' + fn_i2d_ASN1_GENERALIZEDTIME;
  If @f_d2i_ASN1_GENERALIZEDTIME=nil Then result := result + ' ' + fn_d2i_ASN1_GENERALIZEDTIME;
  If @f_i2d_ASN1_TIME=nil Then result := result + ' ' + fn_i2d_ASN1_TIME;
  If @f_d2i_ASN1_TIME=nil Then result := result + ' ' + fn_d2i_ASN1_TIME;
  If @f_ASN1_TIME_set=nil Then result := result + ' ' + fn_ASN1_TIME_set;
  If @f_i2d_ASN1_SET=nil Then result := result + ' ' + fn_i2d_ASN1_SET;
  If @f_d2i_ASN1_SET=nil Then result := result + ' ' + fn_d2i_ASN1_SET;
  If @f_i2a_ASN1_INTEGER=nil Then result := result + ' ' + fn_i2a_ASN1_INTEGER;
  If @f_a2i_ASN1_INTEGER=nil Then result := result + ' ' + fn_a2i_ASN1_INTEGER;
  If @f_i2a_ASN1_ENUMERATED=nil Then result := result + ' ' + fn_i2a_ASN1_ENUMERATED;
  If @f_a2i_ASN1_ENUMERATED=nil Then result := result + ' ' + fn_a2i_ASN1_ENUMERATED;
  If @f_i2a_ASN1_OBJECT=nil Then result := result + ' ' + fn_i2a_ASN1_OBJECT;
  If @f_a2i_ASN1_STRING=nil Then result := result + ' ' + fn_a2i_ASN1_STRING;
  If @f_i2a_ASN1_STRING=nil Then result := result + ' ' + fn_i2a_ASN1_STRING;
  If @f_i2t_ASN1_OBJECT=nil Then result := result + ' ' + fn_i2t_ASN1_OBJECT;
  If @f_a2d_ASN1_OBJECT=nil Then result := result + ' ' + fn_a2d_ASN1_OBJECT;
  If @f_ASN1_OBJECT_create=nil Then result := result + ' ' + fn_ASN1_OBJECT_create;
  If @f_ASN1_INTEGER_set=nil Then result := result + ' ' + fn_ASN1_INTEGER_set;
  If @f_ASN1_INTEGER_get=nil Then result := result + ' ' + fn_ASN1_INTEGER_get;
  If @f_BN_to_ASN1_INTEGER=nil Then result := result + ' ' + fn_BN_to_ASN1_INTEGER;
  If @f_ASN1_INTEGER_to_BN=nil Then result := result + ' ' + fn_ASN1_INTEGER_to_BN;
  If @f_ASN1_ENUMERATED_set=nil Then result := result + ' ' + fn_ASN1_ENUMERATED_set;
  If @f_ASN1_ENUMERATED_get=nil Then result := result + ' ' + fn_ASN1_ENUMERATED_get;
  If @f_BN_to_ASN1_ENUMERATED=nil Then result := result + ' ' + fn_BN_to_ASN1_ENUMERATED;
  If @f_ASN1_ENUMERATED_to_BN=nil Then result := result + ' ' + fn_ASN1_ENUMERATED_to_BN;
  If @f_ASN1_PRINTABLE_type=nil Then result := result + ' ' + fn_ASN1_PRINTABLE_type;
  If @f_i2d_ASN1_bytes=nil Then result := result + ' ' + fn_i2d_ASN1_bytes;
  If @f_d2i_ASN1_bytes=nil Then result := result + ' ' + fn_d2i_ASN1_bytes;
  If @f_d2i_ASN1_type_bytes=nil Then result := result + ' ' + fn_d2i_ASN1_type_bytes;
  If @f_asn1_Finish=nil Then result := result + ' ' + fn_asn1_Finish;
  If @f_ASN1_get_object=nil Then result := result + ' ' + fn_ASN1_get_object;
  If @f_ASN1_check_infinite_end=nil Then result := result + ' ' + fn_ASN1_check_infinite_end;
  If @f_ASN1_put_object=nil Then result := result + ' ' + fn_ASN1_put_object;
  If @f_ASN1_object_size=nil Then result := result + ' ' + fn_ASN1_object_size;
  If @f_ASN1_dup=nil Then result := result + ' ' + fn_ASN1_dup;
  If @f_ASN1_d2i_fp=nil Then result := result + ' ' + fn_ASN1_d2i_fp;
  If @f_ASN1_i2d_fp=nil Then result := result + ' ' + fn_ASN1_i2d_fp;
  If @f_ASN1_d2i_bio=nil Then result := result + ' ' + fn_ASN1_d2i_bio;
  If @f_ASN1_i2d_bio=nil Then result := result + ' ' + fn_ASN1_i2d_bio;
  If @f_ASN1_UTCTIME_print=nil Then result := result + ' ' + fn_ASN1_UTCTIME_print;
  If @f_ASN1_GENERALIZEDTIME_print=nil Then result := result + ' ' + fn_ASN1_GENERALIZEDTIME_print;
  If @f_ASN1_TIME_print=nil Then result := result + ' ' + fn_ASN1_TIME_print;
  If @f_ASN1_STRING_print=nil Then result := result + ' ' + fn_ASN1_STRING_print;
  If @f_ASN1_parse=nil Then result := result + ' ' + fn_ASN1_parse;
  If @f_i2d_ASN1_HEADER=nil Then result := result + ' ' + fn_i2d_ASN1_HEADER;
  If @f_d2i_ASN1_HEADER=nil Then result := result + ' ' + fn_d2i_ASN1_HEADER;
  If @f_ASN1_HEADER_new=nil Then result := result + ' ' + fn_ASN1_HEADER_new;
  If @f_ASN1_HEADER_free=nil Then result := result + ' ' + fn_ASN1_HEADER_free;
  If @f_ASN1_UNIVERSALSTRING_to_string=nil Then result := result + ' ' + fn_ASN1_UNIVERSALSTRING_to_string;
  If @f_ERR_load_ASN1_strings=nil Then result := result + ' ' + fn_ERR_load_ASN1_strings;
  If @f_X509_asn1_meth=nil Then result := result + ' ' + fn_X509_asn1_meth;
  If @f_RSAPrivateKey_asn1_meth=nil Then result := result + ' ' + fn_RSAPrivateKey_asn1_meth;
  If @f_ASN1_IA5STRING_asn1_meth=nil Then result := result + ' ' + fn_ASN1_IA5STRING_asn1_meth;
  If @f_ASN1_BIT_STRING_asn1_meth=nil Then result := result + ' ' + fn_ASN1_BIT_STRING_asn1_meth;
  If @f_ASN1_TYPE_set_octetstring=nil Then result := result + ' ' + fn_ASN1_TYPE_set_octetstring;
  If @f_ASN1_TYPE_get_octetstring=nil Then result := result + ' ' + fn_ASN1_TYPE_get_octetstring;
  If @f_ASN1_TYPE_set_int_octetstring=nil Then result := result + ' ' + fn_ASN1_TYPE_set_int_octetstring;
  If @f_ASN1_TYPE_get_int_octetstring=nil Then result := result + ' ' + fn_ASN1_TYPE_get_int_octetstring;
  If @f_ASN1_seq_unpack=nil Then result := result + ' ' + fn_ASN1_seq_unpack;
  If @f_ASN1_seq_pack=nil Then result := result + ' ' + fn_ASN1_seq_pack;
  If @f_ASN1_unpack_string=nil Then result := result + ' ' + fn_ASN1_unpack_string;
  If @f_ASN1_pack_string=nil Then result := result + ' ' + fn_ASN1_pack_string;
  If @f_OBJ_NAME_init=nil Then result := result + ' ' + fn_OBJ_NAME_init;
  If @f_OBJ_NAME_new_index=nil Then result := result + ' ' + fn_OBJ_NAME_new_index;
  If @f_OBJ_NAME_get=nil Then result := result + ' ' + fn_OBJ_NAME_get;
  If @f_OBJ_NAME_add=nil Then result := result + ' ' + fn_OBJ_NAME_add;
  If @f_OBJ_NAME_remove=nil Then result := result + ' ' + fn_OBJ_NAME_remove;
  If @f_OBJ_NAME_cleanup=nil Then result := result + ' ' + fn_OBJ_NAME_cleanup;
  If @f_OBJ_dup=nil Then result := result + ' ' + fn_OBJ_dup;
  If @f_OBJ_nid2obj=nil Then result := result + ' ' + fn_OBJ_nid2obj;
  If @f_OBJ_nid2ln=nil Then result := result + ' ' + fn_OBJ_nid2ln;
  If @f_OBJ_nid2sn=nil Then result := result + ' ' + fn_OBJ_nid2sn;
  If @f_OBJ_obj2nid=nil Then result := result + ' ' + fn_OBJ_obj2nid;
  If @f_OBJ_txt2obj=nil Then result := result + ' ' + fn_OBJ_txt2obj;
  If @f_OBJ_obj2txt=nil Then result := result + ' ' + fn_OBJ_obj2txt;
  If @f_OBJ_txt2nid=nil Then result := result + ' ' + fn_OBJ_txt2nid;
  If @f_OBJ_ln2nid=nil Then result := result + ' ' + fn_OBJ_ln2nid;
  If @f_OBJ_sn2nid=nil Then result := result + ' ' + fn_OBJ_sn2nid;
  If @f_OBJ_cmp=nil Then result := result + ' ' + fn_OBJ_cmp;
  If @f_OBJ_bsearch=nil Then result := result + ' ' + fn_OBJ_bsearch;
  If @f_ERR_load_OBJ_strings=nil Then result := result + ' ' + fn_ERR_load_OBJ_strings;
  If @f_OBJ_new_nid=nil Then result := result + ' ' + fn_OBJ_new_nid;
  If @f_OBJ_add_object=nil Then result := result + ' ' + fn_OBJ_add_object;
  If @f_OBJ_create=nil Then result := result + ' ' + fn_OBJ_create;
  If @f_OBJ_cleanup=nil Then result := result + ' ' + fn_OBJ_cleanup;
  If @f_OBJ_create_objects=nil Then result := result + ' ' + fn_OBJ_create_objects;
  If @f_EVP_MD_CTX_copy=nil Then result := result + ' ' + fn_EVP_MD_CTX_copy;
  If @f_EVP_DigestInit=nil Then result := result + ' ' + fn_EVP_DigestInit;
  If @f_EVP_DigestUpdate=nil Then result := result + ' ' + fn_EVP_DigestUpdate;
  If @f_EVP_DigestFinal=nil Then result := result + ' ' + fn_EVP_DigestFinal;
  If @f_EVP_read_pw_string=nil Then result := result + ' ' + fn_EVP_read_pw_string;
  If @f_EVP_set_pw_prompt=nil Then result := result + ' ' + fn_EVP_set_pw_prompt;
  If @f_EVP_get_pw_prompt=nil Then result := result + ' ' + fn_EVP_get_pw_prompt;
  If @f_EVP_BytesToKey=nil Then result := result + ' ' + fn_EVP_BytesToKey;
  If @f_EVP_EncryptInit=nil Then result := result + ' ' + fn_EVP_EncryptInit;
  If @f_EVP_EncryptUpdate=nil Then result := result + ' ' + fn_EVP_EncryptUpdate;
  If @f_EVP_EncryptFinal=nil Then result := result + ' ' + fn_EVP_EncryptFinal;
  If @f_EVP_DecryptInit=nil Then result := result + ' ' + fn_EVP_DecryptInit;
  If @f_EVP_DecryptUpdate=nil Then result := result + ' ' + fn_EVP_DecryptUpdate;
  If @f_EVP_DecryptFinal=nil Then result := result + ' ' + fn_EVP_DecryptFinal;
  If @f_EVP_CipherInit=nil Then result := result + ' ' + fn_EVP_CipherInit;
  If @f_EVP_CipherUpdate=nil Then result := result + ' ' + fn_EVP_CipherUpdate;
  If @f_EVP_CipherFinal=nil Then result := result + ' ' + fn_EVP_CipherFinal;
  If @f_EVP_SignFinal=nil Then result := result + ' ' + fn_EVP_SignFinal;
  If @f_EVP_VerifyFinal=nil Then result := result + ' ' + fn_EVP_VerifyFinal;
  If @f_EVP_OpenInit=nil Then result := result + ' ' + fn_EVP_OpenInit;
  If @f_EVP_OpenFinal=nil Then result := result + ' ' + fn_EVP_OpenFinal;
  If @f_EVP_SealInit=nil Then result := result + ' ' + fn_EVP_SealInit;
  If @f_EVP_SealFinal=nil Then result := result + ' ' + fn_EVP_SealFinal;
  If @f_EVP_EncodeInit=nil Then result := result + ' ' + fn_EVP_EncodeInit;
  If @f_EVP_EncodeUpdate=nil Then result := result + ' ' + fn_EVP_EncodeUpdate;
  If @f_EVP_EncodeFinal=nil Then result := result + ' ' + fn_EVP_EncodeFinal;
  If @f_EVP_EncodeBlock=nil Then result := result + ' ' + fn_EVP_EncodeBlock;
  If @f_EVP_DecodeInit=nil Then result := result + ' ' + fn_EVP_DecodeInit;
  If @f_EVP_DecodeUpdate=nil Then result := result + ' ' + fn_EVP_DecodeUpdate;
  If @f_EVP_DecodeFinal=nil Then result := result + ' ' + fn_EVP_DecodeFinal;
  If @f_EVP_DecodeBlock=nil Then result := result + ' ' + fn_EVP_DecodeBlock;
  If @f_ERR_load_EVP_strings=nil Then result := result + ' ' + fn_ERR_load_EVP_strings;
  If @f_EVP_CIPHER_CTX_init=nil Then result := result + ' ' + fn_EVP_CIPHER_CTX_init;
  If @f_EVP_CIPHER_CTX_cleanup=nil Then result := result + ' ' + fn_EVP_CIPHER_CTX_cleanup;
  If @f_BIO_f_md=nil Then result := result + ' ' + fn_BIO_f_md;
  If @f_BIO_f_base64=nil Then result := result + ' ' + fn_BIO_f_base64;
  If @f_BIO_f_cipher=nil Then result := result + ' ' + fn_BIO_f_cipher;
  If @f_BIO_f_reliable=nil Then result := result + ' ' + fn_BIO_f_reliable;
  If @f_BIO_set_cipher=nil Then result := result + ' ' + fn_BIO_set_cipher;
  If @f_EVP_md_null=nil Then result := result + ' ' + fn_EVP_md_null;
  If @f_EVP_md2=nil Then result := result + ' ' + fn_EVP_md2;
  If @f_EVP_md5=nil Then result := result + ' ' + fn_EVP_md5;
  If @f_EVP_sha=nil Then result := result + ' ' + fn_EVP_sha;
  If @f_EVP_sha1=nil Then result := result + ' ' + fn_EVP_sha1;
  If @f_EVP_dss=nil Then result := result + ' ' + fn_EVP_dss;
  If @f_EVP_dss1=nil Then result := result + ' ' + fn_EVP_dss1;
  If @f_EVP_mdc2=nil Then result := result + ' ' + fn_EVP_mdc2;
  If @f_EVP_ripemd160=nil Then result := result + ' ' + fn_EVP_ripemd160;
  If @f_EVP_enc_null=nil Then result := result + ' ' + fn_EVP_enc_null;
  If @f_EVP_des_ecb=nil Then result := result + ' ' + fn_EVP_des_ecb;
  If @f_EVP_des_ede=nil Then result := result + ' ' + fn_EVP_des_ede;
  If @f_EVP_des_ede3=nil Then result := result + ' ' + fn_EVP_des_ede3;
  If @f_EVP_des_cfb=nil Then result := result + ' ' + fn_EVP_des_cfb;
  If @f_EVP_des_ede_cfb=nil Then result := result + ' ' + fn_EVP_des_ede_cfb;
  If @f_EVP_des_ede3_cfb=nil Then result := result + ' ' + fn_EVP_des_ede3_cfb;
  If @f_EVP_des_ofb=nil Then result := result + ' ' + fn_EVP_des_ofb;
  If @f_EVP_des_ede_ofb=nil Then result := result + ' ' + fn_EVP_des_ede_ofb;
  If @f_EVP_des_ede3_ofb=nil Then result := result + ' ' + fn_EVP_des_ede3_ofb;
  If @f_EVP_des_cbc=nil Then result := result + ' ' + fn_EVP_des_cbc;
  If @f_EVP_des_ede_cbc=nil Then result := result + ' ' + fn_EVP_des_ede_cbc;
  If @f_EVP_des_ede3_cbc=nil Then result := result + ' ' + fn_EVP_des_ede3_cbc;
  If @f_EVP_desx_cbc=nil Then result := result + ' ' + fn_EVP_desx_cbc;
  If @f_EVP_rc4=nil Then result := result + ' ' + fn_EVP_rc4;
  If @f_EVP_rc4_40=nil Then result := result + ' ' + fn_EVP_rc4_40;
  If @f_EVP_idea_ecb=nil Then result := result + ' ' + fn_EVP_idea_ecb;
  If @f_EVP_idea_cfb=nil Then result := result + ' ' + fn_EVP_idea_cfb;
  If @f_EVP_idea_ofb=nil Then result := result + ' ' + fn_EVP_idea_ofb;
  If @f_EVP_idea_cbc=nil Then result := result + ' ' + fn_EVP_idea_cbc;
  If @f_EVP_rc2_ecb=nil Then result := result + ' ' + fn_EVP_rc2_ecb;
  If @f_EVP_rc2_cbc=nil Then result := result + ' ' + fn_EVP_rc2_cbc;
  If @f_EVP_rc2_40_cbc=nil Then result := result + ' ' + fn_EVP_rc2_40_cbc;
  If @f_EVP_rc2_64_cbc=nil Then result := result + ' ' + fn_EVP_rc2_64_cbc;
  If @f_EVP_rc2_cfb=nil Then result := result + ' ' + fn_EVP_rc2_cfb;
  If @f_EVP_rc2_ofb=nil Then result := result + ' ' + fn_EVP_rc2_ofb;
  If @f_EVP_bf_ecb=nil Then result := result + ' ' + fn_EVP_bf_ecb;
  If @f_EVP_bf_cbc=nil Then result := result + ' ' + fn_EVP_bf_cbc;
  If @f_EVP_bf_cfb=nil Then result := result + ' ' + fn_EVP_bf_cfb;
  If @f_EVP_bf_ofb=nil Then result := result + ' ' + fn_EVP_bf_ofb;
  If @f_EVP_cast5_ecb=nil Then result := result + ' ' + fn_EVP_cast5_ecb;
  If @f_EVP_cast5_cbc=nil Then result := result + ' ' + fn_EVP_cast5_cbc;
  If @f_EVP_cast5_cfb=nil Then result := result + ' ' + fn_EVP_cast5_cfb;
  If @f_EVP_cast5_ofb=nil Then result := result + ' ' + fn_EVP_cast5_ofb;
  If @f_EVP_rc5_32_12_16_cbc=nil Then result := result + ' ' + fn_EVP_rc5_32_12_16_cbc;
  If @f_EVP_rc5_32_12_16_ecb=nil Then result := result + ' ' + fn_EVP_rc5_32_12_16_ecb;
  If @f_EVP_rc5_32_12_16_cfb=nil Then result := result + ' ' + fn_EVP_rc5_32_12_16_cfb;
  If @f_EVP_rc5_32_12_16_ofb=nil Then result := result + ' ' + fn_EVP_rc5_32_12_16_ofb;
  If @f_SSLeay_add_all_algorithms=nil Then result := result + ' ' + fn_SSLeay_add_all_algorithms;
  If @f_SSLeay_add_all_ciphers=nil Then result := result + ' ' + fn_SSLeay_add_all_ciphers;
  If @f_SSLeay_add_all_digests=nil Then result := result + ' ' + fn_SSLeay_add_all_digests;
  If @f_EVP_add_cipher=nil Then result := result + ' ' + fn_EVP_add_cipher;
  If @f_EVP_add_digest=nil Then result := result + ' ' + fn_EVP_add_digest;
  If @f_EVP_get_cipherbyname=nil Then result := result + ' ' + fn_EVP_get_cipherbyname;
  If @f_EVP_get_digestbyname=nil Then result := result + ' ' + fn_EVP_get_digestbyname;
  If @f_EVP_cleanup=nil Then result := result + ' ' + fn_EVP_cleanup;
  If @f_EVP_PKEY_decrypt=nil Then result := result + ' ' + fn_EVP_PKEY_decrypt;
  If @f_EVP_PKEY_encrypt=nil Then result := result + ' ' + fn_EVP_PKEY_encrypt;
  If @f_EVP_PKEY_type=nil Then result := result + ' ' + fn_EVP_PKEY_type;
  If @f_EVP_PKEY_bits=nil Then result := result + ' ' + fn_EVP_PKEY_bits;
  If @f_EVP_PKEY_size=nil Then result := result + ' ' + fn_EVP_PKEY_size;
  If @f_EVP_PKEY_assign=nil Then result := result + ' ' + fn_EVP_PKEY_assign;
  If @f_EVP_PKEY_new=nil Then result := result + ' ' + fn_EVP_PKEY_new;
  If @f_EVP_PKEY_free=nil Then result := result + ' ' + fn_EVP_PKEY_free;
  If @f_d2i_PublicKey=nil Then result := result + ' ' + fn_d2i_PublicKey;
  If @f_i2d_PublicKey=nil Then result := result + ' ' + fn_i2d_PublicKey;
  If @f_d2i_PrivateKey=nil Then result := result + ' ' + fn_d2i_PrivateKey;
  If @f_i2d_PrivateKey=nil Then result := result + ' ' + fn_i2d_PrivateKey;
  If @f_EVP_PKEY_copy_parameters=nil Then result := result + ' ' + fn_EVP_PKEY_copy_parameters;
  If @f_EVP_PKEY_missing_parameters=nil Then result := result + ' ' + fn_EVP_PKEY_missing_parameters;
  If @f_EVP_PKEY_save_parameters=nil Then result := result + ' ' + fn_EVP_PKEY_save_parameters;
  If @f_EVP_PKEY_cmp_parameters=nil Then result := result + ' ' + fn_EVP_PKEY_cmp_parameters;
  If @f_EVP_CIPHER_type=nil Then result := result + ' ' + fn_EVP_CIPHER_type;
  If @f_EVP_CIPHER_param_to_asn1=nil Then result := result + ' ' + fn_EVP_CIPHER_param_to_asn1;
  If @f_EVP_CIPHER_asn1_to_param=nil Then result := result + ' ' + fn_EVP_CIPHER_asn1_to_param;
  If @f_EVP_CIPHER_set_asn1_iv=nil Then result := result + ' ' + fn_EVP_CIPHER_set_asn1_iv;
  If @f_EVP_CIPHER_get_asn1_iv=nil Then result := result + ' ' + fn_EVP_CIPHER_get_asn1_iv;
  If @f_PKCS5_PBE_keyivgen=nil Then result := result + ' ' + fn_PKCS5_PBE_keyivgen;
  If @f_PKCS5_PBKDF2_HMAC_SHA1=nil Then result := result + ' ' + fn_PKCS5_PBKDF2_HMAC_SHA1;
  If @f_PKCS5_v2_PBE_keyivgen=nil Then result := result + ' ' + fn_PKCS5_v2_PBE_keyivgen;
  If @f_PKCS5_PBE_add=nil Then result := result + ' ' + fn_PKCS5_PBE_add;
  If @f_EVP_PBE_CipherInit=nil Then result := result + ' ' + fn_EVP_PBE_CipherInit;
  If @f_EVP_PBE_alg_add=nil Then result := result + ' ' + fn_EVP_PBE_alg_add;
  If @f_EVP_PBE_cleanup=nil Then result := result + ' ' + fn_EVP_PBE_cleanup;
  If @f_sk_X509_ALGOR_new=nil Then result := result + ' ' + fn_sk_X509_ALGOR_new;
  If @f_sk_X509_ALGOR_new_null=nil Then result := result + ' ' + fn_sk_X509_ALGOR_new_null;
  If @f_sk_X509_ALGOR_free=nil Then result := result + ' ' + fn_sk_X509_ALGOR_free;
  If @f_sk_X509_ALGOR_num=nil Then result := result + ' ' + fn_sk_X509_ALGOR_num;
  If @f_sk_X509_ALGOR_value=nil Then result := result + ' ' + fn_sk_X509_ALGOR_value;
  If @f_sk_X509_ALGOR_set=nil Then result := result + ' ' + fn_sk_X509_ALGOR_set;
  If @f_sk_X509_ALGOR_zero=nil Then result := result + ' ' + fn_sk_X509_ALGOR_zero;
  If @f_sk_X509_ALGOR_push=nil Then result := result + ' ' + fn_sk_X509_ALGOR_push;
  If @f_sk_X509_ALGOR_unshift=nil Then result := result + ' ' + fn_sk_X509_ALGOR_unshift;
  If @f_sk_X509_ALGOR_find=nil Then result := result + ' ' + fn_sk_X509_ALGOR_find;
  If @f_sk_X509_ALGOR_delete=nil Then result := result + ' ' + fn_sk_X509_ALGOR_delete;
  If @f_sk_X509_ALGOR_delete_ptr=nil Then result := result + ' ' + fn_sk_X509_ALGOR_delete_ptr;
  If @f_sk_X509_ALGOR_insert=nil Then result := result + ' ' + fn_sk_X509_ALGOR_insert;
  If @f_sk_X509_ALGOR_dup=nil Then result := result + ' ' + fn_sk_X509_ALGOR_dup;
  If @f_sk_X509_ALGOR_pop_free=nil Then result := result + ' ' + fn_sk_X509_ALGOR_pop_free;
  If @f_sk_X509_ALGOR_shift=nil Then result := result + ' ' + fn_sk_X509_ALGOR_shift;
  If @f_sk_X509_ALGOR_pop=nil Then result := result + ' ' + fn_sk_X509_ALGOR_pop;
  If @f_sk_X509_ALGOR_sort=nil Then result := result + ' ' + fn_sk_X509_ALGOR_sort;
  If @f_i2d_ASN1_SET_OF_X509_ALGOR=nil Then result := result + ' ' + fn_i2d_ASN1_SET_OF_X509_ALGOR;
  If @f_d2i_ASN1_SET_OF_X509_ALGOR=nil Then result := result + ' ' + fn_d2i_ASN1_SET_OF_X509_ALGOR;
  If @f_sk_X509_NAME_ENTRY_new=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_new;
  If @f_sk_X509_NAME_ENTRY_new_null=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_new_null;
  If @f_sk_X509_NAME_ENTRY_free=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_free;
  If @f_sk_X509_NAME_ENTRY_num=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_num;
  If @f_sk_X509_NAME_ENTRY_value=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_value;
  If @f_sk_X509_NAME_ENTRY_set=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_set;
  If @f_sk_X509_NAME_ENTRY_zero=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_zero;
  If @f_sk_X509_NAME_ENTRY_push=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_push;
  If @f_sk_X509_NAME_ENTRY_unshift=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_unshift;
  If @f_sk_X509_NAME_ENTRY_find=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_find;
  If @f_sk_X509_NAME_ENTRY_delete=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_delete;
  If @f_sk_X509_NAME_ENTRY_delete_ptr=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_delete_ptr;
  If @f_sk_X509_NAME_ENTRY_insert=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_insert;
  If @f_sk_X509_NAME_ENTRY_dup=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_dup;
  If @f_sk_X509_NAME_ENTRY_pop_free=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_pop_free;
  If @f_sk_X509_NAME_ENTRY_shift=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_shift;
  If @f_sk_X509_NAME_ENTRY_pop=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_pop;
  If @f_sk_X509_NAME_ENTRY_sort=nil Then result := result + ' ' + fn_sk_X509_NAME_ENTRY_sort;
  If @f_i2d_ASN1_SET_OF_X509_NAME_ENTRY=nil Then result := result + ' ' + fn_i2d_ASN1_SET_OF_X509_NAME_ENTRY;
  If @f_d2i_ASN1_SET_OF_X509_NAME_ENTRY=nil Then result := result + ' ' + fn_d2i_ASN1_SET_OF_X509_NAME_ENTRY;
  If @f_sk_X509_NAME_new=nil Then result := result + ' ' + fn_sk_X509_NAME_new;
  If @f_sk_X509_NAME_new_null=nil Then result := result + ' ' + fn_sk_X509_NAME_new_null;
  If @f_sk_X509_NAME_free=nil Then result := result + ' ' + fn_sk_X509_NAME_free;
  If @f_sk_X509_NAME_num=nil Then result := result + ' ' + fn_sk_X509_NAME_num;
  If @f_sk_X509_NAME_value=nil Then result := result + ' ' + fn_sk_X509_NAME_value;
  If @f_sk_X509_NAME_set=nil Then result := result + ' ' + fn_sk_X509_NAME_set;
  If @f_sk_X509_NAME_zero=nil Then result := result + ' ' + fn_sk_X509_NAME_zero;
  If @f_sk_X509_NAME_push=nil Then result := result + ' ' + fn_sk_X509_NAME_push;
  If @f_sk_X509_NAME_unshift=nil Then result := result + ' ' + fn_sk_X509_NAME_unshift;
  If @f_sk_X509_NAME_find=nil Then result := result + ' ' + fn_sk_X509_NAME_find;
  If @f_sk_X509_NAME_delete=nil Then result := result + ' ' + fn_sk_X509_NAME_delete;
  If @f_sk_X509_NAME_delete_ptr=nil Then result := result + ' ' + fn_sk_X509_NAME_delete_ptr;
  If @f_sk_X509_NAME_insert=nil Then result := result + ' ' + fn_sk_X509_NAME_insert;
  If @f_sk_X509_NAME_dup=nil Then result := result + ' ' + fn_sk_X509_NAME_dup;
  If @f_sk_X509_NAME_pop_free=nil Then result := result + ' ' + fn_sk_X509_NAME_pop_free;
  If @f_sk_X509_NAME_shift=nil Then result := result + ' ' + fn_sk_X509_NAME_shift;
  If @f_sk_X509_NAME_pop=nil Then result := result + ' ' + fn_sk_X509_NAME_pop;
  If @f_sk_X509_NAME_sort=nil Then result := result + ' ' + fn_sk_X509_NAME_sort;
  If @f_sk_X509_EXTENSION_new=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_new;
  If @f_sk_X509_EXTENSION_new_null=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_new_null;
  If @f_sk_X509_EXTENSION_free=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_free;
  If @f_sk_X509_EXTENSION_num=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_num;
  If @f_sk_X509_EXTENSION_value=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_value;
  If @f_sk_X509_EXTENSION_set=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_set;
  If @f_sk_X509_EXTENSION_zero=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_zero;
  If @f_sk_X509_EXTENSION_push=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_push;
  If @f_sk_X509_EXTENSION_unshift=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_unshift;
  If @f_sk_X509_EXTENSION_find=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_find;
  If @f_sk_X509_EXTENSION_delete=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_delete;
  If @f_sk_X509_EXTENSION_delete_ptr=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_delete_ptr;
  If @f_sk_X509_EXTENSION_insert=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_insert;
  If @f_sk_X509_EXTENSION_dup=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_dup;
  If @f_sk_X509_EXTENSION_pop_free=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_pop_free;
  If @f_sk_X509_EXTENSION_shift=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_shift;
  If @f_sk_X509_EXTENSION_pop=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_pop;
  If @f_sk_X509_EXTENSION_sort=nil Then result := result + ' ' + fn_sk_X509_EXTENSION_sort;
  If @f_i2d_ASN1_SET_OF_X509_EXTENSION=nil Then result := result + ' ' + fn_i2d_ASN1_SET_OF_X509_EXTENSION;
  If @f_d2i_ASN1_SET_OF_X509_EXTENSION=nil Then result := result + ' ' + fn_d2i_ASN1_SET_OF_X509_EXTENSION;
  If @f_sk_X509_ATTRIBUTE_new=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_new;
  If @f_sk_X509_ATTRIBUTE_new_null=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_new_null;
  If @f_sk_X509_ATTRIBUTE_free=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_free;
  If @f_sk_X509_ATTRIBUTE_num=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_num;
  If @f_sk_X509_ATTRIBUTE_value=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_value;
  If @f_sk_X509_ATTRIBUTE_set=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_set;
  If @f_sk_X509_ATTRIBUTE_zero=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_zero;
  If @f_sk_X509_ATTRIBUTE_push=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_push;
  If @f_sk_X509_ATTRIBUTE_unshift=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_unshift;
  If @f_sk_X509_ATTRIBUTE_find=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_find;
  If @f_sk_X509_ATTRIBUTE_delete=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_delete;
  If @f_sk_X509_ATTRIBUTE_delete_ptr=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_delete_ptr;
  If @f_sk_X509_ATTRIBUTE_insert=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_insert;
  If @f_sk_X509_ATTRIBUTE_dup=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_dup;
  If @f_sk_X509_ATTRIBUTE_pop_free=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_pop_free;
  If @f_sk_X509_ATTRIBUTE_shift=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_shift;
  If @f_sk_X509_ATTRIBUTE_pop=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_pop;
  If @f_sk_X509_ATTRIBUTE_sort=nil Then result := result + ' ' + fn_sk_X509_ATTRIBUTE_sort;
  If @f_i2d_ASN1_SET_OF_X509_ATTRIBUTE=nil Then result := result + ' ' + fn_i2d_ASN1_SET_OF_X509_ATTRIBUTE;
  If @f_d2i_ASN1_SET_OF_X509_ATTRIBUTE=nil Then result := result + ' ' + fn_d2i_ASN1_SET_OF_X509_ATTRIBUTE;
  If @f_sk_X509_new=nil Then result := result + ' ' + fn_sk_X509_new;
  If @f_sk_X509_new_null=nil Then result := result + ' ' + fn_sk_X509_new_null;
  If @f_sk_X509_free=nil Then result := result + ' ' + fn_sk_X509_free;
  If @f_sk_X509_num=nil Then result := result + ' ' + fn_sk_X509_num;
  If @f_sk_X509_value=nil Then result := result + ' ' + fn_sk_X509_value;
  If @f_sk_X509_set=nil Then result := result + ' ' + fn_sk_X509_set;
  If @f_sk_X509_zero=nil Then result := result + ' ' + fn_sk_X509_zero;
  If @f_sk_X509_push=nil Then result := result + ' ' + fn_sk_X509_push;
  If @f_sk_X509_unshift=nil Then result := result + ' ' + fn_sk_X509_unshift;
  If @f_sk_X509_find=nil Then result := result + ' ' + fn_sk_X509_find;
  If @f_sk_X509_delete=nil Then result := result + ' ' + fn_sk_X509_delete;
  If @f_sk_X509_delete_ptr=nil Then result := result + ' ' + fn_sk_X509_delete_ptr;
  If @f_sk_X509_insert=nil Then result := result + ' ' + fn_sk_X509_insert;
  If @f_sk_X509_dup=nil Then result := result + ' ' + fn_sk_X509_dup;
  If @f_sk_X509_pop_free=nil Then result := result + ' ' + fn_sk_X509_pop_free;
  If @f_sk_X509_shift=nil Then result := result + ' ' + fn_sk_X509_shift;
  If @f_sk_X509_pop=nil Then result := result + ' ' + fn_sk_X509_pop;
  If @f_sk_X509_sort=nil Then result := result + ' ' + fn_sk_X509_sort;
  If @f_i2d_ASN1_SET_OF_X509=nil Then result := result + ' ' + fn_i2d_ASN1_SET_OF_X509;
  If @f_d2i_ASN1_SET_OF_X509=nil Then result := result + ' ' + fn_d2i_ASN1_SET_OF_X509;
  If @f_sk_X509_REVOKED_new=nil Then result := result + ' ' + fn_sk_X509_REVOKED_new;
  If @f_sk_X509_REVOKED_new_null=nil Then result := result + ' ' + fn_sk_X509_REVOKED_new_null;
  If @f_sk_X509_REVOKED_free=nil Then result := result + ' ' + fn_sk_X509_REVOKED_free;
  If @f_sk_X509_REVOKED_num=nil Then result := result + ' ' + fn_sk_X509_REVOKED_num;
  If @f_sk_X509_REVOKED_value=nil Then result := result + ' ' + fn_sk_X509_REVOKED_value;
  If @f_sk_X509_REVOKED_set=nil Then result := result + ' ' + fn_sk_X509_REVOKED_set;
  If @f_sk_X509_REVOKED_zero=nil Then result := result + ' ' + fn_sk_X509_REVOKED_zero;
  If @f_sk_X509_REVOKED_push=nil Then result := result + ' ' + fn_sk_X509_REVOKED_push;
  If @f_sk_X509_REVOKED_unshift=nil Then result := result + ' ' + fn_sk_X509_REVOKED_unshift;
  If @f_sk_X509_REVOKED_find=nil Then result := result + ' ' + fn_sk_X509_REVOKED_find;
  If @f_sk_X509_REVOKED_delete=nil Then result := result + ' ' + fn_sk_X509_REVOKED_delete;
  If @f_sk_X509_REVOKED_delete_ptr=nil Then result := result + ' ' + fn_sk_X509_REVOKED_delete_ptr;
  If @f_sk_X509_REVOKED_insert=nil Then result := result + ' ' + fn_sk_X509_REVOKED_insert;
  If @f_sk_X509_REVOKED_dup=nil Then result := result + ' ' + fn_sk_X509_REVOKED_dup;
  If @f_sk_X509_REVOKED_pop_free=nil Then result := result + ' ' + fn_sk_X509_REVOKED_pop_free;
  If @f_sk_X509_REVOKED_shift=nil Then result := result + ' ' + fn_sk_X509_REVOKED_shift;
  If @f_sk_X509_REVOKED_pop=nil Then result := result + ' ' + fn_sk_X509_REVOKED_pop;
  If @f_sk_X509_REVOKED_sort=nil Then result := result + ' ' + fn_sk_X509_REVOKED_sort;
  If @f_i2d_ASN1_SET_OF_X509_REVOKED=nil Then result := result + ' ' + fn_i2d_ASN1_SET_OF_X509_REVOKED;
  If @f_d2i_ASN1_SET_OF_X509_REVOKED=nil Then result := result + ' ' + fn_d2i_ASN1_SET_OF_X509_REVOKED;
  If @f_sk_X509_CRL_new=nil Then result := result + ' ' + fn_sk_X509_CRL_new;
  If @f_sk_X509_CRL_new_null=nil Then result := result + ' ' + fn_sk_X509_CRL_new_null;
  If @f_sk_X509_CRL_free=nil Then result := result + ' ' + fn_sk_X509_CRL_free;
  If @f_sk_X509_CRL_num=nil Then result := result + ' ' + fn_sk_X509_CRL_num;
  If @f_sk_X509_CRL_value=nil Then result := result + ' ' + fn_sk_X509_CRL_value;
  If @f_sk_X509_CRL_set=nil Then result := result + ' ' + fn_sk_X509_CRL_set;
  If @f_sk_X509_CRL_zero=nil Then result := result + ' ' + fn_sk_X509_CRL_zero;
  If @f_sk_X509_CRL_push=nil Then result := result + ' ' + fn_sk_X509_CRL_push;
  If @f_sk_X509_CRL_unshift=nil Then result := result + ' ' + fn_sk_X509_CRL_unshift;
  If @f_sk_X509_CRL_find=nil Then result := result + ' ' + fn_sk_X509_CRL_find;
  If @f_sk_X509_CRL_delete=nil Then result := result + ' ' + fn_sk_X509_CRL_delete;
  If @f_sk_X509_CRL_delete_ptr=nil Then result := result + ' ' + fn_sk_X509_CRL_delete_ptr;
  If @f_sk_X509_CRL_insert=nil Then result := result + ' ' + fn_sk_X509_CRL_insert;
  If @f_sk_X509_CRL_dup=nil Then result := result + ' ' + fn_sk_X509_CRL_dup;
  If @f_sk_X509_CRL_pop_free=nil Then result := result + ' ' + fn_sk_X509_CRL_pop_free;
  If @f_sk_X509_CRL_shift=nil Then result := result + ' ' + fn_sk_X509_CRL_shift;
  If @f_sk_X509_CRL_pop=nil Then result := result + ' ' + fn_sk_X509_CRL_pop;
  If @f_sk_X509_CRL_sort=nil Then result := result + ' ' + fn_sk_X509_CRL_sort;
  If @f_i2d_ASN1_SET_OF_X509_CRL=nil Then result := result + ' ' + fn_i2d_ASN1_SET_OF_X509_CRL;
  If @f_d2i_ASN1_SET_OF_X509_CRL=nil Then result := result + ' ' + fn_d2i_ASN1_SET_OF_X509_CRL;
  If @f_sk_X509_INFO_new=nil Then result := result + ' ' + fn_sk_X509_INFO_new;
  If @f_sk_X509_INFO_new_null=nil Then result := result + ' ' + fn_sk_X509_INFO_new_null;
  If @f_sk_X509_INFO_free=nil Then result := result + ' ' + fn_sk_X509_INFO_free;
  If @f_sk_X509_INFO_num=nil Then result := result + ' ' + fn_sk_X509_INFO_num;
  If @f_sk_X509_INFO_value=nil Then result := result + ' ' + fn_sk_X509_INFO_value;
  If @f_sk_X509_INFO_set=nil Then result := result + ' ' + fn_sk_X509_INFO_set;
  If @f_sk_X509_INFO_zero=nil Then result := result + ' ' + fn_sk_X509_INFO_zero;
  If @f_sk_X509_INFO_push=nil Then result := result + ' ' + fn_sk_X509_INFO_push;
  If @f_sk_X509_INFO_unshift=nil Then result := result + ' ' + fn_sk_X509_INFO_unshift;
  If @f_sk_X509_INFO_find=nil Then result := result + ' ' + fn_sk_X509_INFO_find;
  If @f_sk_X509_INFO_delete=nil Then result := result + ' ' + fn_sk_X509_INFO_delete;
  If @f_sk_X509_INFO_delete_ptr=nil Then result := result + ' ' + fn_sk_X509_INFO_delete_ptr;
  If @f_sk_X509_INFO_insert=nil Then result := result + ' ' + fn_sk_X509_INFO_insert;
  If @f_sk_X509_INFO_dup=nil Then result := result + ' ' + fn_sk_X509_INFO_dup;
  If @f_sk_X509_INFO_pop_free=nil Then result := result + ' ' + fn_sk_X509_INFO_pop_free;
  If @f_sk_X509_INFO_shift=nil Then result := result + ' ' + fn_sk_X509_INFO_shift;
  If @f_sk_X509_INFO_pop=nil Then result := result + ' ' + fn_sk_X509_INFO_pop;
  If @f_sk_X509_INFO_sort=nil Then result := result + ' ' + fn_sk_X509_INFO_sort;
  If @f_sk_X509_LOOKUP_new=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_new;
  If @f_sk_X509_LOOKUP_new_null=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_new_null;
  If @f_sk_X509_LOOKUP_free=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_free;
  If @f_sk_X509_LOOKUP_num=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_num;
  If @f_sk_X509_LOOKUP_value=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_value;
  If @f_sk_X509_LOOKUP_set=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_set;
  If @f_sk_X509_LOOKUP_zero=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_zero;
  If @f_sk_X509_LOOKUP_push=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_push;
  If @f_sk_X509_LOOKUP_unshift=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_unshift;
  If @f_sk_X509_LOOKUP_find=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_find;
  If @f_sk_X509_LOOKUP_delete=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_delete;
  If @f_sk_X509_LOOKUP_delete_ptr=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_delete_ptr;
  If @f_sk_X509_LOOKUP_insert=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_insert;
  If @f_sk_X509_LOOKUP_dup=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_dup;
  If @f_sk_X509_LOOKUP_pop_free=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_pop_free;
  If @f_sk_X509_LOOKUP_shift=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_shift;
  If @f_sk_X509_LOOKUP_pop=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_pop;
  If @f_sk_X509_LOOKUP_sort=nil Then result := result + ' ' + fn_sk_X509_LOOKUP_sort;
  If @f_X509_OBJECT_retrieve_by_subject=nil Then result := result + ' ' + fn_X509_OBJECT_retrieve_by_subject;
  If @f_X509_OBJECT_up_ref_count=nil Then result := result + ' ' + fn_X509_OBJECT_up_ref_count;
  If @f_X509_OBJECT_free_contents=nil Then result := result + ' ' + fn_X509_OBJECT_free_contents;
  If @f_X509_STORE_new=nil Then result := result + ' ' + fn_X509_STORE_new;
  If @f_X509_STORE_free=nil Then result := result + ' ' + fn_X509_STORE_free;
  If @f_X509_STORE_CTX_init=nil Then result := result + ' ' + fn_X509_STORE_CTX_init;
  If @f_X509_STORE_CTX_cleanup=nil Then result := result + ' ' + fn_X509_STORE_CTX_cleanup;
  If @f_X509_STORE_add_lookup=nil Then result := result + ' ' + fn_X509_STORE_add_lookup;
  If @f_X509_LOOKUP_hash_dir=nil Then result := result + ' ' + fn_X509_LOOKUP_hash_dir;
  If @f_X509_LOOKUP_file=nil Then result := result + ' ' + fn_X509_LOOKUP_file;
  If @f_X509_STORE_add_cert=nil Then result := result + ' ' + fn_X509_STORE_add_cert;
  If @f_X509_STORE_add_crl=nil Then result := result + ' ' + fn_X509_STORE_add_crl;
  If @f_X509_STORE_get_by_subject=nil Then result := result + ' ' + fn_X509_STORE_get_by_subject;
  If @f_X509_LOOKUP_ctrl=nil Then result := result + ' ' + fn_X509_LOOKUP_ctrl;
  If @f_X509_load_cert_file=nil Then result := result + ' ' + fn_X509_load_cert_file;
  If @f_X509_load_crl_file=nil Then result := result + ' ' + fn_X509_load_crl_file;
  If @f_X509_LOOKUP_new=nil Then result := result + ' ' + fn_X509_LOOKUP_new;
  If @f_X509_LOOKUP_free=nil Then result := result + ' ' + fn_X509_LOOKUP_free;
  If @f_X509_LOOKUP_init=nil Then result := result + ' ' + fn_X509_LOOKUP_init;
  If @f_X509_LOOKUP_by_subject=nil Then result := result + ' ' + fn_X509_LOOKUP_by_subject;
  If @f_X509_LOOKUP_by_issuer_serial=nil Then result := result + ' ' + fn_X509_LOOKUP_by_issuer_serial;
  If @f_X509_LOOKUP_by_fingerprint=nil Then result := result + ' ' + fn_X509_LOOKUP_by_fingerprint;
  If @f_X509_LOOKUP_by_alias=nil Then result := result + ' ' + fn_X509_LOOKUP_by_alias;
  If @f_X509_LOOKUP_shutdown=nil Then result := result + ' ' + fn_X509_LOOKUP_shutdown;
  If @f_X509_STORE_load_locations=nil Then result := result + ' ' + fn_X509_STORE_load_locations;
  If @f_X509_STORE_set_default_paths=nil Then result := result + ' ' + fn_X509_STORE_set_default_paths;
  If @f_X509_STORE_CTX_get_ex_new_index=nil Then result := result + ' ' + fn_X509_STORE_CTX_get_ex_new_index;
  If @f_X509_STORE_CTX_set_ex_data=nil Then result := result + ' ' + fn_X509_STORE_CTX_set_ex_data;
  If @f_X509_STORE_CTX_get_ex_data=nil Then result := result + ' ' + fn_X509_STORE_CTX_get_ex_data;
  If @f_X509_STORE_CTX_get_error=nil Then result := result + ' ' + fn_X509_STORE_CTX_get_error;
  If @f_X509_STORE_CTX_set_error=nil Then result := result + ' ' + fn_X509_STORE_CTX_set_error;
  If @f_X509_STORE_CTX_get_error_depth=nil Then result := result + ' ' + fn_X509_STORE_CTX_get_error_depth;
  If @f_X509_STORE_CTX_get_current_cert=nil Then result := result + ' ' + fn_X509_STORE_CTX_get_current_cert;
  If @f_X509_STORE_CTX_get_chain=nil Then result := result + ' ' + fn_X509_STORE_CTX_get_chain;
  If @f_X509_STORE_CTX_set_cert=nil Then result := result + ' ' + fn_X509_STORE_CTX_set_cert;
  If @f_X509_STORE_CTX_set_chain=nil Then result := result + ' ' + fn_X509_STORE_CTX_set_chain;
  If @f_sk_PKCS7_SIGNER_INFO_new=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_new;
  If @f_sk_PKCS7_SIGNER_INFO_new_null=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_new_null;
  If @f_sk_PKCS7_SIGNER_INFO_free=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_free;
  If @f_sk_PKCS7_SIGNER_INFO_num=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_num;
  If @f_sk_PKCS7_SIGNER_INFO_value=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_value;
  If @f_sk_PKCS7_SIGNER_INFO_set=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_set;
  If @f_sk_PKCS7_SIGNER_INFO_zero=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_zero;
  If @f_sk_PKCS7_SIGNER_INFO_push=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_push;
  If @f_sk_PKCS7_SIGNER_INFO_unshift=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_unshift;
  If @f_sk_PKCS7_SIGNER_INFO_find=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_find;
  If @f_sk_PKCS7_SIGNER_INFO_delete=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_delete;
  If @f_sk_PKCS7_SIGNER_INFO_delete_ptr=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_delete_ptr;
  If @f_sk_PKCS7_SIGNER_INFO_insert=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_insert;
  If @f_sk_PKCS7_SIGNER_INFO_dup=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_dup;
  If @f_sk_PKCS7_SIGNER_INFO_pop_free=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_pop_free;
  If @f_sk_PKCS7_SIGNER_INFO_shift=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_shift;
  If @f_sk_PKCS7_SIGNER_INFO_pop=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_pop;
  If @f_sk_PKCS7_SIGNER_INFO_sort=nil Then result := result + ' ' + fn_sk_PKCS7_SIGNER_INFO_sort;
  If @f_i2d_ASN1_SET_OF_PKCS7_SIGNER_INFO=nil Then result := result + ' ' + fn_i2d_ASN1_SET_OF_PKCS7_SIGNER_INFO;
  If @f_d2i_ASN1_SET_OF_PKCS7_SIGNER_INFO=nil Then result := result + ' ' + fn_d2i_ASN1_SET_OF_PKCS7_SIGNER_INFO;
  If @f_sk_PKCS7_RECIP_INFO_new=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_new;
  If @f_sk_PKCS7_RECIP_INFO_new_null=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_new_null;
  If @f_sk_PKCS7_RECIP_INFO_free=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_free;
  If @f_sk_PKCS7_RECIP_INFO_num=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_num;
  If @f_sk_PKCS7_RECIP_INFO_value=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_value;
  If @f_sk_PKCS7_RECIP_INFO_set=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_set;
  If @f_sk_PKCS7_RECIP_INFO_zero=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_zero;
  If @f_sk_PKCS7_RECIP_INFO_push=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_push;
  If @f_sk_PKCS7_RECIP_INFO_unshift=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_unshift;
  If @f_sk_PKCS7_RECIP_INFO_find=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_find;
  If @f_sk_PKCS7_RECIP_INFO_delete=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_delete;
  If @f_sk_PKCS7_RECIP_INFO_delete_ptr=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_delete_ptr;
  If @f_sk_PKCS7_RECIP_INFO_insert=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_insert;
  If @f_sk_PKCS7_RECIP_INFO_dup=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_dup;
  If @f_sk_PKCS7_RECIP_INFO_pop_free=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_pop_free;
  If @f_sk_PKCS7_RECIP_INFO_shift=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_shift;
  If @f_sk_PKCS7_RECIP_INFO_pop=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_pop;
  If @f_sk_PKCS7_RECIP_INFO_sort=nil Then result := result + ' ' + fn_sk_PKCS7_RECIP_INFO_sort;
  If @f_i2d_ASN1_SET_OF_PKCS7_RECIP_INFO=nil Then result := result + ' ' + fn_i2d_ASN1_SET_OF_PKCS7_RECIP_INFO;
  If @f_d2i_ASN1_SET_OF_PKCS7_RECIP_INFO=nil Then result := result + ' ' + fn_d2i_ASN1_SET_OF_PKCS7_RECIP_INFO;
  If @f_PKCS7_ISSUER_AND_SERIAL_new=nil Then result := result + ' ' + fn_PKCS7_ISSUER_AND_SERIAL_new;
  If @f_PKCS7_ISSUER_AND_SERIAL_free=nil Then result := result + ' ' + fn_PKCS7_ISSUER_AND_SERIAL_free;
  If @f_i2d_PKCS7_ISSUER_AND_SERIAL=nil Then result := result + ' ' + fn_i2d_PKCS7_ISSUER_AND_SERIAL;
  If @f_d2i_PKCS7_ISSUER_AND_SERIAL=nil Then result := result + ' ' + fn_d2i_PKCS7_ISSUER_AND_SERIAL;
  If @f_PKCS7_ISSUER_AND_SERIAL_digest=nil Then result := result + ' ' + fn_PKCS7_ISSUER_AND_SERIAL_digest;
  If @f_d2i_PKCS7_fp=nil Then result := result + ' ' + fn_d2i_PKCS7_fp;
  If @f_i2d_PKCS7_fp=nil Then result := result + ' ' + fn_i2d_PKCS7_fp;
  If @f_PKCS7_dup=nil Then result := result + ' ' + fn_PKCS7_dup;
  If @f_d2i_PKCS7_bio=nil Then result := result + ' ' + fn_d2i_PKCS7_bio;
  If @f_i2d_PKCS7_bio=nil Then result := result + ' ' + fn_i2d_PKCS7_bio;
  If @f_PKCS7_SIGNER_INFO_new=nil Then result := result + ' ' + fn_PKCS7_SIGNER_INFO_new;
  If @f_PKCS7_SIGNER_INFO_free=nil Then result := result + ' ' + fn_PKCS7_SIGNER_INFO_free;
  If @f_i2d_PKCS7_SIGNER_INFO=nil Then result := result + ' ' + fn_i2d_PKCS7_SIGNER_INFO;
  If @f_d2i_PKCS7_SIGNER_INFO=nil Then result := result + ' ' + fn_d2i_PKCS7_SIGNER_INFO;
  If @f_PKCS7_RECIP_INFO_new=nil Then result := result + ' ' + fn_PKCS7_RECIP_INFO_new;
  If @f_PKCS7_RECIP_INFO_free=nil Then result := result + ' ' + fn_PKCS7_RECIP_INFO_free;
  If @f_i2d_PKCS7_RECIP_INFO=nil Then result := result + ' ' + fn_i2d_PKCS7_RECIP_INFO;
  If @f_d2i_PKCS7_RECIP_INFO=nil Then result := result + ' ' + fn_d2i_PKCS7_RECIP_INFO;
  If @f_PKCS7_SIGNED_new=nil Then result := result + ' ' + fn_PKCS7_SIGNED_new;
  If @f_PKCS7_SIGNED_free=nil Then result := result + ' ' + fn_PKCS7_SIGNED_free;
  If @f_i2d_PKCS7_SIGNED=nil Then result := result + ' ' + fn_i2d_PKCS7_SIGNED;
  If @f_d2i_PKCS7_SIGNED=nil Then result := result + ' ' + fn_d2i_PKCS7_SIGNED;
  If @f_PKCS7_ENC_CONTENT_new=nil Then result := result + ' ' + fn_PKCS7_ENC_CONTENT_new;
  If @f_PKCS7_ENC_CONTENT_free=nil Then result := result + ' ' + fn_PKCS7_ENC_CONTENT_free;
  If @f_i2d_PKCS7_ENC_CONTENT=nil Then result := result + ' ' + fn_i2d_PKCS7_ENC_CONTENT;
  If @f_d2i_PKCS7_ENC_CONTENT=nil Then result := result + ' ' + fn_d2i_PKCS7_ENC_CONTENT;
  If @f_PKCS7_ENVELOPE_new=nil Then result := result + ' ' + fn_PKCS7_ENVELOPE_new;
  If @f_PKCS7_ENVELOPE_free=nil Then result := result + ' ' + fn_PKCS7_ENVELOPE_free;
  If @f_i2d_PKCS7_ENVELOPE=nil Then result := result + ' ' + fn_i2d_PKCS7_ENVELOPE;
  If @f_d2i_PKCS7_ENVELOPE=nil Then result := result + ' ' + fn_d2i_PKCS7_ENVELOPE;
  If @f_PKCS7_SIGN_ENVELOPE_new=nil Then result := result + ' ' + fn_PKCS7_SIGN_ENVELOPE_new;
  If @f_PKCS7_SIGN_ENVELOPE_free=nil Then result := result + ' ' + fn_PKCS7_SIGN_ENVELOPE_free;
  If @f_i2d_PKCS7_SIGN_ENVELOPE=nil Then result := result + ' ' + fn_i2d_PKCS7_SIGN_ENVELOPE;
  If @f_d2i_PKCS7_SIGN_ENVELOPE=nil Then result := result + ' ' + fn_d2i_PKCS7_SIGN_ENVELOPE;
  If @f_PKCS7_DIGEST_new=nil Then result := result + ' ' + fn_PKCS7_DIGEST_new;
  If @f_PKCS7_DIGEST_free=nil Then result := result + ' ' + fn_PKCS7_DIGEST_free;
  If @f_i2d_PKCS7_DIGEST=nil Then result := result + ' ' + fn_i2d_PKCS7_DIGEST;
  If @f_d2i_PKCS7_DIGEST=nil Then result := result + ' ' + fn_d2i_PKCS7_DIGEST;
  If @f_PKCS7_ENCRYPT_new=nil Then result := result + ' ' + fn_PKCS7_ENCRYPT_new;
  If @f_PKCS7_ENCRYPT_free=nil Then result := result + ' ' + fn_PKCS7_ENCRYPT_free;
  If @f_i2d_PKCS7_ENCRYPT=nil Then result := result + ' ' + fn_i2d_PKCS7_ENCRYPT;
  If @f_d2i_PKCS7_ENCRYPT=nil Then result := result + ' ' + fn_d2i_PKCS7_ENCRYPT;
  If @f_PKCS7_new=nil Then result := result + ' ' + fn_PKCS7_new;
  If @f_PKCS7_free=nil Then result := result + ' ' + fn_PKCS7_free;
  If @f_PKCS7_content_free=nil Then result := result + ' ' + fn_PKCS7_content_free;
  If @f_i2d_PKCS7=nil Then result := result + ' ' + fn_i2d_PKCS7;
  If @f_d2i_PKCS7=nil Then result := result + ' ' + fn_d2i_PKCS7;
  If @f_ERR_load_PKCS7_strings=nil Then result := result + ' ' + fn_ERR_load_PKCS7_strings;
  If @f_PKCS7_ctrl=nil Then result := result + ' ' + fn_PKCS7_ctrl;
  If @f_PKCS7_set_type=nil Then result := result + ' ' + fn_PKCS7_set_type;
  If @f_PKCS7_set_content=nil Then result := result + ' ' + fn_PKCS7_set_content;
  If @f_PKCS7_SIGNER_INFO_set=nil Then result := result + ' ' + fn_PKCS7_SIGNER_INFO_set;
  If @f_PKCS7_add_signer=nil Then result := result + ' ' + fn_PKCS7_add_signer;
  If @f_PKCS7_add_certificate=nil Then result := result + ' ' + fn_PKCS7_add_certificate;
  If @f_PKCS7_add_crl=nil Then result := result + ' ' + fn_PKCS7_add_crl;
  If @f_PKCS7_content_new=nil Then result := result + ' ' + fn_PKCS7_content_new;
  If @f_PKCS7_dataVerify=nil Then result := result + ' ' + fn_PKCS7_dataVerify;
  If @f_PKCS7_signatureVerify=nil Then result := result + ' ' + fn_PKCS7_signatureVerify;
  If @f_PKCS7_dataInit=nil Then result := result + ' ' + fn_PKCS7_dataInit;
  If @f_PKCS7_dataFinal=nil Then result := result + ' ' + fn_PKCS7_dataFinal;
  If @f_PKCS7_dataDecode=nil Then result := result + ' ' + fn_PKCS7_dataDecode;
  If @f_PKCS7_add_signature=nil Then result := result + ' ' + fn_PKCS7_add_signature;
  If @f_PKCS7_cert_from_signer_info=nil Then result := result + ' ' + fn_PKCS7_cert_from_signer_info;
  If @f_PKCS7_get_signer_info=nil Then result := result + ' ' + fn_PKCS7_get_signer_info;
  If @f_PKCS7_add_recipient=nil Then result := result + ' ' + fn_PKCS7_add_recipient;
  If @f_PKCS7_add_recipient_info=nil Then result := result + ' ' + fn_PKCS7_add_recipient_info;
  If @f_PKCS7_RECIP_INFO_set=nil Then result := result + ' ' + fn_PKCS7_RECIP_INFO_set;
  If @f_PKCS7_set_cipher=nil Then result := result + ' ' + fn_PKCS7_set_cipher;
  If @f_PKCS7_get_issuer_and_serial=nil Then result := result + ' ' + fn_PKCS7_get_issuer_and_serial;
  If @f_PKCS7_digest_from_attributes=nil Then result := result + ' ' + fn_PKCS7_digest_from_attributes;
  If @f_PKCS7_add_signed_attribute=nil Then result := result + ' ' + fn_PKCS7_add_signed_attribute;
  If @f_PKCS7_add_attribute=nil Then result := result + ' ' + fn_PKCS7_add_attribute;
  If @f_PKCS7_get_attribute=nil Then result := result + ' ' + fn_PKCS7_get_attribute;
  If @f_PKCS7_get_signed_attribute=nil Then result := result + ' ' + fn_PKCS7_get_signed_attribute;
  If @f_PKCS7_set_signed_attributes=nil Then result := result + ' ' + fn_PKCS7_set_signed_attributes;
  If @f_PKCS7_set_attributes=nil Then result := result + ' ' + fn_PKCS7_set_attributes;
  If @f_X509_verify_cert_error_string=nil Then result := result + ' ' + fn_X509_verify_cert_error_string;
  If @f_X509_verify=nil Then result := result + ' ' + fn_X509_verify;
  If @f_X509_REQ_verify=nil Then result := result + ' ' + fn_X509_REQ_verify;
  If @f_X509_CRL_verify=nil Then result := result + ' ' + fn_X509_CRL_verify;
  If @f_NETSCAPE_SPKI_verify=nil Then result := result + ' ' + fn_NETSCAPE_SPKI_verify;
  If @f_X509_sign=nil Then result := result + ' ' + fn_X509_sign;
  If @f_X509_REQ_sign=nil Then result := result + ' ' + fn_X509_REQ_sign;
  If @f_X509_CRL_sign=nil Then result := result + ' ' + fn_X509_CRL_sign;
  If @f_NETSCAPE_SPKI_sign=nil Then result := result + ' ' + fn_NETSCAPE_SPKI_sign;
  If @f_X509_digest=nil Then result := result + ' ' + fn_X509_digest;
  If @f_X509_NAME_digest=nil Then result := result + ' ' + fn_X509_NAME_digest;
  If @f_d2i_X509_fp=nil Then result := result + ' ' + fn_d2i_X509_fp;
  If @f_i2d_X509_fp=nil Then result := result + ' ' + fn_i2d_X509_fp;
  If @f_d2i_X509_CRL_fp=nil Then result := result + ' ' + fn_d2i_X509_CRL_fp;
  If @f_i2d_X509_CRL_fp=nil Then result := result + ' ' + fn_i2d_X509_CRL_fp;
  If @f_d2i_X509_REQ_fp=nil Then result := result + ' ' + fn_d2i_X509_REQ_fp;
  If @f_i2d_X509_REQ_fp=nil Then result := result + ' ' + fn_i2d_X509_REQ_fp;
  If @f_d2i_RSAPrivateKey_fp=nil Then result := result + ' ' + fn_d2i_RSAPrivateKey_fp;
  If @f_i2d_RSAPrivateKey_fp=nil Then result := result + ' ' + fn_i2d_RSAPrivateKey_fp;
  If @f_d2i_RSAPublicKey_fp=nil Then result := result + ' ' + fn_d2i_RSAPublicKey_fp;
  If @f_i2d_RSAPublicKey_fp=nil Then result := result + ' ' + fn_i2d_RSAPublicKey_fp;
  If @f_d2i_DSAPrivateKey_fp=nil Then result := result + ' ' + fn_d2i_DSAPrivateKey_fp;
  If @f_i2d_DSAPrivateKey_fp=nil Then result := result + ' ' + fn_i2d_DSAPrivateKey_fp;
  If @f_d2i_PKCS8_fp=nil Then result := result + ' ' + fn_d2i_PKCS8_fp;
  If @f_i2d_PKCS8_fp=nil Then result := result + ' ' + fn_i2d_PKCS8_fp;
  If @f_d2i_PKCS8_PRIV_KEY_INFO_fp=nil Then result := result + ' ' + fn_d2i_PKCS8_PRIV_KEY_INFO_fp;
  If @f_i2d_PKCS8_PRIV_KEY_INFO_fp=nil Then result := result + ' ' + fn_i2d_PKCS8_PRIV_KEY_INFO_fp;
  If @f_d2i_X509_bio=nil Then result := result + ' ' + fn_d2i_X509_bio;
  If @f_i2d_X509_bio=nil Then result := result + ' ' + fn_i2d_X509_bio;
  If @f_d2i_X509_CRL_bio=nil Then result := result + ' ' + fn_d2i_X509_CRL_bio;
  If @f_i2d_X509_CRL_bio=nil Then result := result + ' ' + fn_i2d_X509_CRL_bio;
  If @f_d2i_X509_REQ_bio=nil Then result := result + ' ' + fn_d2i_X509_REQ_bio;
  If @f_i2d_X509_REQ_bio=nil Then result := result + ' ' + fn_i2d_X509_REQ_bio;
  If @f_d2i_RSAPrivateKey_bio=nil Then result := result + ' ' + fn_d2i_RSAPrivateKey_bio;
  If @f_i2d_RSAPrivateKey_bio=nil Then result := result + ' ' + fn_i2d_RSAPrivateKey_bio;
  If @f_d2i_RSAPublicKey_bio=nil Then result := result + ' ' + fn_d2i_RSAPublicKey_bio;
  If @f_i2d_RSAPublicKey_bio=nil Then result := result + ' ' + fn_i2d_RSAPublicKey_bio;
  If @f_d2i_DSAPrivateKey_bio=nil Then result := result + ' ' + fn_d2i_DSAPrivateKey_bio;
  If @f_i2d_DSAPrivateKey_bio=nil Then result := result + ' ' + fn_i2d_DSAPrivateKey_bio;
  If @f_d2i_PKCS8_bio=nil Then result := result + ' ' + fn_d2i_PKCS8_bio;
  If @f_i2d_PKCS8_bio=nil Then result := result + ' ' + fn_i2d_PKCS8_bio;
  If @f_d2i_PKCS8_PRIV_KEY_INFO_bio=nil Then result := result + ' ' + fn_d2i_PKCS8_PRIV_KEY_INFO_bio;
  If @f_i2d_PKCS8_PRIV_KEY_INFO_bio=nil Then result := result + ' ' + fn_i2d_PKCS8_PRIV_KEY_INFO_bio;
  If @f_X509_dup=nil Then result := result + ' ' + fn_X509_dup;
  If @f_X509_ATTRIBUTE_dup=nil Then result := result + ' ' + fn_X509_ATTRIBUTE_dup;
  If @f_X509_EXTENSION_dup=nil Then result := result + ' ' + fn_X509_EXTENSION_dup;
  If @f_X509_CRL_dup=nil Then result := result + ' ' + fn_X509_CRL_dup;
  If @f_X509_REQ_dup=nil Then result := result + ' ' + fn_X509_REQ_dup;
  If @f_X509_ALGOR_dup=nil Then result := result + ' ' + fn_X509_ALGOR_dup;
  If @f_X509_NAME_dup=nil Then result := result + ' ' + fn_X509_NAME_dup;
  If @f_X509_NAME_ENTRY_dup=nil Then result := result + ' ' + fn_X509_NAME_ENTRY_dup;
  If @f_RSAPublicKey_dup=nil Then result := result + ' ' + fn_RSAPublicKey_dup;
  If @f_RSAPrivateKey_dup=nil Then result := result + ' ' + fn_RSAPrivateKey_dup;
  If @f_X509_cmp_current_time=nil Then result := result + ' ' + fn_X509_cmp_current_time;
  If @f_X509_gmtime_adj=nil Then result := result + ' ' + fn_X509_gmtime_adj;
  If @f_X509_get_default_cert_area=nil Then result := result + ' ' + fn_X509_get_default_cert_area;
  If @f_X509_get_default_cert_dir=nil Then result := result + ' ' + fn_X509_get_default_cert_dir;
  If @f_X509_get_default_cert_file=nil Then result := result + ' ' + fn_X509_get_default_cert_file;
  If @f_X509_get_default_cert_dir_env=nil Then result := result + ' ' + fn_X509_get_default_cert_dir_env;
  If @f_X509_get_default_cert_file_env=nil Then result := result + ' ' + fn_X509_get_default_cert_file_env;
  If @f_X509_get_default_private_dir=nil Then result := result + ' ' + fn_X509_get_default_private_dir;
  If @f_X509_to_X509_REQ=nil Then result := result + ' ' + fn_X509_to_X509_REQ;
  If @f_X509_REQ_to_X509=nil Then result := result + ' ' + fn_X509_REQ_to_X509;
  If @f_ERR_load_X509_strings=nil Then result := result + ' ' + fn_ERR_load_X509_strings;
  If @f_X509_ALGOR_new=nil Then result := result + ' ' + fn_X509_ALGOR_new;
  If @f_X509_ALGOR_free=nil Then result := result + ' ' + fn_X509_ALGOR_free;
  If @f_i2d_X509_ALGOR=nil Then result := result + ' ' + fn_i2d_X509_ALGOR;
  If @f_d2i_X509_ALGOR=nil Then result := result + ' ' + fn_d2i_X509_ALGOR;
  If @f_X509_VAL_new=nil Then result := result + ' ' + fn_X509_VAL_new;
  If @f_X509_VAL_free=nil Then result := result + ' ' + fn_X509_VAL_free;
  If @f_i2d_X509_VAL=nil Then result := result + ' ' + fn_i2d_X509_VAL;
  If @f_d2i_X509_VAL=nil Then result := result + ' ' + fn_d2i_X509_VAL;
  If @f_X509_PUBKEY_new=nil Then result := result + ' ' + fn_X509_PUBKEY_new;
  If @f_X509_PUBKEY_free=nil Then result := result + ' ' + fn_X509_PUBKEY_free;
  If @f_i2d_X509_PUBKEY=nil Then result := result + ' ' + fn_i2d_X509_PUBKEY;
  If @f_d2i_X509_PUBKEY=nil Then result := result + ' ' + fn_d2i_X509_PUBKEY;
  If @f_X509_PUBKEY_set=nil Then result := result + ' ' + fn_X509_PUBKEY_set;
  If @f_X509_PUBKEY_get=nil Then result := result + ' ' + fn_X509_PUBKEY_get;
  If @f_X509_get_pubkey_parameters=nil Then result := result + ' ' + fn_X509_get_pubkey_parameters;
  If @f_X509_SIG_new=nil Then result := result + ' ' + fn_X509_SIG_new;
  If @f_X509_SIG_free=nil Then result := result + ' ' + fn_X509_SIG_free;
  If @f_i2d_X509_SIG=nil Then result := result + ' ' + fn_i2d_X509_SIG;
  If @f_d2i_X509_SIG=nil Then result := result + ' ' + fn_d2i_X509_SIG;
  If @f_X509_REQ_INFO_new=nil Then result := result + ' ' + fn_X509_REQ_INFO_new;
  If @f_X509_REQ_INFO_free=nil Then result := result + ' ' + fn_X509_REQ_INFO_free;
  If @f_i2d_X509_REQ_INFO=nil Then result := result + ' ' + fn_i2d_X509_REQ_INFO;
  If @f_d2i_X509_REQ_INFO=nil Then result := result + ' ' + fn_d2i_X509_REQ_INFO;
  If @f_X509_REQ_new=nil Then result := result + ' ' + fn_X509_REQ_new;
  If @f_X509_REQ_free=nil Then result := result + ' ' + fn_X509_REQ_free;
  If @f_i2d_X509_REQ=nil Then result := result + ' ' + fn_i2d_X509_REQ;
  If @f_d2i_X509_REQ=nil Then result := result + ' ' + fn_d2i_X509_REQ;
  If @f_X509_ATTRIBUTE_new=nil Then result := result + ' ' + fn_X509_ATTRIBUTE_new;
  If @f_X509_ATTRIBUTE_free=nil Then result := result + ' ' + fn_X509_ATTRIBUTE_free;
  If @f_i2d_X509_ATTRIBUTE=nil Then result := result + ' ' + fn_i2d_X509_ATTRIBUTE;
  If @f_d2i_X509_ATTRIBUTE=nil Then result := result + ' ' + fn_d2i_X509_ATTRIBUTE;
  If @f_X509_ATTRIBUTE_create=nil Then result := result + ' ' + fn_X509_ATTRIBUTE_create;
  If @f_X509_EXTENSION_new=nil Then result := result + ' ' + fn_X509_EXTENSION_new;
  If @f_X509_EXTENSION_free=nil Then result := result + ' ' + fn_X509_EXTENSION_free;
  If @f_i2d_X509_EXTENSION=nil Then result := result + ' ' + fn_i2d_X509_EXTENSION;
  If @f_d2i_X509_EXTENSION=nil Then result := result + ' ' + fn_d2i_X509_EXTENSION;
  If @f_X509_NAME_ENTRY_new=nil Then result := result + ' ' + fn_X509_NAME_ENTRY_new;
  If @f_X509_NAME_ENTRY_free=nil Then result := result + ' ' + fn_X509_NAME_ENTRY_free;
  If @f_i2d_X509_NAME_ENTRY=nil Then result := result + ' ' + fn_i2d_X509_NAME_ENTRY;
  If @f_d2i_X509_NAME_ENTRY=nil Then result := result + ' ' + fn_d2i_X509_NAME_ENTRY;
  If @f_X509_NAME_new=nil Then result := result + ' ' + fn_X509_NAME_new;
  If @f_X509_NAME_free=nil Then result := result + ' ' + fn_X509_NAME_free;
  If @f_i2d_X509_NAME=nil Then result := result + ' ' + fn_i2d_X509_NAME;
  If @f_d2i_X509_NAME=nil Then result := result + ' ' + fn_d2i_X509_NAME;
  If @f_X509_NAME_set=nil Then result := result + ' ' + fn_X509_NAME_set;
  If @f_X509_CINF_new=nil Then result := result + ' ' + fn_X509_CINF_new;
  If @f_X509_CINF_free=nil Then result := result + ' ' + fn_X509_CINF_free;
  If @f_i2d_X509_CINF=nil Then result := result + ' ' + fn_i2d_X509_CINF;
  If @f_d2i_X509_CINF=nil Then result := result + ' ' + fn_d2i_X509_CINF;
  If @f_X509_new=nil Then result := result + ' ' + fn_X509_new;
  If @f_X509_free=nil Then result := result + ' ' + fn_X509_free;
  If @f_i2d_X509=nil Then result := result + ' ' + fn_i2d_X509;
  If @f_d2i_X509=nil Then result := result + ' ' + fn_d2i_X509;
  If @f_X509_REVOKED_new=nil Then result := result + ' ' + fn_X509_REVOKED_new;
  If @f_X509_REVOKED_free=nil Then result := result + ' ' + fn_X509_REVOKED_free;
  If @f_i2d_X509_REVOKED=nil Then result := result + ' ' + fn_i2d_X509_REVOKED;
  If @f_d2i_X509_REVOKED=nil Then result := result + ' ' + fn_d2i_X509_REVOKED;
  If @f_X509_CRL_INFO_new=nil Then result := result + ' ' + fn_X509_CRL_INFO_new;
  If @f_X509_CRL_INFO_free=nil Then result := result + ' ' + fn_X509_CRL_INFO_free;
  If @f_i2d_X509_CRL_INFO=nil Then result := result + ' ' + fn_i2d_X509_CRL_INFO;
  If @f_d2i_X509_CRL_INFO=nil Then result := result + ' ' + fn_d2i_X509_CRL_INFO;
  If @f_X509_CRL_new=nil Then result := result + ' ' + fn_X509_CRL_new;
  If @f_X509_CRL_free=nil Then result := result + ' ' + fn_X509_CRL_free;
  If @f_i2d_X509_CRL=nil Then result := result + ' ' + fn_i2d_X509_CRL;
  If @f_d2i_X509_CRL=nil Then result := result + ' ' + fn_d2i_X509_CRL;
  If @f_X509_PKEY_new=nil Then result := result + ' ' + fn_X509_PKEY_new;
  If @f_X509_PKEY_free=nil Then result := result + ' ' + fn_X509_PKEY_free;
  If @f_i2d_X509_PKEY=nil Then result := result + ' ' + fn_i2d_X509_PKEY;
  If @f_d2i_X509_PKEY=nil Then result := result + ' ' + fn_d2i_X509_PKEY;
  If @f_NETSCAPE_SPKI_new=nil Then result := result + ' ' + fn_NETSCAPE_SPKI_new;
  If @f_NETSCAPE_SPKI_free=nil Then result := result + ' ' + fn_NETSCAPE_SPKI_free;
  If @f_i2d_NETSCAPE_SPKI=nil Then result := result + ' ' + fn_i2d_NETSCAPE_SPKI;
  If @f_d2i_NETSCAPE_SPKI=nil Then result := result + ' ' + fn_d2i_NETSCAPE_SPKI;
  If @f_NETSCAPE_SPKAC_new=nil Then result := result + ' ' + fn_NETSCAPE_SPKAC_new;
  If @f_NETSCAPE_SPKAC_free=nil Then result := result + ' ' + fn_NETSCAPE_SPKAC_free;
  If @f_i2d_NETSCAPE_SPKAC=nil Then result := result + ' ' + fn_i2d_NETSCAPE_SPKAC;
  If @f_d2i_NETSCAPE_SPKAC=nil Then result := result + ' ' + fn_d2i_NETSCAPE_SPKAC;
  If @f_i2d_NETSCAPE_CERT_SEQUENCE=nil Then result := result + ' ' + fn_i2d_NETSCAPE_CERT_SEQUENCE;
  If @f_NETSCAPE_CERT_SEQUENCE_new=nil Then result := result + ' ' + fn_NETSCAPE_CERT_SEQUENCE_new;
  If @f_d2i_NETSCAPE_CERT_SEQUENCE=nil Then result := result + ' ' + fn_d2i_NETSCAPE_CERT_SEQUENCE;
  If @f_NETSCAPE_CERT_SEQUENCE_free=nil Then result := result + ' ' + fn_NETSCAPE_CERT_SEQUENCE_free;
  If @f_X509_INFO_new=nil Then result := result + ' ' + fn_X509_INFO_new;
  If @f_X509_INFO_free=nil Then result := result + ' ' + fn_X509_INFO_free;
  If @f_X509_NAME_oneline=nil Then result := result + ' ' + fn_X509_NAME_oneline;
  If @f_ASN1_verify=nil Then result := result + ' ' + fn_ASN1_verify;
  If @f_ASN1_digest=nil Then result := result + ' ' + fn_ASN1_digest;
  If @f_ASN1_sign=nil Then result := result + ' ' + fn_ASN1_sign;
  If @f_X509_set_version=nil Then result := result + ' ' + fn_X509_set_version;
  If @f_X509_set_serialNumber=nil Then result := result + ' ' + fn_X509_set_serialNumber;
  If @f_X509_get_serialNumber=nil Then result := result + ' ' + fn_X509_get_serialNumber;
  If @f_X509_set_issuer_name=nil Then result := result + ' ' + fn_X509_set_issuer_name;
  If @f_X509_get_issuer_name=nil Then result := result + ' ' + fn_X509_get_issuer_name;
  If @f_X509_set_subject_name=nil Then result := result + ' ' + fn_X509_set_subject_name;
  If @f_X509_get_subject_name=nil Then result := result + ' ' + fn_X509_get_subject_name;
  If @f_X509_set_notBefore=nil Then result := result + ' ' + fn_X509_set_notBefore;
  If @f_X509_set_notAfter=nil Then result := result + ' ' + fn_X509_set_notAfter;
  If @f_X509_set_pubkey=nil Then result := result + ' ' + fn_X509_set_pubkey;
  If @f_X509_get_pubkey=nil Then result := result + ' ' + fn_X509_get_pubkey;
  If @f_X509_certificate_type=nil Then result := result + ' ' + fn_X509_certificate_type;
  If @f_X509_REQ_set_version=nil Then result := result + ' ' + fn_X509_REQ_set_version;
  If @f_X509_REQ_set_subject_name=nil Then result := result + ' ' + fn_X509_REQ_set_subject_name;
  If @f_X509_REQ_set_pubkey=nil Then result := result + ' ' + fn_X509_REQ_set_pubkey;
  If @f_X509_REQ_get_pubkey=nil Then result := result + ' ' + fn_X509_REQ_get_pubkey;
  If @f_X509_check_private_key=nil Then result := result + ' ' + fn_X509_check_private_key;
  If @f_X509_issuer_and_serial_cmp=nil Then result := result + ' ' + fn_X509_issuer_and_serial_cmp;
  If @f_X509_issuer_and_serial_hash=nil Then result := result + ' ' + fn_X509_issuer_and_serial_hash;
  If @f_X509_issuer_name_cmp=nil Then result := result + ' ' + fn_X509_issuer_name_cmp;
  If @f_X509_issuer_name_hash=nil Then result := result + ' ' + fn_X509_issuer_name_hash;
  If @f_X509_subject_name_cmp=nil Then result := result + ' ' + fn_X509_subject_name_cmp;
  If @f_X509_subject_name_hash=nil Then result := result + ' ' + fn_X509_subject_name_hash;
  If @f_X509_NAME_cmp=nil Then result := result + ' ' + fn_X509_NAME_cmp;
  If @f_X509_NAME_hash=nil Then result := result + ' ' + fn_X509_NAME_hash;
  If @f_X509_CRL_cmp=nil Then result := result + ' ' + fn_X509_CRL_cmp;
  If @f_X509_print_fp=nil Then result := result + ' ' + fn_X509_print_fp;
  If @f_X509_CRL_print_fp=nil Then result := result + ' ' + fn_X509_CRL_print_fp;
  If @f_X509_REQ_print_fp=nil Then result := result + ' ' + fn_X509_REQ_print_fp;
  If @f_X509_NAME_print=nil Then result := result + ' ' + fn_X509_NAME_print;
  If @f_X509_print=nil Then result := result + ' ' + fn_X509_print;
  If @f_X509_CRL_print=nil Then result := result + ' ' + fn_X509_CRL_print;
  If @f_X509_REQ_print=nil Then result := result + ' ' + fn_X509_REQ_print;
  If @f_X509_NAME_entry_count=nil Then result := result + ' ' + fn_X509_NAME_entry_count;
  If @f_X509_NAME_get_text_by_NID=nil Then result := result + ' ' + fn_X509_NAME_get_text_by_NID;
  If @f_X509_NAME_get_text_by_OBJ=nil Then result := result + ' ' + fn_X509_NAME_get_text_by_OBJ;
  If @f_X509_NAME_get_index_by_NID=nil Then result := result + ' ' + fn_X509_NAME_get_index_by_NID;
  If @f_X509_NAME_get_index_by_OBJ=nil Then result := result + ' ' + fn_X509_NAME_get_index_by_OBJ;
  If @f_X509_NAME_get_entry=nil Then result := result + ' ' + fn_X509_NAME_get_entry;
  If @f_X509_NAME_delete_entry=nil Then result := result + ' ' + fn_X509_NAME_delete_entry;
  If @f_X509_NAME_add_entry=nil Then result := result + ' ' + fn_X509_NAME_add_entry;
  If @f_X509_NAME_ENTRY_create_by_NID=nil Then result := result + ' ' + fn_X509_NAME_ENTRY_create_by_NID;
  If @f_X509_NAME_ENTRY_create_by_OBJ=nil Then result := result + ' ' + fn_X509_NAME_ENTRY_create_by_OBJ;
  If @f_X509_NAME_ENTRY_set_object=nil Then result := result + ' ' + fn_X509_NAME_ENTRY_set_object;
  If @f_X509_NAME_ENTRY_set_data=nil Then result := result + ' ' + fn_X509_NAME_ENTRY_set_data;
  If @f_X509_NAME_ENTRY_get_object=nil Then result := result + ' ' + fn_X509_NAME_ENTRY_get_object;
  If @f_X509_NAME_ENTRY_get_data=nil Then result := result + ' ' + fn_X509_NAME_ENTRY_get_data;
  If @f_X509v3_get_ext_count=nil Then result := result + ' ' + fn_X509v3_get_ext_count;
  If @f_X509v3_get_ext_by_NID=nil Then result := result + ' ' + fn_X509v3_get_ext_by_NID;
  If @f_X509v3_get_ext_by_OBJ=nil Then result := result + ' ' + fn_X509v3_get_ext_by_OBJ;
  If @f_X509v3_get_ext_by_critical=nil Then result := result + ' ' + fn_X509v3_get_ext_by_critical;
  If @f_X509v3_get_ext=nil Then result := result + ' ' + fn_X509v3_get_ext;
  If @f_X509v3_delete_ext=nil Then result := result + ' ' + fn_X509v3_delete_ext;
  If @f_X509v3_add_ext=nil Then result := result + ' ' + fn_X509v3_add_ext;
  If @f_X509_get_ext_count=nil Then result := result + ' ' + fn_X509_get_ext_count;
  If @f_X509_get_ext_by_NID=nil Then result := result + ' ' + fn_X509_get_ext_by_NID;
  If @f_X509_get_ext_by_OBJ=nil Then result := result + ' ' + fn_X509_get_ext_by_OBJ;
  If @f_X509_get_ext_by_critical=nil Then result := result + ' ' + fn_X509_get_ext_by_critical;
  If @f_X509_get_ext=nil Then result := result + ' ' + fn_X509_get_ext;
  If @f_X509_delete_ext=nil Then result := result + ' ' + fn_X509_delete_ext;
  If @f_X509_add_ext=nil Then result := result + ' ' + fn_X509_add_ext;
  If @f_X509_CRL_get_ext_count=nil Then result := result + ' ' + fn_X509_CRL_get_ext_count;
  If @f_X509_CRL_get_ext_by_NID=nil Then result := result + ' ' + fn_X509_CRL_get_ext_by_NID;
  If @f_X509_CRL_get_ext_by_OBJ=nil Then result := result + ' ' + fn_X509_CRL_get_ext_by_OBJ;
  If @f_X509_CRL_get_ext_by_critical=nil Then result := result + ' ' + fn_X509_CRL_get_ext_by_critical;
  If @f_X509_CRL_get_ext=nil Then result := result + ' ' + fn_X509_CRL_get_ext;
  If @f_X509_CRL_delete_ext=nil Then result := result + ' ' + fn_X509_CRL_delete_ext;
  If @f_X509_CRL_add_ext=nil Then result := result + ' ' + fn_X509_CRL_add_ext;
  If @f_X509_REVOKED_get_ext_count=nil Then result := result + ' ' + fn_X509_REVOKED_get_ext_count;
  If @f_X509_REVOKED_get_ext_by_NID=nil Then result := result + ' ' + fn_X509_REVOKED_get_ext_by_NID;
  If @f_X509_REVOKED_get_ext_by_OBJ=nil Then result := result + ' ' + fn_X509_REVOKED_get_ext_by_OBJ;
  If @f_X509_REVOKED_get_ext_by_critical=nil Then result := result + ' ' + fn_X509_REVOKED_get_ext_by_critical;
  If @f_X509_REVOKED_get_ext=nil Then result := result + ' ' + fn_X509_REVOKED_get_ext;
  If @f_X509_REVOKED_delete_ext=nil Then result := result + ' ' + fn_X509_REVOKED_delete_ext;
  If @f_X509_REVOKED_add_ext=nil Then result := result + ' ' + fn_X509_REVOKED_add_ext;
  If @f_X509_EXTENSION_create_by_NID=nil Then result := result + ' ' + fn_X509_EXTENSION_create_by_NID;
  If @f_X509_EXTENSION_create_by_OBJ=nil Then result := result + ' ' + fn_X509_EXTENSION_create_by_OBJ;
  If @f_X509_EXTENSION_set_object=nil Then result := result + ' ' + fn_X509_EXTENSION_set_object;
  If @f_X509_EXTENSION_set_critical=nil Then result := result + ' ' + fn_X509_EXTENSION_set_critical;
  If @f_X509_EXTENSION_set_data=nil Then result := result + ' ' + fn_X509_EXTENSION_set_data;
  If @f_X509_EXTENSION_get_object=nil Then result := result + ' ' + fn_X509_EXTENSION_get_object;
  If @f_X509_EXTENSION_get_data=nil Then result := result + ' ' + fn_X509_EXTENSION_get_data;
  If @f_X509_EXTENSION_get_critical=nil Then result := result + ' ' + fn_X509_EXTENSION_get_critical;
  If @f_X509_verify_cert=nil Then result := result + ' ' + fn_X509_verify_cert;
  If @f_X509_find_by_issuer_and_serial=nil Then result := result + ' ' + fn_X509_find_by_issuer_and_serial;
  If @f_X509_find_by_subject=nil Then result := result + ' ' + fn_X509_find_by_subject;
  If @f_i2d_PBEPARAM=nil Then result := result + ' ' + fn_i2d_PBEPARAM;
  If @f_PBEPARAM_new=nil Then result := result + ' ' + fn_PBEPARAM_new;
  If @f_d2i_PBEPARAM=nil Then result := result + ' ' + fn_d2i_PBEPARAM;
  If @f_PBEPARAM_free=nil Then result := result + ' ' + fn_PBEPARAM_free;
  If @f_PKCS5_pbe_set=nil Then result := result + ' ' + fn_PKCS5_pbe_set;
  If @f_PKCS5_pbe2_set=nil Then result := result + ' ' + fn_PKCS5_pbe2_set;
  If @f_i2d_PBKDF2PARAM=nil Then result := result + ' ' + fn_i2d_PBKDF2PARAM;
  If @f_PBKDF2PARAM_new=nil Then result := result + ' ' + fn_PBKDF2PARAM_new;
  If @f_d2i_PBKDF2PARAM=nil Then result := result + ' ' + fn_d2i_PBKDF2PARAM;
  If @f_PBKDF2PARAM_free=nil Then result := result + ' ' + fn_PBKDF2PARAM_free;
  If @f_i2d_PBE2PARAM=nil Then result := result + ' ' + fn_i2d_PBE2PARAM;
  If @f_PBE2PARAM_new=nil Then result := result + ' ' + fn_PBE2PARAM_new;
  If @f_d2i_PBE2PARAM=nil Then result := result + ' ' + fn_d2i_PBE2PARAM;
  If @f_PBE2PARAM_free=nil Then result := result + ' ' + fn_PBE2PARAM_free;
  If @f_i2d_PKCS8_PRIV_KEY_INFO=nil Then result := result + ' ' + fn_i2d_PKCS8_PRIV_KEY_INFO;
  If @f_PKCS8_PRIV_KEY_INFO_new=nil Then result := result + ' ' + fn_PKCS8_PRIV_KEY_INFO_new;
  If @f_d2i_PKCS8_PRIV_KEY_INFO=nil Then result := result + ' ' + fn_d2i_PKCS8_PRIV_KEY_INFO;
  If @f_PKCS8_PRIV_KEY_INFO_free=nil Then result := result + ' ' + fn_PKCS8_PRIV_KEY_INFO_free;
  If @f_EVP_PKCS82PKEY=nil Then result := result + ' ' + fn_EVP_PKCS82PKEY;
  If @f_EVP_PKEY2PKCS8=nil Then result := result + ' ' + fn_EVP_PKEY2PKCS8;
  If @f_PKCS8_set_broken=nil Then result := result + ' ' + fn_PKCS8_set_broken;
  If @f_ERR_load_PEM_strings=nil Then result := result + ' ' + fn_ERR_load_PEM_strings;
  If @f_PEM_get_EVP_CIPHER_INFO=nil Then result := result + ' ' + fn_PEM_get_EVP_CIPHER_INFO;
  If @f_PEM_do_header=nil Then result := result + ' ' + fn_PEM_do_header;
  If @f_PEM_read_bio=nil Then result := result + ' ' + fn_PEM_read_bio;
  If @f_PEM_write_bio=nil Then result := result + ' ' + fn_PEM_write_bio;
  If @f_PEM_ASN1_read_bio=nil Then result := result + ' ' + fn_PEM_ASN1_read_bio;
  If @f_PEM_ASN1_write_bio=nil Then result := result + ' ' + fn_PEM_ASN1_write_bio;
  If @f_PEM_X509_INFO_read_bio=nil Then result := result + ' ' + fn_PEM_X509_INFO_read_bio;
  If @f_PEM_X509_INFO_write_bio=nil Then result := result + ' ' + fn_PEM_X509_INFO_write_bio;
  If @f_PEM_read=nil Then result := result + ' ' + fn_PEM_read;
  If @f_PEM_write=nil Then result := result + ' ' + fn_PEM_write;
  If @f_PEM_ASN1_read=nil Then result := result + ' ' + fn_PEM_ASN1_read;
  If @f_PEM_ASN1_write=nil Then result := result + ' ' + fn_PEM_ASN1_write;
  If @f_PEM_X509_INFO_read=nil Then result := result + ' ' + fn_PEM_X509_INFO_read;
  If @f_PEM_SealInit=nil Then result := result + ' ' + fn_PEM_SealInit;
  If @f_PEM_SealUpdate=nil Then result := result + ' ' + fn_PEM_SealUpdate;
  If @f_PEM_SealFinal=nil Then result := result + ' ' + fn_PEM_SealFinal;
  If @f_PEM_SignInit=nil Then result := result + ' ' + fn_PEM_SignInit;
  If @f_PEM_SignUpdate=nil Then result := result + ' ' + fn_PEM_SignUpdate;
  If @f_PEM_SignFinal=nil Then result := result + ' ' + fn_PEM_SignFinal;
  If @f_PEM_proc_type=nil Then result := result + ' ' + fn_PEM_proc_type;
  If @f_PEM_dek_info=nil Then result := result + ' ' + fn_PEM_dek_info;
  If @f_PEM_read_bio_X509=nil Then result := result + ' ' + fn_PEM_read_bio_X509;
  If @f_PEM_read_X509=nil Then result := result + ' ' + fn_PEM_read_X509;
  If @f_PEM_write_bio_X509=nil Then result := result + ' ' + fn_PEM_write_bio_X509;
  If @f_PEM_write_X509=nil Then result := result + ' ' + fn_PEM_write_X509;
  If @f_PEM_read_bio_X509_REQ=nil Then result := result + ' ' + fn_PEM_read_bio_X509_REQ;
  If @f_PEM_read_X509_REQ=nil Then result := result + ' ' + fn_PEM_read_X509_REQ;
  If @f_PEM_write_bio_X509_REQ=nil Then result := result + ' ' + fn_PEM_write_bio_X509_REQ;
  If @f_PEM_write_X509_REQ=nil Then result := result + ' ' + fn_PEM_write_X509_REQ;
  If @f_PEM_read_bio_X509_CRL=nil Then result := result + ' ' + fn_PEM_read_bio_X509_CRL;
  If @f_PEM_read_X509_CRL=nil Then result := result + ' ' + fn_PEM_read_X509_CRL;
  If @f_PEM_write_bio_X509_CRL=nil Then result := result + ' ' + fn_PEM_write_bio_X509_CRL;
  If @f_PEM_write_X509_CRL=nil Then result := result + ' ' + fn_PEM_write_X509_CRL;
  If @f_PEM_read_bio_PKCS7=nil Then result := result + ' ' + fn_PEM_read_bio_PKCS7;
  If @f_PEM_read_PKCS7=nil Then result := result + ' ' + fn_PEM_read_PKCS7;
  If @f_PEM_write_bio_PKCS7=nil Then result := result + ' ' + fn_PEM_write_bio_PKCS7;
  If @f_PEM_write_PKCS7=nil Then result := result + ' ' + fn_PEM_write_PKCS7;
  If @f_PEM_read_bio_NETSCAPE_CERT_SEQUENCE=nil Then result := result + ' ' + fn_PEM_read_bio_NETSCAPE_CERT_SEQUENCE;
  If @f_PEM_read_NETSCAPE_CERT_SEQUENCE=nil Then result := result + ' ' + fn_PEM_read_NETSCAPE_CERT_SEQUENCE;
  If @f_PEM_write_bio_NETSCAPE_CERT_SEQUENCE=nil Then result := result + ' ' + fn_PEM_write_bio_NETSCAPE_CERT_SEQUENCE;
  If @f_PEM_write_NETSCAPE_CERT_SEQUENCE=nil Then result := result + ' ' + fn_PEM_write_NETSCAPE_CERT_SEQUENCE;
  If @f_PEM_read_bio_PKCS8=nil Then result := result + ' ' + fn_PEM_read_bio_PKCS8;
  If @f_PEM_read_PKCS8=nil Then result := result + ' ' + fn_PEM_read_PKCS8;
  If @f_PEM_write_bio_PKCS8=nil Then result := result + ' ' + fn_PEM_write_bio_PKCS8;
  If @f_PEM_write_PKCS8=nil Then result := result + ' ' + fn_PEM_write_PKCS8;
  If @f_PEM_read_bio_PKCS8_PRIV_KEY_INFO=nil Then result := result + ' ' + fn_PEM_read_bio_PKCS8_PRIV_KEY_INFO;
  If @f_PEM_read_PKCS8_PRIV_KEY_INFO=nil Then result := result + ' ' + fn_PEM_read_PKCS8_PRIV_KEY_INFO;
  If @f_PEM_write_bio_PKCS8_PRIV_KEY_INFO=nil Then result := result + ' ' + fn_PEM_write_bio_PKCS8_PRIV_KEY_INFO;
  If @f_PEM_write_PKCS8_PRIV_KEY_INFO=nil Then result := result + ' ' + fn_PEM_write_PKCS8_PRIV_KEY_INFO;
  If @f_PEM_read_bio_RSAPrivateKey=nil Then result := result + ' ' + fn_PEM_read_bio_RSAPrivateKey;
  If @f_PEM_read_RSAPrivateKey=nil Then result := result + ' ' + fn_PEM_read_RSAPrivateKey;
  If @f_PEM_write_bio_RSAPrivateKey=nil Then result := result + ' ' + fn_PEM_write_bio_RSAPrivateKey;
  If @f_PEM_write_RSAPrivateKey=nil Then result := result + ' ' + fn_PEM_write_RSAPrivateKey;
  If @f_PEM_read_bio_RSAPublicKey=nil Then result := result + ' ' + fn_PEM_read_bio_RSAPublicKey;
  If @f_PEM_read_RSAPublicKey=nil Then result := result + ' ' + fn_PEM_read_RSAPublicKey;
  If @f_PEM_write_bio_RSAPublicKey=nil Then result := result + ' ' + fn_PEM_write_bio_RSAPublicKey;
  If @f_PEM_write_RSAPublicKey=nil Then result := result + ' ' + fn_PEM_write_RSAPublicKey;
  If @f_PEM_read_bio_DSAPrivateKey=nil Then result := result + ' ' + fn_PEM_read_bio_DSAPrivateKey;
  If @f_PEM_read_DSAPrivateKey=nil Then result := result + ' ' + fn_PEM_read_DSAPrivateKey;
  If @f_PEM_write_bio_DSAPrivateKey=nil Then result := result + ' ' + fn_PEM_write_bio_DSAPrivateKey;
  If @f_PEM_write_DSAPrivateKey=nil Then result := result + ' ' + fn_PEM_write_DSAPrivateKey;
  If @f_PEM_read_bio_DSAparams=nil Then result := result + ' ' + fn_PEM_read_bio_DSAparams;
  If @f_PEM_read_DSAparams=nil Then result := result + ' ' + fn_PEM_read_DSAparams;
  If @f_PEM_write_bio_DSAparams=nil Then result := result + ' ' + fn_PEM_write_bio_DSAparams;
  If @f_PEM_write_DSAparams=nil Then result := result + ' ' + fn_PEM_write_DSAparams;
  If @f_PEM_read_bio_DHparams=nil Then result := result + ' ' + fn_PEM_read_bio_DHparams;
  If @f_PEM_read_DHparams=nil Then result := result + ' ' + fn_PEM_read_DHparams;
  If @f_PEM_write_bio_DHparams=nil Then result := result + ' ' + fn_PEM_write_bio_DHparams;
  If @f_PEM_write_DHparams=nil Then result := result + ' ' + fn_PEM_write_DHparams;
  If @f_PEM_read_bio_PrivateKey=nil Then result := result + ' ' + fn_PEM_read_bio_PrivateKey;
  If @f_PEM_read_PrivateKey=nil Then result := result + ' ' + fn_PEM_read_PrivateKey;
  If @f_PEM_write_bio_PrivateKey=nil Then result := result + ' ' + fn_PEM_write_bio_PrivateKey;
  If @f_PEM_write_PrivateKey=nil Then result := result + ' ' + fn_PEM_write_PrivateKey;
  If @f_PEM_write_bio_PKCS8PrivateKey=nil Then result := result + ' ' + fn_PEM_write_bio_PKCS8PrivateKey;
  If @f_PEM_write_PKCS8PrivateKey=nil Then result := result + ' ' + fn_PEM_write_PKCS8PrivateKey;
  If @f_sk_SSL_CIPHER_new=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_new;
  If @f_sk_SSL_CIPHER_new_null=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_new_null;
  If @f_sk_SSL_CIPHER_free=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_free;
  If @f_sk_SSL_CIPHER_num=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_num;
  If @f_sk_SSL_CIPHER_value=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_value;
  If @f_sk_SSL_CIPHER_set=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_set;
  If @f_sk_SSL_CIPHER_zero=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_zero;
  If @f_sk_SSL_CIPHER_push=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_push;
  If @f_sk_SSL_CIPHER_unshift=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_unshift;
  If @f_sk_SSL_CIPHER_find=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_find;
  If @f_sk_SSL_CIPHER_delete=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_delete;
  If @f_sk_SSL_CIPHER_delete_ptr=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_delete_ptr;
  If @f_sk_SSL_CIPHER_insert=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_insert;
  If @f_sk_SSL_CIPHER_dup=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_dup;
  If @f_sk_SSL_CIPHER_pop_free=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_pop_free;
  If @f_sk_SSL_CIPHER_shift=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_shift;
  If @f_sk_SSL_CIPHER_pop=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_pop;
  If @f_sk_SSL_CIPHER_sort=nil Then result := result + ' ' + fn_sk_SSL_CIPHER_sort;
  If @f_sk_SSL_COMP_new=nil Then result := result + ' ' + fn_sk_SSL_COMP_new;
  If @f_sk_SSL_COMP_new_null=nil Then result := result + ' ' + fn_sk_SSL_COMP_new_null;
  If @f_sk_SSL_COMP_free=nil Then result := result + ' ' + fn_sk_SSL_COMP_free;
  If @f_sk_SSL_COMP_num=nil Then result := result + ' ' + fn_sk_SSL_COMP_num;
  If @f_sk_SSL_COMP_value=nil Then result := result + ' ' + fn_sk_SSL_COMP_value;
  If @f_sk_SSL_COMP_set=nil Then result := result + ' ' + fn_sk_SSL_COMP_set;
  If @f_sk_SSL_COMP_zero=nil Then result := result + ' ' + fn_sk_SSL_COMP_zero;
  If @f_sk_SSL_COMP_push=nil Then result := result + ' ' + fn_sk_SSL_COMP_push;
  If @f_sk_SSL_COMP_unshift=nil Then result := result + ' ' + fn_sk_SSL_COMP_unshift;
  If @f_sk_SSL_COMP_find=nil Then result := result + ' ' + fn_sk_SSL_COMP_find;
  If @f_sk_SSL_COMP_delete=nil Then result := result + ' ' + fn_sk_SSL_COMP_delete;
  If @f_sk_SSL_COMP_delete_ptr=nil Then result := result + ' ' + fn_sk_SSL_COMP_delete_ptr;
  If @f_sk_SSL_COMP_insert=nil Then result := result + ' ' + fn_sk_SSL_COMP_insert;
  If @f_sk_SSL_COMP_dup=nil Then result := result + ' ' + fn_sk_SSL_COMP_dup;
  If @f_sk_SSL_COMP_pop_free=nil Then result := result + ' ' + fn_sk_SSL_COMP_pop_free;
  If @f_sk_SSL_COMP_shift=nil Then result := result + ' ' + fn_sk_SSL_COMP_shift;
  If @f_sk_SSL_COMP_pop=nil Then result := result + ' ' + fn_sk_SSL_COMP_pop;
  If @f_sk_SSL_COMP_sort=nil Then result := result + ' ' + fn_sk_SSL_COMP_sort;
  If @f_BIO_f_ssl=nil Then result := result + ' ' + fn_BIO_f_ssl;
  If @f_BIO_new_ssl=nil Then result := result + ' ' + fn_BIO_new_ssl;
  If @f_BIO_new_ssl_connect=nil Then result := result + ' ' + fn_BIO_new_ssl_connect;
  If @f_BIO_new_buffer_ssl_connect=nil Then result := result + ' ' + fn_BIO_new_buffer_ssl_connect;
  If @f_BIO_ssl_copy_session_id=nil Then result := result + ' ' + fn_BIO_ssl_copy_session_id;
  If @f_BIO_ssl_shutdown=nil Then result := result + ' ' + fn_BIO_ssl_shutdown;
  If @f_SSL_CTX_set_cipher_list=nil Then result := result + ' ' + fn_SSL_CTX_set_cipher_list;
  If @f_SSL_CTX_new=nil Then result := result + ' ' + fn_SSL_CTX_new;
  If @f_SSL_CTX_free=nil Then result := result + ' ' + fn_SSL_CTX_free;
  If @f_SSL_CTX_set_timeout=nil Then result := result + ' ' + fn_SSL_CTX_set_timeout;
  If @f_SSL_CTX_get_timeout=nil Then result := result + ' ' + fn_SSL_CTX_get_timeout;
  If @f_SSL_CTX_get_cert_store=nil Then result := result + ' ' + fn_SSL_CTX_get_cert_store;
  If @f_SSL_CTX_set_cert_store=nil Then result := result + ' ' + fn_SSL_CTX_set_cert_store;
  If @f_SSL_want=nil Then result := result + ' ' + fn_SSL_want;
  If @f_SSL_clear=nil Then result := result + ' ' + fn_SSL_clear;
  If @f_SSL_CTX_flush_sessions=nil Then result := result + ' ' + fn_SSL_CTX_flush_sessions;
  If @f_SSL_get_current_cipher=nil Then result := result + ' ' + fn_SSL_get_current_cipher;
  If @f_SSL_CIPHER_get_bits=nil Then result := result + ' ' + fn_SSL_CIPHER_get_bits;
  If @f_SSL_CIPHER_get_version=nil Then result := result + ' ' + fn_SSL_CIPHER_get_version;
  If @f_SSL_CIPHER_get_name=nil Then result := result + ' ' + fn_SSL_CIPHER_get_name;
  If @f_SSL_get_fd=nil Then result := result + ' ' + fn_SSL_get_fd;
  If @f_SSL_get_cipher_list=nil Then result := result + ' ' + fn_SSL_get_cipher_list;
  If @f_SSL_get_shared_ciphers=nil Then result := result + ' ' + fn_SSL_get_shared_ciphers;
  If @f_SSL_get_read_ahead=nil Then result := result + ' ' + fn_SSL_get_read_ahead;
  If @f_SSL_pending=nil Then result := result + ' ' + fn_SSL_pending;
  If @f_SSL_set_fd=nil Then result := result + ' ' + fn_SSL_set_fd;
  If @f_SSL_set_rfd=nil Then result := result + ' ' + fn_SSL_set_rfd;
  If @f_SSL_set_wfd=nil Then result := result + ' ' + fn_SSL_set_wfd;
  If @f_SSL_set_bio=nil Then result := result + ' ' + fn_SSL_set_bio;
  If @f_SSL_get_rbio=nil Then result := result + ' ' + fn_SSL_get_rbio;
  If @f_SSL_get_wbio=nil Then result := result + ' ' + fn_SSL_get_wbio;
  If @f_SSL_set_cipher_list=nil Then result := result + ' ' + fn_SSL_set_cipher_list;
  If @f_SSL_set_read_ahead=nil Then result := result + ' ' + fn_SSL_set_read_ahead;
  If @f_SSL_get_verify_mode=nil Then result := result + ' ' + fn_SSL_get_verify_mode;
  If @f_SSL_get_verify_depth=nil Then result := result + ' ' + fn_SSL_get_verify_depth;
  If @f_SSL_set_verify=nil Then result := result + ' ' + fn_SSL_set_verify;
  If @f_SSL_set_verify_depth=nil Then result := result + ' ' + fn_SSL_set_verify_depth;
  If @f_SSL_use_RSAPrivateKey=nil Then result := result + ' ' + fn_SSL_use_RSAPrivateKey;
  If @f_SSL_use_RSAPrivateKey_ASN1=nil Then result := result + ' ' + fn_SSL_use_RSAPrivateKey_ASN1;
  If @f_SSL_use_PrivateKey=nil Then result := result + ' ' + fn_SSL_use_PrivateKey;
  If @f_SSL_use_PrivateKey_ASN1=nil Then result := result + ' ' + fn_SSL_use_PrivateKey_ASN1;
  If @f_SSL_use_certificate=nil Then result := result + ' ' + fn_SSL_use_certificate;
  If @f_SSL_use_certificate_ASN1=nil Then result := result + ' ' + fn_SSL_use_certificate_ASN1;
  If @f_SSL_use_RSAPrivateKey_file=nil Then result := result + ' ' + fn_SSL_use_RSAPrivateKey_file;
  If @f_SSL_use_PrivateKey_file=nil Then result := result + ' ' + fn_SSL_use_PrivateKey_file;
  If @f_SSL_use_certificate_file=nil Then result := result + ' ' + fn_SSL_use_certificate_file;
  If @f_SSL_CTX_use_RSAPrivateKey_file=nil Then result := result + ' ' + fn_SSL_CTX_use_RSAPrivateKey_file;
  If @f_SSL_CTX_use_PrivateKey_file=nil Then result := result + ' ' + fn_SSL_CTX_use_PrivateKey_file;
  If @f_SSL_CTX_use_certificate_file=nil Then result := result + ' ' + fn_SSL_CTX_use_certificate_file;
  If @f_SSL_CTX_use_certificate_chain_file=nil Then result := result + ' ' + fn_SSL_CTX_use_certificate_chain_file;
  If @f_SSL_load_client_CA_file=nil Then result := result + ' ' + fn_SSL_load_client_CA_file;
  If @f_SSL_add_file_cert_subjects_to_stack=nil Then result := result + ' ' + fn_SSL_add_file_cert_subjects_to_stack;
  If @f_ERR_load_SSL_strings=nil Then result := result + ' ' + fn_ERR_load_SSL_strings;
  If @f_SSL_load_error_strings=nil Then result := result + ' ' + fn_SSL_load_error_strings;
  If @f_SSL_state_string=nil Then result := result + ' ' + fn_SSL_state_string;
  If @f_SSL_rstate_string=nil Then result := result + ' ' + fn_SSL_rstate_string;
  If @f_SSL_state_string_long=nil Then result := result + ' ' + fn_SSL_state_string_long;
  If @f_SSL_rstate_string_long=nil Then result := result + ' ' + fn_SSL_rstate_string_long;
  If @f_SSL_SESSION_get_time=nil Then result := result + ' ' + fn_SSL_SESSION_get_time;
  If @f_SSL_SESSION_set_time=nil Then result := result + ' ' + fn_SSL_SESSION_set_time;
  If @f_SSL_SESSION_get_timeout=nil Then result := result + ' ' + fn_SSL_SESSION_get_timeout;
  If @f_SSL_SESSION_set_timeout=nil Then result := result + ' ' + fn_SSL_SESSION_set_timeout;
  If @f_SSL_copy_session_id=nil Then result := result + ' ' + fn_SSL_copy_session_id;
  If @f_SSL_SESSION_new=nil Then result := result + ' ' + fn_SSL_SESSION_new;
  If @f_SSL_SESSION_hash=nil Then result := result + ' ' + fn_SSL_SESSION_hash;
  If @f_SSL_SESSION_cmp=nil Then result := result + ' ' + fn_SSL_SESSION_cmp;
  If @f_SSL_SESSION_print_fp=nil Then result := result + ' ' + fn_SSL_SESSION_print_fp;
  If @f_SSL_SESSION_print=nil Then result := result + ' ' + fn_SSL_SESSION_print;
  If @f_SSL_SESSION_free=nil Then result := result + ' ' + fn_SSL_SESSION_free;
  If @f_i2d_SSL_SESSION=nil Then result := result + ' ' + fn_i2d_SSL_SESSION;
  If @f_SSL_set_session=nil Then result := result + ' ' + fn_SSL_set_session;
  If @f_SSL_CTX_add_session=nil Then result := result + ' ' + fn_SSL_CTX_add_session;
  If @f_SSL_CTX_remove_session=nil Then result := result + ' ' + fn_SSL_CTX_remove_session;
  If @f_d2i_SSL_SESSION=nil Then result := result + ' ' + fn_d2i_SSL_SESSION;
  If @f_SSL_get_peer_certificate=nil Then result := result + ' ' + fn_SSL_get_peer_certificate;
  If @f_SSL_get_peer_cert_chain=nil Then result := result + ' ' + fn_SSL_get_peer_cert_chain;
  If @f_SSL_CTX_get_verify_mode=nil Then result := result + ' ' + fn_SSL_CTX_get_verify_mode;
  If @f_SSL_CTX_get_verify_depth=nil Then result := result + ' ' + fn_SSL_CTX_get_verify_depth;
  If @f_SSL_CTX_set_verify=nil Then result := result + ' ' + fn_SSL_CTX_set_verify;
  If @f_SSL_CTX_set_verify_depth=nil Then result := result + ' ' + fn_SSL_CTX_set_verify_depth;
  If @f_SSL_CTX_set_cert_verify_callback=nil Then result := result + ' ' + fn_SSL_CTX_set_cert_verify_callback;
  If @f_SSL_CTX_use_RSAPrivateKey=nil Then result := result + ' ' + fn_SSL_CTX_use_RSAPrivateKey;
  If @f_SSL_CTX_use_RSAPrivateKey_ASN1=nil Then result := result + ' ' + fn_SSL_CTX_use_RSAPrivateKey_ASN1;
  If @f_SSL_CTX_use_PrivateKey=nil Then result := result + ' ' + fn_SSL_CTX_use_PrivateKey;
  If @f_SSL_CTX_use_PrivateKey_ASN1=nil Then result := result + ' ' + fn_SSL_CTX_use_PrivateKey_ASN1;
  If @f_SSL_CTX_use_certificate=nil Then result := result + ' ' + fn_SSL_CTX_use_certificate;
  If @f_SSL_CTX_use_certificate_ASN1=nil Then result := result + ' ' + fn_SSL_CTX_use_certificate_ASN1;
  If @f_SSL_CTX_set_default_passwd_cb=nil Then result := result + ' ' + fn_SSL_CTX_set_default_passwd_cb;
  If @f_SSL_CTX_set_default_passwd_cb_userdata=nil Then result := result + ' ' + fn_SSL_CTX_set_default_passwd_cb_userdata;
  If @f_SSL_CTX_check_private_key=nil Then result := result + ' ' + fn_SSL_CTX_check_private_key;
  If @f_SSL_check_private_key=nil Then result := result + ' ' + fn_SSL_check_private_key;
  If @f_SSL_CTX_set_session_id_context=nil Then result := result + ' ' + fn_SSL_CTX_set_session_id_context;
  If @f_SSL_new=nil Then result := result + ' ' + fn_SSL_new;
  If @f_SSL_set_session_id_context=nil Then result := result + ' ' + fn_SSL_set_session_id_context;
  If @f_SSL_free=nil Then result := result + ' ' + fn_SSL_free;
  If @f_SSL_accept=nil Then result := result + ' ' + fn_SSL_accept;
  If @f_SSL_connect=nil Then result := result + ' ' + fn_SSL_connect;
  If @f_SSL_read=nil Then result := result + ' ' + fn_SSL_read;
  If @f_SSL_peek=nil Then result := result + ' ' + fn_SSL_peek;
  If @f_SSL_write=nil Then result := result + ' ' + fn_SSL_write;
  If @f_SSL_ctrl=nil Then result := result + ' ' + fn_SSL_ctrl;
  If @f_SSL_CTX_ctrl=nil Then result := result + ' ' + fn_SSL_CTX_ctrl;
  If @f_SSL_get_error=nil Then result := result + ' ' + fn_SSL_get_error;
  If @f_SSL_get_version=nil Then result := result + ' ' + fn_SSL_get_version;
  If @f_SSL_CTX_set_ssl_version=nil Then result := result + ' ' + fn_SSL_CTX_set_ssl_version;
  If @f_SSLv2_method=nil Then result := result + ' ' + fn_SSLv2_method;
  If @f_SSLv2_server_method=nil Then result := result + ' ' + fn_SSLv2_server_method;
  If @f_SSLv2_client_method=nil Then result := result + ' ' + fn_SSLv2_client_method;
  If @f_SSLv3_method=nil Then result := result + ' ' + fn_SSLv3_method;
  If @f_SSLv3_server_method=nil Then result := result + ' ' + fn_SSLv3_server_method;
  If @f_SSLv3_client_method=nil Then result := result + ' ' + fn_SSLv3_client_method;
  If @f_SSLv23_method=nil Then result := result + ' ' + fn_SSLv23_method;
  If @f_SSLv23_server_method=nil Then result := result + ' ' + fn_SSLv23_server_method;
  If @f_SSLv23_client_method=nil Then result := result + ' ' + fn_SSLv23_client_method;
  If @f_TLSv1_method=nil Then result := result + ' ' + fn_TLSv1_method;
  If @f_TLSv1_server_method=nil Then result := result + ' ' + fn_TLSv1_server_method;
  If @f_TLSv1_client_method=nil Then result := result + ' ' + fn_TLSv1_client_method;
  If @f_SSL_get_ciphers=nil Then result := result + ' ' + fn_SSL_get_ciphers;
  If @f_SSL_do_handshake=nil Then result := result + ' ' + fn_SSL_do_handshake;
  If @f_SSL_renegotiate=nil Then result := result + ' ' + fn_SSL_renegotiate;
  If @f_SSL_shutdown=nil Then result := result + ' ' + fn_SSL_shutdown;
  If @f_SSL_get_ssl_method=nil Then result := result + ' ' + fn_SSL_get_ssl_method;
  If @f_SSL_set_ssl_method=nil Then result := result + ' ' + fn_SSL_set_ssl_method;
  If @f_SSL_alert_type_string_long=nil Then result := result + ' ' + fn_SSL_alert_type_string_long;
  If @f_SSL_alert_type_string=nil Then result := result + ' ' + fn_SSL_alert_type_string;
  If @f_SSL_alert_desc_string_long=nil Then result := result + ' ' + fn_SSL_alert_desc_string_long;
  If @f_SSL_alert_desc_string=nil Then result := result + ' ' + fn_SSL_alert_desc_string;
  If @f_SSL_set_client_CA_list=nil Then result := result + ' ' + fn_SSL_set_client_CA_list;
  If @f_SSL_CTX_set_client_CA_list=nil Then result := result + ' ' + fn_SSL_CTX_set_client_CA_list;
  If @f_SSL_get_client_CA_list=nil Then result := result + ' ' + fn_SSL_get_client_CA_list;
  If @f_SSL_CTX_get_client_CA_list=nil Then result := result + ' ' + fn_SSL_CTX_get_client_CA_list;
  If @f_SSL_add_client_CA=nil Then result := result + ' ' + fn_SSL_add_client_CA;
  If @f_SSL_CTX_add_client_CA=nil Then result := result + ' ' + fn_SSL_CTX_add_client_CA;
  If @f_SSL_set_connect_state=nil Then result := result + ' ' + fn_SSL_set_connect_state;
  If @f_SSL_set_accept_state=nil Then result := result + ' ' + fn_SSL_set_accept_state;
  If @f_SSL_get_default_timeout=nil Then result := result + ' ' + fn_SSL_get_default_timeout;
  If @f_SSL_library_init=nil Then result := result + ' ' + fn_SSL_library_init;
  If @f_SSL_CIPHER_description=nil Then result := result + ' ' + fn_SSL_CIPHER_description;
  If @f_SSL_dup_CA_list=nil Then result := result + ' ' + fn_SSL_dup_CA_list;
  If @f_SSL_dup=nil Then result := result + ' ' + fn_SSL_dup;
  If @f_SSL_get_certificate=nil Then result := result + ' ' + fn_SSL_get_certificate;
  If @f_SSL_get_privatekey=nil Then result := result + ' ' + fn_SSL_get_privatekey;
  If @f_SSL_CTX_set_quiet_shutdown=nil Then result := result + ' ' + fn_SSL_CTX_set_quiet_shutdown;
  If @f_SSL_CTX_get_quiet_shutdown=nil Then result := result + ' ' + fn_SSL_CTX_get_quiet_shutdown;
  If @f_SSL_set_quiet_shutdown=nil Then result := result + ' ' + fn_SSL_set_quiet_shutdown;
  If @f_SSL_get_quiet_shutdown=nil Then result := result + ' ' + fn_SSL_get_quiet_shutdown;
  If @f_SSL_set_shutdown=nil Then result := result + ' ' + fn_SSL_set_shutdown;
  If @f_SSL_get_shutdown=nil Then result := result + ' ' + fn_SSL_get_shutdown;
  If @f_SSL_version=nil Then result := result + ' ' + fn_SSL_version;
  If @f_SSL_CTX_set_default_verify_paths=nil Then result := result + ' ' + fn_SSL_CTX_set_default_verify_paths;
  If @f_SSL_CTX_load_verify_locations=nil Then result := result + ' ' + fn_SSL_CTX_load_verify_locations;
  If @f_SSL_get_session=nil Then result := result + ' ' + fn_SSL_get_session;
  If @f_SSL_get_SSL_CTX=nil Then result := result + ' ' + fn_SSL_get_SSL_CTX;
  If @f_SSL_set_info_callback=nil Then result := result + ' ' + fn_SSL_set_info_callback;
  If @f_SSL_state=nil Then result := result + ' ' + fn_SSL_state;
  If @f_SSL_set_verify_result=nil Then result := result + ' ' + fn_SSL_set_verify_result;
  If @f_SSL_get_verify_result=nil Then result := result + ' ' + fn_SSL_get_verify_result;
  If @f_SSL_set_ex_data=nil Then result := result + ' ' + fn_SSL_set_ex_data;
  If @f_SSL_get_ex_data=nil Then result := result + ' ' + fn_SSL_get_ex_data;
  If @f_SSL_get_ex_new_index=nil Then result := result + ' ' + fn_SSL_get_ex_new_index;
  If @f_SSL_SESSION_set_ex_data=nil Then result := result + ' ' + fn_SSL_SESSION_set_ex_data;
  If @f_SSL_SESSION_get_ex_data=nil Then result := result + ' ' + fn_SSL_SESSION_get_ex_data;
  If @f_SSL_SESSION_get_ex_new_index=nil Then result := result + ' ' + fn_SSL_SESSION_get_ex_new_index;
  If @f_SSL_CTX_set_ex_data=nil Then result := result + ' ' + fn_SSL_CTX_set_ex_data;
  If @f_SSL_CTX_get_ex_data=nil Then result := result + ' ' + fn_SSL_CTX_get_ex_data;
  If @f_SSL_CTX_get_ex_new_index=nil Then result := result + ' ' + fn_SSL_CTX_get_ex_new_index;
  If @f_SSL_get_ex_data_X509_STORE_CTX_idx=nil Then result := result + ' ' + fn_SSL_get_ex_data_X509_STORE_CTX_idx;
  If @f_SSL_CTX_set_tmp_rsa_callback=nil Then result := result + ' ' + fn_SSL_CTX_set_tmp_rsa_callback;
  If @f_SSL_set_tmp_rsa_callback=nil Then result := result + ' ' + fn_SSL_set_tmp_rsa_callback;
  If @f_SSL_CTX_set_tmp_dh_callback=nil Then result := result + ' ' + fn_SSL_CTX_set_tmp_dh_callback;
  If @f_SSL_set_tmp_dh_callback=nil Then result := result + ' ' + fn_SSL_set_tmp_dh_callback;
  If @f_SSL_COMP_add_compression_method=nil Then result := result + ' ' + fn_SSL_COMP_add_compression_method;
  If @f_SSLeay_add_ssl_algorithms=nil Then result := result + ' ' + fn_SSLeay_add_ssl_algorithms;
  If @f_SSL_set_app_data=nil Then result := result + ' ' + fn_SSL_set_app_data;
  If @f_SSL_get_app_data=nil Then result := result + ' ' + fn_SSL_get_app_data;
  If @f_SSL_CTX_set_info_callback=nil Then result := result + ' ' + fn_SSL_CTX_set_info_callback;
  If @f_SSL_CTX_set_options=nil Then result := result + ' ' + fn_SSL_CTX_set_options;
  If @f_SSL_is_init_finished=nil Then result := result + ' ' + fn_SSL_is_init_finished;
  If @f_SSL_in_init=nil Then result := result + ' ' + fn_SSL_in_init;
  If @f_SSL_in_before=nil Then result := result + ' ' + fn_SSL_in_before;
  If @f_SSL_in_connect_init=nil Then result := result + ' ' + fn_SSL_in_connect_init;
  If @f_SSL_in_accept_init=nil Then result := result + ' ' + fn_SSL_in_accept_init;
  If @f_X509_STORE_CTX_get_app_data=nil Then result := result + ' ' + fn_X509_STORE_CTX_get_app_data;
  If @f_X509_get_notBefore=nil Then result := result + ' ' + fn_X509_get_notBefore;
  If @f_X509_get_notAfter=nil Then result := result + ' ' + fn_X509_get_notAfter;
  If @f_UCTTimeDecode=nil Then result := result + ' ' + fn_UCTTimeDecode;
  If @f_SSL_CTX_get_version=nil Then result := result + ' ' + fn_SSL_CTX_get_version;
  If @f_SSL_SESSION_get_id=nil Then result := result + ' ' + fn_SSL_SESSION_get_id;
  If @f_SSL_SESSION_get_id_ctx=nil Then result := result + ' ' + fn_SSL_SESSION_get_id_ctx;
  If @f_fopen=nil Then result := result + ' ' + fn_fopen;
  If @f_fclose=nil Then result := result + ' ' + fn_fclose;

  {$ENDIF}
 End;
End;

initialization
finalization
  Unload;
end.




