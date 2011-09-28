/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa;
var m_adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa_kd_tahun_ajaran;
var m_adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa_d = _g_root +'/module/adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa/';

function M_AdmSiswaCetakLaporanSiswaRekapitulasiSiswaKelompokUmurSiswa(title)
{
	this.title				= title;
	this.ha_level			= 0;
	this.id_report			= '5342';
	this.tipe_report		= 'doc';

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'nm_tahun_ajaran' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa_d +'data.jsp'
		,	autoLoad	: false
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Tahun Pelajaran'
			, dataIndex		: 'nm_tahun_ajaran'
			, sortable		: true
			, editable		: false
			, align			: 'center'
			, width			: 200
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
					scope			: this
				,	selectionchange	: function(sm) {
						var data = sm.getSelections();
						if (data.length) {
							m_adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa_kd_tahun_ajaran = data[0].data['kd_tahun_ajaran'];
							this.btn_print.setDisabled(false);
						} else {
							m_adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa_kd_tahun_ajaran = '';
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

	this.btn_print = new Ext.Button({
			text		: 'Cetak'
		,	iconCls		: 'print16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_print();
			}
	});

	this.tbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'->'
		,	this.btn_print
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id					: 'adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa_panel'
		,	title				: this.title
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	tbar				: this.tbar
	});

	this.do_print = function()
	{
		if (m_adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa_kd_tahun_ajaran == ''){
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
        hiddenField3.setAttribute('value', m_adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa_kd_tahun_ajaran);
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		form.appendChild(hiddenField3);
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

m_adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa = new M_AdmSiswaCetakLaporanSiswaRekapitulasiSiswaKelompokUmurSiswa('Laporan Rekapitulasi Siswa Berdasarkan Kelompok Umur');

//@ sourceURL=adm_siswa_cetak_laporan_siswa_rekapitulasi_siswa_kelompok_umur_siswa.layout.js
