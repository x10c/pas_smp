/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_periodikal_per_tahun_ajaran_rombel;
var m_ref_periodikal_per_tahun_ajaran_rombel_master;
var m_ref_periodikal_per_tahun_ajaran_rombel_detail;
var m_ref_periodikal_per_tahun_ajaran_rombel_d = _g_root +'/module/ref_periodikal_per_tahun_ajaran_rombel/';
var m_ref_periodikal_per_tahun_ajaran_rombel_kd_tahun_ajaran = '';
var m_ref_periodikal_per_tahun_ajaran_rombel_kd_tingkat_kelas = '';
var m_ref_periodikal_per_tahun_ajaran_rombel_ha_level = 0;

function m_ref_periodikal_per_tahun_ajaran_rombel_master_on_select_load_detail()
{
 	if (typeof m_ref_periodikal_per_tahun_ajaran_rombel_master == 'undefined'
	||  typeof m_ref_periodikal_per_tahun_ajaran_rombel_detail == 'undefined'
	||	m_ref_periodikal_per_tahun_ajaran_rombel_kd_tahun_ajaran == ''
	||	m_ref_periodikal_per_tahun_ajaran_rombel_kd_tingkat_kelas == '') {
		return;
	}

	m_ref_periodikal_per_tahun_ajaran_rombel_detail.do_refresh();
}

