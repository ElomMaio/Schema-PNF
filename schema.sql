from sqlalchemy import create_engine, Column, Integer, String, Sequence, ForeignKey, Date, DateTime, Boolean
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

engine = create_engine("postgresql://elom:123456@192.168.1.194/desafio-pbi-nuvem-db-1", echo=True)

class Base(DeclarativeBase):
    pass

class Forms(Base):
    __tablename__ = "forms"
    uuid_form: Mapped[str] = mapped_column(primary_key=True)
    id_form: Mapped[str] = mapped_column()
    tp_form: Mapped[str] = mapped_column()

class DadosFiscalizacao(Base):
    __tablename__ = "dados_fiscalizacao"
    id_relatorio: Mapped[str] = mapped_column(primary_key=True)
    data_fiscalizacao: Mapped[Date] = mapped_column(nullable=False)
    hora_inicio: Mapped[DateTime] = mapped_column(nullable=False)
    hora_fim: Mapped[DateTime] = mapped_column(nullable=False)
    data_escrita: Mapped[str] = mapped_column(nullable=False)  # Alterado para str
    registro: Mapped[bool] = mapped_column(nullable=False)
    art: Mapped[str] = mapped_column(nullable=False)
    possui_vetzoo: Mapped[bool] = mapped_column(nullable=False)
    lavratura_igual: Mapped[bool] = mapped_column(nullable=False)
    gera_tcpj: Mapped[bool] = mapped_column(nullable=False)
    gera_tcpf: Mapped[bool] = mapped_column(nullable=False)
    gera_ai_art: Mapped[bool] = mapped_column(nullable=False)
    gera_ai_registro: Mapped[bool] = mapped_column(nullable=False)
    gera_ai_comerciovacina: Mapped[bool] = mapped_column(nullable=False)
    gera_ai_outros: Mapped[bool] = mapped_column(nullable=False)
    uuid_form: Mapped[str] = mapped_column(ForeignKey("forms.uuid_form", ondelete="CASCADE"), nullable=False)

class TblClasses(Base):
    __tablename__ = "tbl_classes"
    classe: Mapped[str] = mapped_column(primary_key=True)
    label_classe: Mapped[str] = mapped_column()

class TblAtividades(Base):
    __tablename__ = "tbl_atividades"
    
    tipo_atividade: Mapped[str] = mapped_column(primary_key=True)
    label_atividade: Mapped[str] = mapped_column(nullable=False)
    classe: Mapped[str] = mapped_column(ForeignKey("tbl_classes.classe"), nullable=False)
    art_obrigatorio: Mapped[bool] = mapped_column(nullable=False)
    registro_obrigatorio: Mapped[bool] = mapped_column(nullable=False)
    fundamento_legal_art: Mapped[str] = mapped_column(nullable=False)
    fundamento_legal_registro: Mapped[str] = mapped_column(nullable=False)

class AtividadeMv(Base):
    __tablename__ = "atividade_mv"

    id_atividade_mv: Mapped[int] = mapped_column(Integer, Sequence("id_atividade_mv_seq"), primary_key=True)
    tipo_atividade: Mapped[str] = mapped_column(ForeignKey("tbl_atividades.tipo_atividade"), nullable=False)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    atividade_outro: Mapped[str] = mapped_column(nullable=False)

class TblSefis(Base):
    __tablename__ = "tbl_sefis"
    matricula: Mapped[str] = mapped_column(primary_key=True)
    nome: Mapped[str] = mapped_column(nullable=False)
    cargo: Mapped[str] = mapped_column(nullable=False)
    email: Mapped[str] = mapped_column(nullable=False)

