from langchain_community.document_loaders import TextLoader
from langchain_text_splitters import RecursiveCharacterTextSplitter
import os

caminho_arquivo = r"usando API do google\data\dados_empresa.txt"

loader = TextLoader(caminho_arquivo, encoding="utf-8")
documentos = loader.load()


# conteudo = documentos[0].page_content
# print("\n🔍 Trecho do conteúdo (primeiros 300 caracteres):")
# print(conteudo[:300] + "..." if len(conteudo) > 300 else conteudo)

print("\n✂️ Dividindo em partes menores...")
text_splitter = RecursiveCharacterTextSplitter(
    chunk_size=800,      # tamanho máximo de cada parte
    chunk_overlap=100,   # sobreposição para manter contexto
    length_function=len,
    separators=["\n\n", "\n", ". ", " ", ""]
)

chunks = text_splitter.split_documents(documentos)

print(f"✅ Total de chunks gerados: {len(chunks)}")

# Mostra os primeiros 2 chunks como exemplo
for i, chunk in enumerate(chunks[:2]):
    print(f"\n📄 Chunk {i+1}:")
    print("-" * 40)
    print(chunk.page_content[:200] + "..." if len(chunk.page_content) > 200 else chunk.page_content)