function M_RefPeriodikalPerTahunAjaranRombelMaster(title)
{
	this.title		= title;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'nm_tingkat_kelas' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_periodikal_per_tahun_ajaran_rombel_d +'data_master.jsp'
		,	autoLoad	: false
	});
	
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ id			: 'nm_tingkat_kelas'
			, header		: 'Tingkat Kelas'
			, dataIndex		: 'nm_tingkat_kelas'
			, sortable		: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
					scope			: this
				,	selectionchange	: function(sm) {
						var data = sm.getSelections();
						if (data.length) {
							m_ref_periodikal_per_tahun_ajaran_rombel_kd_tahun_ajaran	= data[0].data['kd_tahun_ajaran'];
							m_ref_periodikal_per_tahun_ajaran_rombel_kd_tingkat_kelas	= data[0].data['kd_tingkat_kelas'];
						} else {
							m_ref_periodikal_per_tahun_ajaran_rombel_kd_tahun_ajaran	= '';
							m_ref_periodikal_per_tahun_ajaran_rombel_kd_tingkat_kelas	= '';
						}

						m_ref_periodikal_per_tahun_ajaran_rombel_master_on_select_load_detail();
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

	this.grid = new Ext.grid.GridPanel({
			title				: this.title
		,	region				: 'north'
		,	height				: 200
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	tbar				: this.toolbar
		,	autoExpandColumn	: 'nm_tingkat_kelas'
	});

	this.do_load = function()
	{
		this.store.load();

		m_ref_periodikal_per_tahun_ajaran_rombel_kd_tahun_ajaran	= '';
		m_ref_periodikal_per_tahun_ajaran_rombel_kd_tingkat_kelas	= '';
		
		m_ref_periodikal_per_tahun_ajaran_rombel_detail.do_load();
	}

	this.do_refresh = function()
	{
		if (m_ref_periodikal_per_tahun_ajaran_rombel_ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		this.do_load();
	}
}

function M_RefPeriodikalPerTahunAjaranRombelDetail(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'kd_rombel' }
		,	{ name	: 'kd_rombel_old' }
		,	{ name	: 'id_ruang_kelas' }
		,	{ name	: 'id_pegawai' }
		,	{ name	: 'id_pegawai_bk' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_periodikal_per_tahun_ajaran_rombel_d +'data_detail.jsp'
		,	autoLoad	: false
	});

	this.store_ruang_kelas = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_ref_periodikal_per_tahun_ajaran_rombel_d +'data_ruang_kelas.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_pegawai = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_ref_periodikal_per_tahun_ajaran_rombel_d +'data_pegawai.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});
	
	this.form_kd_rombel = new Ext.form.TextField({
		allowBlank	: false
	});
	
	this.form_ruang_kelas = new Ext.form.ComboBox({
			store			: this.store_ruang_kelas
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_wali_kelas = new Ext.form.ComboBox({
			store			: this.store_pegawai
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_guru_bk = new Ext.form.ComboBox({
			store			: this.store_pegawai
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_keterangan = new Ext.form.TextField({});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'No.Rombel'
			, dataIndex		: 'kd_rombel'
			, sortable		: true
			, editor		: this.form_kd_rombel
			, align			: 'center'
			, width			: 100
			, filterable	: true
			}
		,	{ header		: 'Ruang Kelas'
			, dataIndex		: 'id_ruang_kelas'
			, sortable		: true
			, editor		: this.form_ruang_kelas
			, renderer		: combo_renderer(this.form_ruang_kelas)
			, align			: 'center'
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_ruang_kelas
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Nama Wali Kelas'
			, dataIndex		: 'id_pegawai'
			, sortable		: true
			, editor		: this.form_wali_kelas
			, renderer		: combo_renderer(this.form_wali_kelas)
			, width			: 200
			}
		,	{ header		: 'Nama Guru BK'
			, dataIndex		: 'id_pegawai_bk'
			, sortable		: true
			, editor		: this.form_guru_bk
			, renderer		: combo_renderer(this.form_guru_bk)
			, width			: 200
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_ref_periodikal_per_tahun_ajaran_rombel_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
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

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
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

	this.grid = new Ext.grid.GridPanel({
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
				,	rowclick	: function (g, r, e) {
						return this.do_edit(r);
					}
			}
	});

	this.do_add = function()
	{
		if (m_ref_periodikal_per_tahun_ajaran_rombel_kd_tahun_ajaran == '' || m_ref_periodikal_per_tahun_ajaran_rombel_kd_tingkat_kelas == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tingkat Kelas terlebih dahulu!");
			return;
		}

		this.record_new = new this.record({
				kd_tahun_ajaran		: ''
			,	kd_tingkat_kelas	: ''
			,	kd_rombel			: ''
			,	id_ruang_kelas		: ''
			,	id_pegawai			: ''
			,	id_pegawai_bk		: ''
			,	keterangan			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
	}

	this.do_del = function()
	{
		if (m_ref_periodikal_per_tahun_ajaran_rombel_kd_tahun_ajaran == '' || m_ref_periodikal_per_tahun_ajaran_rombel_kd_tingkat_kelas == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tingkat Kelas terlebih dahulu!");
			return;
		}

		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		this.dml_type = 4;
		this.do_save(data[0]);
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
						kd_tahun_ajaran		: m_ref_periodikal_per_tahun_ajaran_rombel_kd_tahun_ajaran
					,	kd_tingkat_kelas	: m_ref_periodikal_per_tahun_ajaran_rombel_kd_tingkat_kelas
					,	kd_rombel			: record.data['kd_rombel']
					,	kd_rombel_old		: record.data['kd_rombel_old']
					,	id_ruang_kelas		: record.data['id_ruang_kelas']
					,	id_pegawai			: record.data['id_pegawai']
					,	id_pegawai_bk		: record.data['id_pegawai_bk']
					,	keterangan			: record.data['keterangan']
					,	dml_type			: this.dml_type
				}
			,	url		: m_ref_periodikal_per_tahun_ajaran_rombel_d +'submit.jsp'
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

	this.do_edit = function(row)
	{
		if (m_ref_periodikal_per_tahun_ajaran_rombel_kd_tahun_ajaran == '' || m_ref_periodikal_per_tahun_ajaran_rombel_kd_tingkat_kelas == '') {
			Ext.Msg.alert("Kesalahan Operasi", "Silahkan pilih salah satu data Tingkat Kelas terlebih dahulu!");
			return;
		}

		if (m_ref_periodikal_per_tahun_ajaran_rombel_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_ruang_kelas.load({
				callback	: function(){
					this.store_pegawai.load({
							callback	: function(){
								this.store.load({
									params	: {
											kd_tahun_ajaran		: m_ref_periodikal_per_tahun_ajaran_rombel_kd_tahun_ajaran
										,	kd_tingkat_kelas	: m_ref_periodikal_per_tahun_ajaran_rombel_kd_tingkat_kelas
									}
								});
							}
						,	scope		: this
					});
				}
			,	scope		: this
		});		
	}

	this.do_refresh = function()
	{
		if (m_ref_periodikal_per_tahun_ajaran_rombel_ha_level < 1) {
			this.grid.setDisabled(true);
			return;
		} else {
			this.grid.setDisabled(false);
		}

		if (m_ref_periodikal_per_tahun_ajaran_rombel_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_ref_periodikal_per_tahun_ajaran_rombel_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}

		this.do_load();
	}

}

function M_RefPeriodikalPerTahunAjaranRombel()
{
	m_ref_periodikal_per_tahun_ajaran_rombel_master	= new M_RefPeriodikalPerTahunAjaranRombelMaster('Tingkat Kelas');
	m_ref_periodikal_per_tahun_ajaran_rombel_detail	= new M_RefPeriodikalPerTahunAjaranRombelDetail('Penugasan Guru Wali Kelas');
	
	this.panel = new Ext.Panel({
			id			: 'ref_periodikal_per_tahun_ajaran_rombel_panel'
		,	layout		: 'border'
		,	bodyBorder	: false
		,	defaults	: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animCollapse	: true
    			}
		,	items			: [
				m_ref_periodikal_per_tahun_ajaran_rombel_master.grid
			,	m_ref_periodikal_per_tahun_ajaran_rombel_detail.grid
			]
	});

	this.do_refresh = function(ha_level)
	{
		m_ref_periodikal_per_tahun_ajaran_rombel_ha_level	= ha_level;
		m_ref_periodikal_per_tahun_ajaran_rombel_kd_tahun_ajaran = '';
		m_ref_periodikal_per_tahun_ajaran_rombel_kd_tingkat_kelas = '';

		m_ref_periodikal_per_tahun_ajaran_rombel_master.do_refresh(ha_level);
	}

}

m_ref_periodikal_per_tahun_ajaran_rombel = new M_RefPeriodikalPerTahunAjaranRombel();

//@ sourceURL=ref_periodikal_per_tahun_ajaran_rombel.layout.js