class FiscaisAtv(Base):
    __tablename__ = "id_fiscais_atv"
    id_fiscais_atv: Mapped[int] = mapped_column(Integer, Sequence('id_fiscais_atv_seq'), primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    matricula: Mapped[str] = mapped_column(ForeignKey("tbl_sefis.matricula"), nullable=False)
    nome: Mapped[str] = mapped_column(nullable=False)
    cargo: Mapped[str] = mapped_column(nullable=False)
    img_assinatura: Mapped[str] = mapped_column(nullable=False)

class Estabelecimento(Base):
    __tablename__ = "estabelecimentos"
    id_estabelecimento: Mapped[int] = mapped_column(Integer, Sequence("id_estabelecimento"), primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    est_crmv: Mapped[str] = mapped_column(nullable=False)
    est_razsoc: Mapped[str] = mapped_column(nullable=False)
    est_cpf_cnpj: Mapped[str] = mapped_column(nullable=False)
    est_local: Mapped[str] = mapped_column(nullable=False)
    est_bairro: Mapped[str] = mapped_column(nullable=False)
    est_cidade: Mapped[str] = mapped_column(nullable=False)
    est_uf: Mapped[str] = mapped_column(nullable=False)
    est_cep: Mapped[str] = mapped_column(nullable=False)
    contato_email: Mapped[str] = mapped_column(nullable=False)
    contato_telcel: Mapped[str] = mapped_column(nullable=False)
    latitude: Mapped[str] = mapped_column(nullable=False)
    longitude: Mapped[str] = mapped_column(nullable=False)

class DadosLavraturas(Base):
    __tablename__ = "dados_lavraturas"
    id_lavratura: Mapped[int] = mapped_column(Integer, Sequence("id_lavratura"), primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    cep: Mapped[str] = mapped_column(nullable=False)
    logradouro: Mapped[str] = mapped_column(nullable=False)
    bairro: Mapped[str] = mapped_column(nullable=False)
    cidade: Mapped[str] = mapped_column(nullable=False)
    uf: Mapped[str] = mapped_column(nullable=False)

class SociosProprietarios(Base):
    __tablename__ = "socios_proprietarios"
    id_socio: Mapped[int] = mapped_column(Integer, Sequence("id_socio"), primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    socio_nome: Mapped[str] = mapped_column(nullable=False)
    socio_endereco: Mapped[str] = mapped_column(nullable=False)

class Testemunhas(Base):
    __tablename__ = "testemunhas"
    id_testemunha: Mapped[int] = mapped_column(Integer, Sequence("id_testemunha"), primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    nome: Mapped[str] = mapped_column(nullable=False)
    documento: Mapped[str] = mapped_column(nullable=False)
    img_assinatura: Mapped[str] = mapped_column(nullable=False)
    negou_assinar: Mapped[bool] = mapped_column(nullable=False)

class RecursosHumanos(Base):
    __tablename__ = "recursos_humanos"
    id_recurso_humano: Mapped[int] = mapped_column(Integer, Sequence("id_recurso_humano"), primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    nome: Mapped[str] = mapped_column(nullable=False)
    crmv_pf: Mapped[str] = mapped_column(nullable=False)
    uf: Mapped[str] = mapped_column(nullable=False)
    funcao: Mapped[str] = mapped_column(nullable=False)
    formacao: Mapped[str] = mapped_column(nullable=False)
    resp_tecnico: Mapped[bool] = mapped_column(nullable=False)

class tbl_ras(Base):
    id_ra: Mapped[int] = mapped_column(Integer, Sequence("id_ra"), primary_key=True)
    regiao: Mapped[str] = mapped_column(nullable=False)

class tbl_municipios(Base):
    geocodigo: Mapped[str] = mapped_column(String(10),primary_key=True)
    municipio: Mapped[str] = mapped_column(nullable=False)
    ra: Mapped[int] = mapped_column(ForeignKey("tbl_ras.id_ra",ondelete="CASCADE"), nullable=False)

class espacial_fiscalizacoes(Base):
    id_espacial: Mapped[str] = mapped_column(Integer, Sequence("id_espacial"), primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    geocodigo: Mapped[str] = mapped_column(ForeignKey("tbl_municipios.geocodigo", ondelete="CASCADE"), nullable=False)
    id_ra: Mapped[int] = mapped_column(ForeignKey("tbl_ras.id_ra", ondelete="CASCADE"), nullable=False)
    data: Mapped[date] = mapped_column(nullable=False)
    latitude: Mapped[str] = mapped_column(nullable=False)
    longitude: Mapped[str] = mapped_column(nullable=False)   

class tbl_docs(Base):
    doc_tipo: Mapped[str] = mapped_column(String(10),primary_key=True)
    label_doc: Mapped[str] = mapped_column(nullable=True)

class termo_constatacao(Base):
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    id_tcpj: Mapped[str] = mapped_column(String(400),primary_key=True)
    doc_tipo: Mapped[str] = mapped_column(ForeignKey("tbl_docs.doc_tipo"),nullable=False)

class tbl_tcpj(Base):
    constatacoes_tabeladas: Mapped[str] = mapped_column(String(3),primary_key=True)
    label_constatacao: Mapped[str] = mapped_column(nullable=False)

class termo_constatacao_pj_tb(Base):
    id_tcpj_tb: Mapped[int] = mapped_column(Integer, Sequence("id_tcpj_tb"),primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    id_tcpj: Mapped[str] = mapped_column(ForeignKey("termo_constatacao.id_tcpj", ondelete="CASCADE"), nullable=False)
    constatacoes_tabeladas:Mapped[str] = mapped_column(ForeignKey("tbl_tcpj.constatacoes_tabeladas"),nullable=False)

class termo_constatacao_pj_adc(Base):
    id_tcpj_adc: Mapped[int] = mapped_column(Integer, Sequence("id_tcpj_adc"),primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    id_tcpj: Mapped[str] = mapped_column(ForeignKey("termo_constatacao.id_tcpj", ondelete="CASCADE"), nullable=False)
    constatacoes_adicionais: Mapped[str] = mapped_column(nullable=False)

class termo_constatacao_pj_dt(Base):
    id_tcpj_dt: Mapped[int] = mapped_column(Integer, Sequence("id_tcpj_dt"),primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    id_tcpj: Mapped[str] = mapped_column(ForeignKey("termo_constatacao.id_tcpj", ondelete="CASCADE"), nullable=False)
    constatacoes: Mapped[str] = mapped_column(nullable=False)

class termo_constatacao_pf(Base):
    id_tcpf: Mapped[int] = mapped_column(Integer(400)primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    doc_tipo: Mapped[str] = mapped_column(ForeignKey("tbl_docs.doc_tipo", ondelete="CASCADE"), nullable=False)

class termo_constatacao_pf_dt(Base):
    id_tcpf_dt: Mapped[int] = mapped_column(Integer, Sequence("id_tcpj_dt"),primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    id_tcpf: Mapped[str] = mapped_column(ForeignKey("termo_constatacao_pf.id_tcpf", ondelete="CASCADE"), nullable=False)
    nome: Mapped[str] = mapped_column(nullable=False)
    documento: Mapped[str] = mapped_column(nullable=False)
    img_assinatura: Mapped[str] = mapped_column(String(400), nullable=False)
    negou_assinar: Mapped[bool] = mapped_column(nullable=True)
    contato_email: Mapped[str] = mapped_column(String(40), nullable=False)
    constatacao: Mapped[str] = mapped_column(nullable=True)

class termo_fiscalizacao(Base):
    id_relatorio: Mapped[str] = mapped_column(String(200),ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    id_tf: Mapped[str] = mapped_column(Integer(400),primary_key=True)
    label_tf: Mapped[str] = mapped_column(nullable=False)
    doc_tipo: Mapped[str] = mapped_column(String(2),ForeignKey("tbl_docs.doc_tipo", ondelete="CASCADE"), nullable=False)

class tbl_aiam_situacoes(Base):
    tipo_situacao: Mapped[str] = mapped_column(String(4),primary_key=True)
    label_situacao: Mapped[str] = mapped_column(nullable=False)
    doc_tipo: Mapped[str] = mapped_column(String(2),ForeignKey("tbl_docs.doc_tipo", ondelete="CASCADE"), nullable=False)

class auto_infracao(Base):
    id_relatorio: Mapped[str] = mapped_column(String(200),ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    id_ai: Mapped[str] = mapped_column(String(400),primary_key=True)
    ai_rt: Mapped[bool] = mapped_column(nullable=False)
    ai_registro: Mapped[bool] = mapped_column(nullable=False)
    ai_comerciovacina: Mapped[bool] = mapped_column(nullable=False)
    ai_outros: Mapped[bool] = mapped_column(nullable=False)
    ai_outros_funcionamento: Mapped[str] = mapped_column(nullable=False)
    doc_tipo: Mapped[str] = mapped_column(String(2),ForeignKey("tbl_docs.doc_tipo", ondelete="CASCADE"), nullable=False)

class auto_infracao_situacao(Base):
    id_ai_situacao: Mapped[int] = mapped_column(Integer, Sequence("id_ai_situacao"),primary_key=True)
    id_ai: Mapped[int] = mapped_column(Integer(400),ForeignKey("auto_infracao.id_ai", ondelete="CASCADE"), nullable=False)
    data_atualizacao: Mapped[Date] = mapped_column(nullable=False)
    rt_regular: Mapped[bool] = mapped_column(nullable=False)
    registro_regular: Mapped[bool] = mapped_column(nullable=False)
    tipo_situacao: Mapped[str] = mapped_column(Integer(400),ForeignKey("tbl_aiam_situacoes.tipo_situacao"), nullable=False)

class autos_forms_indices(Base):
    id_indices: Mapped[int] = mapped_column(Integer, Sequence("id_indices"),primary_key=True)
    cod_form: Mapped[int] = mapped_column(nullable=False)
    id_auto: Mapped[int] = mapped_column(nullable=False)
    tipo_documento: Mapped[int] = mapped_column(nullable=False)

class auto_multas(Base):
    id_am: Mapped[int] = mapped_column(Integer,primary_key=True)
    id_ai: Mapped[int] = mapped_column(Integer(400),ForeignKey("auto_infracao.id_ai"),nullable=False)
    tipo_multa: Mapped[int] = mapped_column(Integer(4),ForeignKey("tbl_aiam_situacoes.tipo_situacao"),nullable=False)
    situacao_multa: Mapped[int] = mapped_column(Integer(4),ForeignKey("tbl_aiam_situacoes.tipo_situacao"),nullable=False)
    valor_multa: Mapped[float] = mapped_column(Float,nullable=False)
    data_prazo: Mapped[Date] = mapped_column(nullable=False)
    doc_tipo: Mapped[str] = mapped_column(String(2),ForeignKey("tbl_docs.doc_tipo"), nullable=False)
    codigo_boleto: Mapped[str] = mapped_column(nullable=False)

class multas_autuados(Base):
    id_multa_autuado: Mapped[int] = mapped_column(Integer(400),Sequence("id_multa_autuado"),primary_key=True)
    id_am: Mapped[int] = mapped_column(Integer(400),ForeignKey("auto_multas.id_am"),nullable=False)
    raz_soc: Mapped[str] = mapped_column(nullable=False)
    cpf_cnpj: Mapped[str] = mapped_column(nullable=False)
    logradouro: Mapped[str] = mapped_column(nullable=False)
    bairro: Mapped[str] = mapped_column(nullable=False)
    cidade: Mapped[str] = mapped_column(nullable=False)
    uf: Mapped[str] = mapped_column(nullable=False)
    cep: Mapped[str] = mapped_column(nullable=False)
    coresp_1: Mapped[str] = mapped_column(nullable=False)
    cpf_coresp_1: Mapped[str] = mapped_column(nullable=False)
    email_coresp_1: Mapped[str] = mapped_column(nullable=False)
    coresp_2: Mapped[str] = mapped_column(nullable=False)
    cpf_coresp_2: Mapped[str] = mapped_column(nullable=False)
    email_coresp_2: Mapped[str] = mapped_column(nullable=False)
    email_contato: Mapped[str] = mapped_column(nullable=False)

class multas_documentos(Base):
    id_multa_documento: Mapped[int] = mapped_column(Integer,Sequence("id_multa_documento"),primary_key=True)
    id_am: Mapped[int] = mapped_column(Integer(400),ForeignKey("auto_multas.id_am"),ondelete = "CASCADE",nullable=False)
    multa_gerada: Mapped[bool] = mapped_column(nullable=False)
    multa_enviada: Mapped[bool] = mapped_column(nullable=False)
    multa_enviada_destino: Mapped[bool] = mapped_column(nullable=False)

class tbl_tos(Base):
    to_tipo: Mapped[int] = mapped_column(nullable=False)
    to_label: Mapped[int] = mapped_column(nullable=False)

class termos_orientacao(Base):
   id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
   id_to: Mapped[str] = mapped_column(Integer, primary_key=True)
   descricao: Mapped[str] = mapped_column(nullable=False)
   orientacao: Mapped[str] = mapped_column(nullable=False)
   prazo: Mapped[int] = mapped_column(nullable=False)
   doc_tipo: Mapped[str] = mapped_column(ForeignKey("tbl_docs.doc_tipo"),nullable=False)

class imagens_enderecos(Base):
    id_imagem_relatorio: Mapped[int] = mapped_column(Integer,Sequence("id_imagem_relatorio"), primary_key=False)
    uuid_form: Mapped[str] = mapped_column(ForeignKey("forms.uuid_form"), nullable=False)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    arquivo_imagem: Mapped[str] = mapped_column(nullable=False)
    url_imagem: Mapped[str] = mapped_column(nullable=False)
    situacao: Mapped[str] = mapped_column(nullable=False)
    dir_caminho: Mapped[str] = mapped_column(nullable=False)

class imagens_fiscalizacao(Base):
    id_imagem_fiscalizacao: Mapped[int] = mapped_column(Integer,Sequence("id_imagem_relatorio"), primary_key=False)
    uuid_form: Mapped[str] = mapped_column(ForeignKey("forms.uuid_form",ondelete="CASCADE"), nullable=False)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    arquivo_imagem: Mapped[str] = mapped_column(nullable=False)
    label_imagem: Mapped[str] = mapped_column(nullable=False)
    
class relatorios_gerados(Base):
    id_relatorio_gerado: Mapped[int] = mapped_column(Integer, Sequence("id_relatorio_gerado"),primary_key=True)
    id_relatorio: Mapped[str] = mapped_column(ForeignKey("dados_fiscalizacao.id_relatorio", ondelete="CASCADE"), nullable=False)
    uuid_form: Mapped[str] = mapped_column(ForeignKey("forms.uuid_form",ondelete="CASCADE"), nullable=False)
    situacao: Mapped[str] = mapped_column(String(1),nullable=False)
    modelo: Mapped[str] = mapped_column(String(20),nullable=False)
    dir_caminho: Mapped[str] = mapped_column(nullable=False)
    modelo: Mapped[str] = mapped_column(String(100),nullable=False)
    
