package com.adams.scrum.utils
{
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import mx.utils.SHA256;
	
	public class DecryptionKeyGenerator
	{
		// ------- Constants -------
		public static const PASSWORD_ERROR_ID:uint = 3138;
		
		private static const STRONG_PASSWORD_PATTERN:RegExp = /(?=^.{8,32}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/;		
		
		// ------- Constructor -------
		public function DecryptionKeyGenerator()
		{
		}
		
		
		// ------- Public methods -------
		public function validateStrongPassword(password:String):Boolean
		{
			if (password == null || password.length <= 0)
			{
				return false;
			}
			
			return STRONG_PASSWORD_PATTERN.test(password);
		}
		
		
		public function getEncryptionKey(password:String):ByteArray
		{
			
			if (!validateStrongPassword(password))
			{
				throw new ArgumentError("The password must be a strong password. It must be 8-32 characters long. It must contain at least one uppercase letter, at least one lowercase letter, and at least one number or symbol.");
			}
			
			var concatenatedPassword:String = concatenatePassword(password);
			
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTF(concatenatedPassword);
			
			var hashedKey:String = SHA256.computeDigest(bytes);
			
			trace(hashedKey);
			
			var encryptionKey:ByteArray = generateEncryptionKey(hashedKey);
			
			return encryptionKey;
		}
		
		
		// ------- Creating encryption key -------
		
		private function concatenatePassword(pwd:String):String
		{
			var len:int = pwd.length;
			var targetLength:int = 32;
			
			if (len == targetLength)
			{
				return pwd;
			}
			
			var repetitions:int = Math.floor(targetLength / len);
			var excess:int = targetLength % len;
			
			var result:String = "";
			
			for (var i:uint = 0; i < repetitions; i++)
			{
				result += pwd;
			}
			
			result += pwd.substr(0, excess);
			
			return result;
		}
		
		
		
		public function generateEncryptionKey(hash:String):ByteArray
		{
			var result:ByteArray = new ByteArray();
			
			// select a range of 128 bits (32 hex characters) from the hash
			// In this case, we'll use the bits starting from position 17
			for (var i:uint = 0; i < 32; i += 2)
			{
				var position:uint = i + 17;
				var hex:String = hash.substr(position, 2);
				var byte:int = parseInt(hex, 16);
				result.writeByte(byte);
			}
			
			return result;
		}
	}
}