/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_akademik_trans_rutin_siswa_penentuan_siswa_baru;
var m_adm_akademik_trans_rutin_siswa_penentuan_siswa_baru_d = _g_root +'/module/adm_akademik_trans_rutin_siswa_penentuan_siswa_baru/';

function M_AdmAkademikTransRutinSiswaPenentuanSiswaBaru(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'id_siswa' }
		,	{ name	: 'nm_tingkat_kelas' }
		,	{ name	: 'nis' }
		,	{ name	: 'nm_siswa' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_baru_d +'data.jsp'
		,	autoLoad	: false
	});
	
	this.store_rombel = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_baru_d +'data_ref_rombel.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_rombel = new Ext.form.ComboBox({
			store			: this.store_rombel
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
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
		,	{ header		: 'Tingkat Kelas'
			, dataIndex		: 'nm_tingkat_kelas'
			, sortable		: true
			, editable		: false
			, align			: 'center'
			, width			: 100
			}
		,	{ header		: 'Wali Kelas'
			, dataIndex		: 'kd_rombel'
			, sortable		: true
			, editor		: this.form_rombel
			, renderer		: combo_renderer(this.form_rombel)
			, width			: 250
			, filter		: {
					type		: 'list'
				,	store		: this.store_rombel
				,	labelField	: 'name'
				,	phpMode		: false
			 }
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

	this.btn_process = new Ext.Button({
			text	: '<b>Penentuan Kelas Selesai</b>'
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
			id			: 'adm_akademik_trans_rutin_siswa_penentuan_siswa_baru_panel'
		,	title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.tbar
		,	bbar		: this.bbar
		,	autoExpandColumn: 'nm_siswa'
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
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_process = function()
	{
		Ext.MessageBox.confirm('Konfirmasi', 'Penentuan Kelas Selesai?', function(btn, text){
			if (btn == 'ok'){
				this.dml_type = 5;
				Ext.Ajax.request({
						params  : {
								kd_tahun_ajaran		: ''
							,	kd_tingkat_kelas	: ''
							,	kd_rombel			: ''
							,	id_siswa			: ''
							,	dml_type			: this.dml_type
						}
					,	url		: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_baru_d +'submit.jsp'
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
				params  : {
						kd_tahun_ajaran		: record.data['kd_tahun_ajaran']
					,	kd_tingkat_kelas	: record.data['kd_tingkat_kelas']
					,	kd_rombel			: record.data['kd_rombel']
					,	id_siswa			: record.data['id_siswa']
					,	dml_type			: this.dml_type
				}
			,	url		: m_adm_akademik_trans_rutin_siswa_penentuan_siswa_baru_d +'submit.jsp'
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
		this.store_rombel.load({
				callback	: function(){
					this.store.load();
				}
			,	scope		: this
		});		
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

m_adm_akademik_trans_rutin_siswa_penentuan_siswa_baru = new M_AdmAkademikTransRutinSiswaPenentuanSiswaBaru('Penentuan Kelas Siswa Baru');

//@ sourceURL=m_adm_akademik_trans_rutin_siswa_penentuan_siswa_baru.layout.js
