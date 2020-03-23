package server;

import java.security.MessageDigest;

public class Password {
        private static final String KEY_MD5 = "MD5";
        // ȫ������
        private static final String[] strDigits = { "0", "1", "2", "3", "4", "5",
                "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };

        // ������ʽΪ���ָ��ַ���
        private static String byteToArrayString(byte bByte) {
            int iRet = bByte;
            if (iRet < 0) {
                iRet += 256;
            }
            int iD1 = iRet / 16;
            int iD2 = iRet % 16;
            return strDigits[iD1] + strDigits[iD2];
        }

        // ת���ֽ�����Ϊ16�����ִ�
        private static String byteToString(byte[] bByte) {
            StringBuffer sBuffer = new StringBuffer();
            for (int i = 0; i < bByte.length; i++) {
                sBuffer.append(byteToArrayString(bByte[i]));
            }
            return sBuffer.toString();
        }
        /**
         * MD5����
         * @param strObj
         * @return
         * @throws Exception
         */
        public static String GetMD5Code(String strObj) throws Exception{
            MessageDigest md = MessageDigest.getInstance(KEY_MD5);
            // md.digest() �ú�������ֵΪ��Ź�ϣֵ�����byte����
            return byteToString(md.digest(strObj.getBytes()));
        }

    }
