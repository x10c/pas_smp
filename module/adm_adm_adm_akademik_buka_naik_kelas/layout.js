/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_adm_adm_akademik_buka_naik_kelas;
var m_adm_adm_adm_akademik_buka_naik_kelas_d = _g_root +'/module/adm_adm_adm_akademik_buka_naik_kelas/';

function M_AdmAdmAdmAkademikBukaNaikKelas(title)
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
		,	{ name	: 'kd_lulus', type : 'bool' }
		,	{ name	: 'no_ijazah' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_adm_adm_akademik_buka_naik_kelas_d +'data.jsp'
		,	autoLoad	: false
	});

	this.checkColumn = new Ext.grid.CheckColumn({
			header		: 'Naik Kelas / Lulus'
		,	dataIndex	: 'kd_lulus'
		,	editable	: false
		,	width		: 150
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
		,	this.checkColumn
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
			text	: '<b>Buka Kenaikan Kelas</b>'
		,	iconCls	: 'dirup16'
		,	scope	: this
		,	handler	: function() {
				this.do_process();
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
			id					: 'adm_adm_adm_akademik_buka_naik_kelas_panel'
		,	title				: this.title
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.checkColumn, this.filters]
		,	tbar				: this.tbar
		,	bbar				: this.bbar
		,	autoExpandColumn	: 'nm_siswa'
	});

	this.do_process = function()
	{
		Ext.MessageBox.confirm('Konfirmasi', 'Buka Kembali Kenaikan Kelas?', function(btn, text){
			if (btn == 'ok'){
				this.dml_type = 5;
				Ext.Ajax.request({
						params  : {
							dml_type	: this.dml_type
						}
					,	url		: m_adm_adm_adm_akademik_buka_naik_kelas_d +'submit.jsp'
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
		});
	}

	this.do_check = function()
	{
		Ext.Ajax.request({
			url		: m_adm_adm_adm_akademik_buka_naik_kelas_d +'data_status_naik_kelas.jsp'
		,	waitMsg	: 'Mohon Tunggu ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);

				if (msg.success == false) {
					return;
				}

				if (msg.status_naik_kelas < 3){
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

		if (this.store.getTotalCount() < 1){
			this.btn_process.setDisabled(true);
		} else {
			this.btn_process.setDisabled(false);
		}

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

m_adm_adm_adm_akademik_buka_naik_kelas = new M_AdmAdmAdmAkademikBukaNaikKelas('Buka Kenaikan Kelas');

//@ sourceURL=m_adm_adm_adm_akademik_buka_naik_kelas.layout.js
