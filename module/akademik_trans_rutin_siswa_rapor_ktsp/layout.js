/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_akademik_trans_rutin_siswa_rapor_ktsp;
var m_akademik_trans_rutin_siswa_rapor_ktsp_master;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_catatan_dan_absensi;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_agama;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_kewarganegaraan;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_bahasa_indonesia;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_bahasa_inggris;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_matematika;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_ipa;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_ips;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_seni_budaya;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_jasmani_dan_kesehatan;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_keterampilan_tangan_dan_kesenian;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_teknologi_informasi_dan_komunikasi;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_muatan_lokal;
var m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pengembangan_diri;
var m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran = '';
var m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas = '';
var m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel = '';
var m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar = '';
var m_akademik_trans_rutin_siswa_rapor_ktsp_d = _g_root +'/module/akademik_trans_rutin_siswa_rapor_ktsp/';
var m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level = 0;

function m_akademik_trans_rutin_siswa_rapor_ktsp_master_on_select_load_detail()
{
 	if (typeof m_akademik_trans_rutin_siswa_rapor_ktsp_master == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_catatan_dan_absensi == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_agama == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_kewarganegaraan == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_bahasa_indonesia == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_bahasa_inggris == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_matematika == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_ipa == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_ips == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_seni_budaya == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_jasmani_dan_kesehatan == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_keterampilan_tangan_dan_kesenian == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_teknologi_informasi_dan_komunikasi == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_muatan_lokal == 'undefined'
	||  typeof m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pengembangan_diri == 'undefined'
	||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran == ''
	||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas == ''
	||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel == ''
	||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar == '') {
		return;
	}

	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_catatan_dan_absensi.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_agama.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_kewarganegaraan.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_bahasa_indonesia.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_bahasa_inggris.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_matematika.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_ipa.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_ips.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_seni_budaya.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_jasmani_dan_kesehatan.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_keterampilan_tangan_dan_kesenian.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_teknologi_informasi_dan_komunikasi.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_muatan_lokal.do_refresh();
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pengembangan_diri.do_refresh();
}

