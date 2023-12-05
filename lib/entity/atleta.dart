import 'package:desafio_6_etapa/entity/telefone.dart';
import 'package:desafio_6_etapa/entity/tipo_usuario.dart';
import 'package:desafio_6_etapa/entity/usuario.dart';

class Atleta extends Usuario {
  DateTime _dataNascimento;
  String _naturalidade;
  String _nacionalidade;
  String _rg;
  String _cpf;
  String _sexo;
  String _endereco;
  String _bairro;
  String _cep;
  String _cidade;
  String _estado;
  String? _nomeMae;
  String? _nomePai;
  String? _clubeOrigem;
  String? _empresaTrabalha;
  String _cvm;
  String? _alg; // Alergia
  String _est;
  String _pvr;
  dynamic _atestado;
  dynamic _fotoRg;
  dynamic _fotoCpf;
  dynamic _fotoAtleta;
  dynamic _fotoCompRes;
  dynamic _regulamento;
  List<Telefone> _telefones;

  Atleta({
    required String? id,
    required String nome,
    required String email,
    required TipoUsuario tipoUsuario,
    required DateTime dataNascimento,
    required String naturalidade,
    required String nacionalidade,
    required String rg,
    required String cpf,
    required String sexo,
    required String endereco,
    required String bairro,
    required String cep,
    required String cidade,
    required String estado,
    String? nomeMae,
    String? nomePai,
    String? clubeOrigem,
    String? empresaTrabalha,
    required String cvm,
    String? alg,
    required String est,
    required String pvr,
    dynamic atestado,
    dynamic fotoRg,
    dynamic fotoCpf,
    dynamic fotoAtleta,
    dynamic fotoCompRes,
    dynamic regulamento,
    required List<Telefone> telefones,
  })  : _dataNascimento = dataNascimento,
        _naturalidade = naturalidade,
        _nacionalidade = nacionalidade,
        _rg = rg,
        _cpf = cpf,
        _sexo = sexo,
        _endereco = endereco,
        _bairro = bairro,
        _cep = cep,
        _cidade = cidade,
        _estado = estado,
        _nomeMae = nomeMae,
        _nomePai = nomePai,
        _clubeOrigem = clubeOrigem,
        _empresaTrabalha = empresaTrabalha,
        _cvm = cvm,
        _alg = alg,
        _est = est,
        _pvr = pvr,
        _atestado = atestado,
        _fotoRg = fotoRg,
        _fotoCpf = fotoCpf,
        _fotoAtleta = fotoAtleta,
        _fotoCompRes = fotoCompRes,
        _regulamento = regulamento,
        _telefones = telefones,
        super(
          id: id,
          nome: nome,
          email: email,
          tipoUsuario: TipoUsuario.ATLETA,
        );

  DateTime get dataNascimento => _dataNascimento;

  Map<String, dynamic> toJson() {
    return {
      'dataNascimento': dataNascimento.toIso8601String(),
      'naturalidade': naturalidade,
      'nacionalidade': nacionalidade,
      'rg': rg,
      'cpf': cpf,
      'sexo': sexo,
      'endereco': endereco,
      'bairro': bairro,
      'cep': cep,
      'cidade': cidade,
      'estado': estado,
      'nomeMae': nomeMae,
      'nomePai': nomePai,
      'clubeOrigem': clubeOrigem,
      'empresaTrabalha': empresaTrabalha,
      'cvm': cvm,
      'alg': alg,
      'est': est,
      'pvr': pvr,
      'telefones': telefones,
      'primeiroAcesso': false,
      'fotoRg': fotoRg,
      'fotoCpf': fotoCpf,
      'fotoAtleta': fotoAtleta,
      'fotoComprovanteResidencia': fotoCompRes,
      'fotoAtestado': atestado
    };
  }

  set dataNascimento(DateTime value) {
    _dataNascimento = value;
  }

  String get naturalidade => _naturalidade;

  set naturalidade(String value) {
    _naturalidade = value;
  }

  String get nacionalidade => _nacionalidade;

  set nacionalidade(String value) {
    _nacionalidade = value;
  }

  String get rg => _rg;

  set rg(String value) {
    _rg = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get sexo => _sexo;

  set sexo(String value) {
    _sexo = value;
  }

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;
  }

  String get cep => _cep;

  set cep(String value) {
    _cep = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String? get nomeMae => _nomeMae;

  set nomeMae(String? value) {
    _nomeMae = value;
  }

  String? get nomePai => _nomePai;

  set nomePai(String? value) {
    _nomePai = value;
  }

  String? get clubeOrigem => _clubeOrigem;

  set clubeOrigem(String? value) {
    _clubeOrigem = value;
  }

  String? get empresaTrabalha => _empresaTrabalha;

  set empresaTrabalha(String? value) {
    _empresaTrabalha = value;
  }

  String get cvm => _cvm;

  set cvm(String value) {
    _cvm = value;
  }

  String? get alg => _alg;

  set alg(String? value) {
    _alg = value;
  }

  String get est => _est;

  set est(String value) {
    _est = value;
  }

  String get pvr => _pvr;

  set pvr(String value) {
    _pvr = value;
  }

  dynamic get atestado => _atestado;

  set atestado(dynamic value) {
    _atestado = value;
  }

  dynamic get fotoRg => _fotoRg;

  set fotoRg(dynamic value) {
    _fotoRg = value;
  }

  dynamic get fotoCpf => _fotoCpf;

  set fotoCpf(dynamic value) {
    _fotoCpf = value;
  }

  dynamic get fotoAtleta => _fotoAtleta;

  set fotoAtleta(dynamic value) {
    _fotoAtleta = value;
  }

  dynamic get fotoCompRes => _fotoCompRes;

  set fotoCompRes(dynamic value) {
    _fotoCompRes = value;
  }

  dynamic get regulamento => _regulamento;

  set regulamento(dynamic value) {
    _regulamento = value;
  }

  List<Telefone> get telefones => _telefones;

  set telefones(List<Telefone> value) {
    _telefones = value;
  }
}
