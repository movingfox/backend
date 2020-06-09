class Trestle::Table::Builder
  def sortable_column(field, options)
    table.columns << SortableColumn.new(table, field, options)
  end
end

