/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa;
var m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa_d = _g_root +'/module/adm_akademik_trans_rutin_siswa_rekap_absensi_siswa/';

function M_AdmAkademikTransRutinSiswaRekapAbsensiSiswa(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'id_siswa' }
		,	{ name	: 'nis' }
		,	{ name	: 'nm_siswa' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa_d +'data.jsp'
		,	autoLoad	: false
	});
	
	this.form_tanggal_rapor = new Ext.form.DateField({
			fieldLabel		: 'Tanggal Rapor'
		,	emptyText		: 'Tahun-Bulan-Tanggal'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
		,	width			: 150
		,	msgTarget		: 'side'
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
			, editable		: false
			, align			: 'center'
			, width			: 150
			}
		,	{ id			: 'nm_siswa'
			, header		: 'Nama Siswa'
			, dataIndex		: 'nm_siswa'
			, sortable		: true
			, editable		: false
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_process = new Ext.Button({
			text	: '<b>Rekap Absensi Siswa</b>'
		,	iconCls	: 'dirup16'
		,	scope	: this
		,	handler	: function() {
				this.do_process();
			}
	});

	this.btn_save = new Ext.Button({
			text		: 'Simpan'
		,	iconCls		: 'save16'
		,	scope		: this
		,	handler		: function() {
				this.do_save();
			}
	});

	this.btn_cancel = new Ext.Button({
			text	:'Batal'
		,	iconCls	:'del16'
		,	scope	:this
		,	handler	:function() {
				this.do_cancel();
			}
	});

	this.tbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.bbar = new Ext.Toolbar({
		items	: [
			this.btn_process
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id					: 'adm_akademik_trans_rutin_siswa_rekap_absensi_siswa_panel'
		,	title				: this.title
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.tbar
		,	bbar				: this.bbar
		,	autoExpandColumn	: 'nm_siswa'
	});

	this.win = new Ext.Window({
		title		: 'Tanggal Diberikan Rapor'
	,	modal		: true
	,	layout		: 'form'
	,	labelAlign	: 'left'
	,	padding		: 6
	,	closable	: false
	,	resizable	: false
	,	plain		: true
	,	autoHeight	: true
	,	width		: 290
	,	items		:[
			this.form_tanggal_rapor
		]
	,	bbar		: [
			this.btn_cancel, '->'
		,	this.btn_save
		]
	});
	
	this.do_process = function()
	{
		if (this.ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Rekap Absensi Siswa?', function(btn, text){
			if (btn == 'yes'){
				m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa.win.show();
			}
		});
	}

	this.do_insert_rapor = function()
	{
		this.dml_type = 5;
		Ext.Ajax.request({
				params  : {
						tanggal_rapor	: this.form_tanggal_rapor.getValue()
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa_d +'submit_rapor.jsp'
			,	waitMsg	: 'Mohon Tunggu ...'
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa.win.hide();
						m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa.do_load();
					}
			,	scope	: this
		});
	}

	this.do_save = function(record)
	{
		this.dml_type = 5;
		Ext.Ajax.request({
				params  : {
						tanggal_rapor	: this.form_tanggal_rapor.getValue()
					,	dml_type		: this.dml_type
				}
			,	url		: m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa_d +'submit.jsp'
			,	waitMsg	: 'Mohon Tunggu ...'
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa.do_insert_rapor();
					}
			,	scope	: this
		});
	}

	this.do_cancel = function()
	{
		this.win.hide();
	}
	
	this.do_check = function()
	{
		Ext.Ajax.request({
			url		: m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa_d +'data_check.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					return;
				}

				if (msg.jumlah < 1 || msg.status_naik_kelas >= msg.kd_periode_belajar){
					this.btn_process.setDisabled(true);
				} else {
					this.btn_process.setDisabled(false);
				}
			}
		,	scope	: this
		});
	}
	
	this.do_load = function()
	{
		this.store.load();

		this.do_check();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (this.ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		if (this.ha_level > 1) {
			this.btn_process.setDisabled(false);
		} else {
			this.btn_process.setDisabled(true);
		}

		this.do_load();
	}
}

m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa = new M_AdmAkademikTransRutinSiswaRekapAbsensiSiswa('Rekap Absensi Siswa');

//@ sourceURL=m_adm_akademik_trans_rutin_siswa_rekap_absensi_siswa.layout.js
