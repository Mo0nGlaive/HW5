class Alphabet():
	def __init__(self, lang="lang", letters=""):
		self.lang = lang
		self.letters = letters
	
	def print(self):
		print(self.letters)
	
	def letters_num(self):
		return len(self.letters)

class EngAlphabet(Alphabet):
	def __init__(self):
		super().__init__("En", "abcdefghijklmnopqrtsyvwxyz")
		
	__letters_num = 26
	
	def is_en_letter(self, letter):
		if letter.lower() in self.letters:
			print(f"Alphabet contains {letter}")
		else:
			print(f"Alphabet doesn't contains {letter}")
	
	def letters_num(self):
		return self.__letters_num
	
	@staticmethod
	def example():
		print("This is an example of text in English")


EnAlph = EngAlphabet()

EnAlph.print()
print(EnAlph.letters_num())
EnAlph.is_en_letter("F")
EnAlph.is_en_letter("Щ")

EngAlphabet.example()
EnAlph.example()
