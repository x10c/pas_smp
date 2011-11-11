/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_adm_adm_kesiswaan_ubah_siswa_putus;
var m_adm_adm_adm_kesiswaan_ubah_siswa_putus_d = _g_root +'/module/adm_adm_adm_kesiswaan_ubah_siswa_putus/';

function M_AdmAdmAdmKesiswaanUbahSiswaPutus(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'id_siswa' }
		,	{ name	: 'nis' }
		,	{ name	: 'nm_siswa' }
		,	{ name	: 'nm_tingkat_kelas' }
		,	{ name	: 'tanggal_keluar' }
		,	{ name	: 'alasan_keluar' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_adm_adm_kesiswaan_ubah_siswa_putus_d +'data.jsp'
		,	autoLoad	: false
	});
	
	this.form_tanggal_keluar = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
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
			, width			: 250
			, filterable	: true
			}
		,	{ header		: 'Tingkat Kelas'
			, dataIndex		: 'nm_tingkat_kelas'
			, sortable		: true
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Tanggal Keluar'
			, dataIndex		: 'tanggal_keluar'
			, editor		: this.form_tanggal_keluar
			, sortable		: true
			, align			: 'center'
			, width			: 100
			}
		,	{ id			: 'alasan_keluar'
			, header		: 'Alasan Keluar'
			, dataIndex		: 'alasan_keluar'
			, sortable		: true
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && this.ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

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

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'-'
		,	this.btn_del
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id					: 'adm_adm_adm_kesiswaan_ubah_siswa_putus_panel'
		,	title				: this.title
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'alasan_keluar'
	});

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Hapus Data?', function(btn, text){
			if (btn == 'yes'){
				this.dml_type = 4;
				this.do_save(data[0]);
			}
		}, this);
	}

	this.do_save = function(record)
	{
		if (this.ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				url		: m_adm_adm_adm_kesiswaan_ubah_siswa_putus_d +'submit.jsp'
			,	params  : {
						id_siswa	: record.data['id_siswa']
					,	dml_type	: this.dml_type
				}
			,	waitMsg	: 'Mohon Tunggu ...'
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
		this.store.load();	
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

		if (this.ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}
}

m_adm_adm_adm_kesiswaan_ubah_siswa_putus = new M_AdmAdmAdmKesiswaanUbahSiswaPutus('Ubah Siswa Putus');

//@ sourceURL=m_adm_adm_adm_kesiswaan_ubah_siswa_putus.layout.js
