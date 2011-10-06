/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_akademik_cetak_rapor_ktsp;
var m_adm_akademik_cetak_rapor_ktsp_kd_tahun_ajaran;
var m_adm_akademik_cetak_rapor_ktsp_kd_tingkat_kelas;
var m_adm_akademik_cetak_rapor_ktsp_kd_rombel;
var m_adm_akademik_cetak_rapor_ktsp_kd_periode_belajar;
var m_adm_akademik_cetak_rapor_ktsp_d = _g_root +'/module/adm_akademik_cetak_rapor_ktsp/';

function M_AdmAkademikCetakRaporKTSP(title)
{
	this.title				= title;
	this.ha_level			= 0;
	this.id_report			= '';
	this.tipe_report		= 'pdf';

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'kd_periode_belajar' }
		,	{ name	: 'nm_tingkat_kelas' }
		,	{ name	: 'nm_pegawai' }
		,	{ name	: 'nm_ruang_kelas' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_akademik_cetak_rapor_ktsp_d +'data.jsp'
		,	autoLoad	: false
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Tingkat Kelas'
			, dataIndex		: 'nm_tingkat_kelas'
			, sortable		: true
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Rombel'
			, dataIndex		: 'kd_rombel'
			, sortable		: true
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ id			: 'nm_pegawai'
			, header		: 'Wali Kelas'
			, dataIndex		: 'nm_pegawai'
			, sortable		: true
			, filterable	: true
			}
		,	{ header		: 'Ruang Kelas'
			, dataIndex		: 'nm_ruang_kelas'
			, sortable		: true
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
					scope			: this
				,	selectionchange	: function(sm) {
						var data = sm.getSelections();
						if (data.length) {
							m_adm_akademik_cetak_rapor_ktsp_kd_tahun_ajaran 	= data[0].data['kd_tahun_ajaran'];
							m_adm_akademik_cetak_rapor_ktsp_kd_tingkat_kelas 	= data[0].data['kd_tingkat_kelas'];
							m_adm_akademik_cetak_rapor_ktsp_kd_rombel 			= data[0].data['kd_rombel'];
							m_adm_akademik_cetak_rapor_ktsp_kd_periode_belajar	= data[0].data['kd_periode_belajar'];
							this.btn_print.setDisabled(false);
						} else {
							m_adm_akademik_cetak_rapor_ktsp_kd_tahun_ajaran 	= '';
							m_adm_akademik_cetak_rapor_ktsp_kd_tingkat_kelas 	= '';
							m_adm_akademik_cetak_rapor_ktsp_kd_rombel 			= '';
							m_adm_akademik_cetak_rapor_ktsp_kd_periode_belajar	= '';
							this.btn_print.setDisabled(true);
						}
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

	this.menu_print = new Ext.menu.Menu({
		items	:[
			{
				text	: 'Halaman 1'
			,	scope	: this
			,	handler	: function (b,e) {
					this.id_report = '6341';
					this.do_print();
				}
			}
		,	{
				text	: 'Halaman 2'
			,	scope	: this
			,	handler	: function (b,e) {
					this.id_report = '6342';
					this.do_print();
				}
			}
		,	{
				text	: 'Halaman 3'
			,	scope	: this
			,	handler	: function (b,e) {
					this.id_report = '6343';
					this.do_print();
				}
			}
		,	{
				text	: 'Halaman 4'
			,	scope	: this
			,	handler	: function (b,e) {
					this.id_report = '6344';
					this.do_print();
				}
			}
		,	{
				text	: 'Halaman 5'
			,	scope	: this
			,	handler	: function (b,e) {
					this.id_report = '6345';
					this.do_print();
				}
			}
		]
	});

	this.btn_print = new Ext.Button({
			text		: 'Cetak'
		,	iconCls		: 'print16'
		,	scope		: this
		,	disabled	: true
		,	menu		: this.menu_print
	});

	this.tbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'->'
		,	this.btn_print
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id					: 'adm_akademik_cetak_rapor_ktsp_panel'
		,	title				: this.title
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	autoExpandColumn	: 'nm_pegawai'
		,	tbar				: this.tbar
	});

	this.do_print = function()
	{
		if (m_adm_akademik_cetak_rapor_ktsp_kd_tahun_ajaran == ''
		||	m_adm_akademik_cetak_rapor_ktsp_kd_tingkat_kelas == ''
		||	m_adm_akademik_cetak_rapor_ktsp_kd_rombel == ''
		||	m_adm_akademik_cetak_rapor_ktsp_kd_periode_belajar == ''){
			return;
		}
		
		var form;
		form = document.createElement('form');

		form.setAttribute('method', 'post');
		form.setAttribute('target', '_blank');		
		form.setAttribute('action', _g_root +'/report');
		
		var hiddenField1 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
        hiddenField1.setAttribute('name', 'id');
        hiddenField1.setAttribute('value', this.id_report);
		
		var hiddenField2 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField2.setAttribute('name', 'type');
        hiddenField2.setAttribute('value', this.tipe_report);

		var hiddenField3 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField3.setAttribute('name', 'kd_tahun_ajaran');
        hiddenField3.setAttribute('value', m_adm_akademik_cetak_rapor_ktsp_kd_tahun_ajaran);
		
		var hiddenField4 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField4.setAttribute('name', 'kd_tingkat_kelas');
        hiddenField4.setAttribute('value', m_adm_akademik_cetak_rapor_ktsp_kd_tingkat_kelas);

		var hiddenField5 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField5.setAttribute('name', 'kd_rombel');
        hiddenField5.setAttribute('value', m_adm_akademik_cetak_rapor_ktsp_kd_rombel);

		var hiddenField6 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField6.setAttribute('name', 'kd_periode_belajar');
        hiddenField6.setAttribute('value', m_adm_akademik_cetak_rapor_ktsp_kd_periode_belajar);
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		form.appendChild(hiddenField3);
		form.appendChild(hiddenField4);
		form.appendChild(hiddenField5);
		form.appendChild(hiddenField6);
		document.body.appendChild(form);
		form.submit();
	}
	
	this.do_load = function()
	{
		this.store.load();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

m_adm_akademik_cetak_rapor_ktsp = new M_AdmAkademikCetakRaporKTSP('Cetak Rapor');

//@ sourceURL=adm_akademik_cetak_rapor_ktsp.layout.js