function M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRapor(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_siswa' }
		,	{ name	: 'id_ahlak' }
		,	{ name	: 'id_pribadi' }
		,	{ name	: 'sakit' }
		,	{ name	: 'ijin' }
		,	{ name	: 'absen' }
		,	{ name	: 'catatan' }
		,	{ name	: 'nis' }
		,	{ name	: 'nm_siswa' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_akademik_trans_rutin_siswa_rapor_ktsp_d +'data_detail_nilai_rapor.jsp'
		,	autoLoad	: false
	});
	
	this.store_ahlak_pribadi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_akademik_trans_rutin_siswa_rapor_ktsp_d +'data_ref_ahlak_pribadi.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_ahlak = new Ext.form.ComboBox({
			store			: this.store_ahlak_pribadi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_kepribadian = new Ext.form.ComboBox({
			store			: this.store_ahlak_pribadi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_sakit = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_ijin = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_absen = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_catatan = new Ext.form.TextArea({
			allowBlank		: true
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'NIS'
			, dataIndex		: 'nis'
			, sortable		: true
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Nama Siswa'
			, dataIndex		: 'nm_siswa'
			, sortable		: true
			, width			: 170
			, filterable	: true
			}
		,	{ header		: 'Akhlak'
			, dataIndex		: 'id_ahlak'
			, sortable		: true
			, editor		: this.form_ahlak
			, renderer		: combo_renderer(this.form_ahlak)
			, width			: 120
			, filter		: 
				{
					type		: 'list'
				,	store		: this.store_ahlak_pribadi
				,	labelField	: 'name'
				,	phpMode		: false
				}
			}
		,	{ header		: 'Kepribadian'
			, dataIndex		: 'id_pribadi'
			, sortable		: true
			, editor		: this.form_kepribadian
			, renderer		: combo_renderer(this.form_kepribadian)
			, width			: 120
			, filter		: 
				{
					type		: 'list'
				,	store		: this.store_ahlak_pribadi
				,	labelField	: 'name'
				,	phpMode		: false
				}
			}
		,	{ header		: 'Sakit'
			, dataIndex		: 'sakit'
			, sortable		: true
			, editor		: this.form_sakit
			, align			: 'center'
			, width			: 50
			, filter		: 
				{
					type	: 'numeric'
				}
			}
		,	{ header		: 'Ijin'
			, dataIndex		: 'ijin'
			, sortable		: true
			, editor		: this.form_ijin
			, align			: 'center'
			, width			: 50
			, filter		: 
				{
					type	: 'numeric'
				}
			}
		,	{ header		: 'Absen'
			, dataIndex		: 'absen'
			, sortable		: true
			, editor		: this.form_absen
			, align			: 'center'
			, width			: 50
			, filter		: 
				{
					type	: 'numeric'
				}
			}
		,	{ id			: 'catatan'
			, header		: 'Catatan Guru'
			, dataIndex		: 'catatan'
			, sortable		: true
			, editor		: this.form_catatan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'catatan'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.do_edit = function(row)
	{
		if (m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Rombel terlebih dahulu!");
			return;
		}

		if (m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}
	
	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
				url		: m_akademik_trans_rutin_siswa_rapor_ktsp_d +'submit_detail_nilai_rapor.jsp'
			,	params  : {
						id_siswa			: record.data['id_siswa']
					,	kd_tahun_ajaran		: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran
					,	kd_tingkat_kelas	: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas
					,	kd_rombel			: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel
					,	kd_periode_belajar	: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar
					,	id_ahlak			: record.data['id_ahlak']
					,	id_pribadi			: record.data['id_pribadi']
					,	sakit				: record.data['sakit']
					,	ijin				: record.data['ijin']
					,	absen				: record.data['absen']
					,	catatan				: record.data['catatan']
					,	dml_type			: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					Ext.MessageBox.alert('Gagal', response.responseText);
				}
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store_ahlak_pribadi.load({
			callback	: function(){
				this.store.load({
					params	: {
						kd_tahun_ajaran		: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran
					,	kd_tingkat_kelas	: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas
					,	kd_rombel			: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel
					,	kd_periode_belajar	: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar
					}
				});
			}
		,	scope		: this
		});
	}

	this.do_refresh = function()
	{
		if (m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai(title, kd_mata_pelajaran_diajarkan)
{
	this.title							= title;
	this.kd_mata_pelajaran_diajarkan	= kd_mata_pelajaran_diajarkan;
	this.dml_type						= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_siswa' }
		,	{ name	: 'kd_kurikulum' }
		,	{ name	: 'kd_mata_pelajaran_diajarkan' }
		,	{ name	: 'nilai' }
		,	{ name	: 'keterangan' }
		,	{ name	: 'nis' }
		,	{ name	: 'nm_siswa' }
		,	{ name	: 'nm_mata_pelajaran_diajarkan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_akademik_trans_rutin_siswa_rapor_ktsp_d +'data_detail_nilai_rapor_nilai.jsp'
		,	autoLoad	: false
	});
	
	this.form_nilai = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 100
		,	maxText			: 'Nilai Maksimal adalah 100'
	});

	this.form_keterangan = new Ext.form.TextArea({
			allowBlank		: true
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'NIS'
			, dataIndex		: 'nis'
			, sortable		: true
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Nama Siswa'
			, dataIndex		: 'nm_siswa'
			, sortable		: true
			, width			: 200
			, filterable	: true
			}
		,	{ header		: 'Mata Pelajaran Diajarkan'
			, dataIndex		: 'nm_mata_pelajaran_diajarkan'
			, sortable		: true
			, width			: 200
			, filterable	: true
			}
		,	{ header		: 'Nilai'
			, dataIndex		: 'nilai'
			, sortable		: true
			, editor		: this.form_nilai
			, align			: 'center'
			, width			: 50
			, filter		: 
				{
					type	: 'numeric'
				}
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'keterangan'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.do_edit = function(row)
	{
		if (m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Rombel terlebih dahulu!");
			return;
		}

		if (m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
				url		: m_akademik_trans_rutin_siswa_rapor_ktsp_d +'submit_detail_nilai_rapor_nilai.jsp'
			,	params  : {
						id_siswa					: record.data['id_siswa']
					,	kd_tahun_ajaran				: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran
					,	kd_tingkat_kelas			: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas
					,	kd_rombel					: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel
					,	kd_periode_belajar			: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar
					,	kd_kurikulum				: record.data['kd_kurikulum']
					,	kd_mata_pelajaran_diajarkan	: record.data['kd_mata_pelajaran_diajarkan']
					,	nilai						: record.data['nilai']
					,	keterangan					: record.data['keterangan']
					,	dml_type					: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					Ext.MessageBox.alert('Gagal', response.responseText);
				}
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.do_load = function()
	{
		this.store.load({
			params	: {
				kd_tahun_ajaran				: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran
			,	kd_tingkat_kelas			: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas
			,	kd_rombel					: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel
			,	kd_periode_belajar			: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar
			,	kd_mata_pelajaran_diajarkan	: this.kd_mata_pelajaran_diajarkan
			}
		});
	}

	this.do_refresh = function()
	{
		if (m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporEkstra(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_siswa' }
		,	{ name	: 'id_siswa_old' }
		,	{ name	: 'id_ekstrakurikuler' }
		,	{ name	: 'id_ekstrakurikuler_old' }
		,	{ name	: 'id_nilai_afektif' }
		,	{ name	: 'keterangan' }
		,	{ name	: 'nis' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_akademik_trans_rutin_siswa_rapor_ktsp_d +'data_detail_nilai_rapor_ekstra.jsp'
		,	autoLoad	: false
	});
	
	this.store_siswa = new Ext.data.ArrayStore({
			fields		: ['id_siswa','list']
		,	url			: m_akademik_trans_rutin_siswa_rapor_ktsp_d +'data_ref_siswa.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_ekstrakurikuler = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_akademik_trans_rutin_siswa_rapor_ktsp_d +'data_ref_ekstrakurikuler.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_nilai_afektif = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_akademik_trans_rutin_siswa_rapor_ktsp_d +'data_ref_nilai_afektif.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_nis = new Ext.form.ComboBox({
			store			: this.store_siswa
		,	valueField		: 'id_siswa'
		,	displayField	: 'list'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_ekstrakurikuler = new Ext.form.ComboBox({
			store			: this.store_ekstrakurikuler
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_nilai_afektif = new Ext.form.ComboBox({
			store			: this.store_nilai_afektif
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_keterangan = new Ext.form.TextArea({
			allowBlank		: true
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Nama Siswa'
			, dataIndex		: 'id_siswa'
			, sortable		: true
			, editor		: this.form_nis
			, renderer		: combo_renderer(this.form_nis)
			, width			: 300
			, filterable	: true
			}
		,	{ header		: 'Ekstrakurikuler'
			, dataIndex		: 'id_ekstrakurikuler'
			, sortable		: true
			, editor		: this.form_ekstrakurikuler
			, renderer		: combo_renderer(this.form_ekstrakurikuler)
			, width			: 150
			, filter		: 
				{
					type		: 'list'
				,	store		: this.store_ekstrakurikuler
				,	labelField	: 'name'
				,	phpMode		: false
				}
			}
		,	{ header		: 'Nilai Afektif'
			, dataIndex		: 'id_nilai_afektif'
			, sortable		: true
			, editor		: this.form_nilai_afektif
			, renderer		: combo_renderer(this.form_nilai_afektif)
			, width			: 100
			, filter		: 
				{
					type		: 'list'
				,	store		: this.store_nilai_afektif
				,	labelField	: 'name'
				,	phpMode		: false
				}
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_del
		,	'-'
		,	this.btn_ref
		,	'-'
		,	this.btn_add
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	region		: 'center'
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'keterangan'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.set_disabled = function()
	{
		this.btn_del.setDisabled(true);
		this.btn_ref.setDisabled(true);
		this.btn_add.setDisabled(true);
	}

	this.set_enabled = function()
	{
		this.btn_del.setDisabled(false);
		this.btn_ref.setDisabled(false);
		this.btn_add.setDisabled(false);
	}

	this.do_del = function()
	{
		if (m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Rombel terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
	}

	this.do_add = function()
	{
		if (m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Rombel terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				id_siswa			: ''
			,	id_ekstrakurikuler	: ''
			,	id_nilai_afektif	: ''
			,	keterangan			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
	}

	this.do_edit = function(row)
	{
		if (m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel == ''
		||	m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Rombel terlebih dahulu!");
			return;
		}

		if (m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}
	
	this.do_cancel = function()
	{
		this.set_enabled();
		
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
		
		this.set_button();
	}

	this.do_save = function(record)
	{
		this.set_enabled();
		
		Ext.Ajax.request({
				url		: m_akademik_trans_rutin_siswa_rapor_ktsp_d +'submit_detail_nilai_rapor_ekstra.jsp'
			,	params  : {
						id_siswa				: record.data['id_siswa']
					,	id_siswa_old			: record.data['id_siswa_old']
					,	kd_tahun_ajaran			: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran
					,	kd_tingkat_kelas		: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas
					,	kd_rombel				: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel
					,	kd_periode_belajar		: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar
					,	id_ekstrakurikuler		: record.data['id_ekstrakurikuler']
					,	id_ekstrakurikuler_old	: record.data['id_ekstrakurikuler_old']
					,	id_nilai_afektif		: record.data['id_nilai_afektif']
					,	keterangan				: record.data['keterangan']
					,	dml_type				: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
			,	failure	: function(response) {
					Ext.MessageBox.alert('Gagal', response.responseText);
				}
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.set_button = function()
	{
		if (m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_siswa.load({
			params		: {
				kd_tahun_ajaran		: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran
			,	kd_tingkat_kelas	: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas
			,	kd_rombel			: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel				
			}
		,	callback	: function(){
				this.store_ekstrakurikuler.load({
					callback	: function(){
						this.store_nilai_afektif.load({
							callback	: function(){
								this.store.load({
									params	: {
										kd_tahun_ajaran		: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran
									,	kd_tingkat_kelas	: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas
									,	kd_rombel			: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel
									,	kd_periode_belajar	: m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar
									}
								});
							}
						,	scope		: this
						});
					}
				,	scope		: this
				});
			}
		,	scope		: this
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AkademikTransaksiRutinKesiswaanRaporKTSPMaster(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'kd_periode_belajar' }
		,	{ name	: 'nm_tingkat_kelas' }
		,	{ name	: 'nm_pegawai' }
		,	{ name	: 'nm_ruang_kelas' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_akademik_trans_rutin_siswa_rapor_ktsp_d +'data_master.jsp'
		,	autoLoad	: false
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.cm = new Ext.grid.ColumnModel({
		columns	: [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Tingkat'
			, dataIndex		: 'nm_tingkat_kelas'
			, align			: 'center'
			, width			: 60
			, filterable	: true
			}
		,	{ header		: 'Rombel'
			, dataIndex		: 'kd_rombel'
			, align			: 'center'
			, width			: 60
			, filterable	: true
			}
		,	{ header		: 'Wali Kelas'
			, dataIndex		: 'nm_pegawai'
			, width			: 200
			, filterable	: true
			}
		,	{ header		: 'Ruang Kelas'
			, dataIndex		: 'nm_ruang_kelas'
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, filterable	: true
			}
		]
	,	defaults : {
			hideable	: false
		,	sortable	: true
		}
	});

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length){
						m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran = data[0].data['kd_tahun_ajaran'];
						m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas = data[0].data['kd_tingkat_kelas'];
						m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel = data[0].data['kd_rombel'];
						m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar = data[0].data['kd_periode_belajar'];
					} else {
						m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tahun_ajaran = '';
						m_akademik_trans_rutin_siswa_rapor_ktsp_kd_tingkat_kelas = '';
						m_akademik_trans_rutin_siswa_rapor_ktsp_kd_rombel = '';
						m_akademik_trans_rutin_siswa_rapor_ktsp_kd_periode_belajar = '';
					}
					
					m_akademik_trans_rutin_siswa_rapor_ktsp_master_on_select_load_detail();
				}
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	sm					: this.sm
		,	cm					: this.cm
		,	autoScroll			: true
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'keterangan'
	});

	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function()
	{
		if (m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AkademikTransaksiRutinKesiswaanRaporKTSP()
{
	m_akademik_trans_rutin_siswa_rapor_ktsp_master										= new M_AkademikTransaksiRutinKesiswaanRaporKTSPMaster('Penilaian Rapor KTSP');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_catatan_dan_absensi					= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRapor('Absensi dan Catatan');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_agama						= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('Pendidikan Agama', '13');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_kewarganegaraan			= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('Pendidikan Kewarganegaraan', '01001');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_bahasa_indonesia						= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('Bahasa Indonesia', '02001');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_bahasa_inggris						= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('Bahasa Inggris', '04001');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_matematika							= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('Matematika', '03001');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_ipa									= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('IPA', '29001');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_ips									= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('IPS', '30001');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_seni_budaya							= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('Seni Budaya', '61001');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_jasmani_dan_kesehatan		= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('Pendidikan Jasmani dan Kesehatan', '15001');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_keterampilan_tangan_dan_kesenian		= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('Keterampilan Tangan dan Kerajinan', '60001');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_teknologi_informasi_dan_komunikasi	= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('Teknologi Informasi dan Komunikasi', '22001');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_muatan_lokal							= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporNilai('Muatan Lokal', '16');
	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pengembangan_diri					= new M_AkademikTransaksiRutinKesiswaanRaporKTSPDetailNilaiRaporEkstra('Pengembangan Diri');

	this.panel_detail = new Ext.TabPanel({
			autoScroll		: true
		,	enableTabScroll	: true
		,	region			: 'center'
        ,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    		}
		,	items			: [
				m_akademik_trans_rutin_siswa_rapor_ktsp_detail_catatan_dan_absensi.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_agama.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_kewarganegaraan.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_bahasa_indonesia.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_bahasa_inggris.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_matematika.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_ipa.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_ips.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_seni_budaya.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pendidikan_jasmani_dan_kesehatan.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_keterampilan_tangan_dan_kesenian.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_teknologi_informasi_dan_komunikasi.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_muatan_lokal.panel
			,	m_akademik_trans_rutin_siswa_rapor_ktsp_detail_pengembangan_diri.panel
			]
	});

	this.panel = new Ext.Panel({
			id				: 'akademik_trans_rutin_siswa_rapor_ktsp_panel'
		,	layout			: 'border'
		,	bodyBorder		: false
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoWidth		: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_akademik_trans_rutin_siswa_rapor_ktsp_master.panel
			,	this.panel_detail
			]
	});
	
	this.do_refresh = function(ha_level)
	{
		m_akademik_trans_rutin_siswa_rapor_ktsp_ha_level = ha_level;
		
		m_akademik_trans_rutin_siswa_rapor_ktsp_master.do_refresh();
	}
}

m_akademik_trans_rutin_siswa_rapor_ktsp = new M_AkademikTransaksiRutinKesiswaanRaporKTSP();

//@ sourceURL=akademik_trans_rutin_siswa_rapor_ktsp.layout.js
