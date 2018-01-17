class LegoSetSearch extends React.Component {

  constructor() {
    super();

    this.state = {
      value: '',
      selectedSet: null,
      suggestedSets: []
    };
  }

  render() {
    return (
      <div>
        <div className="form-group">
          <label>
            <i className="fa fa-search"/>
            Search
          </label>
          <ReactAutocomplete
            inputProps={{ id: 'sets-autocomplete', className: 'form-control' }}
            wrapperStyle={{ position: 'relative', display: 'block' }}
            value={this.state.value}
            items={this.state.suggestedSets}
            getItemValue={(item) => item.set_num}
            onSelect={(value, item) => {
              // set the menu to only the selected item
              this.setState({ value, suggestedSets: [item], selectedSet: item })
              // or you could reset it to a default list again
              // this.setState({ unitedStates: getStates() })
            }}
            onChange={(event, value) => {
              this.setState({ value })
              $.getJSON(`/rebrickable/search?search=${value}`)
                .then(res => {
                  this.setState({ suggestedSets: res })
                })
                .catch(err => console.error('Failed to load set suggesetions.', err));
            }}
            renderMenu={children => (
              <div className="menu">
                {children}
              </div>
            )}
            renderItem={(item, isHighlighted) => (
              <div
                className={`item ${isHighlighted ? 'item-highlighted' : ''}`}
                key={item.set_num}>
                <img src={item.set_img_url} />
                <span className="name">{item.name}</span>
              </div>
            )}
          />
          
        </div>
        {this.state.selectedSet != null && 
          <div>
            <h3>{this.state.selectedSet.name}</h3>
            <img src={this.state.selectedSet.set_img_url} />
            <input type="hidden" name="lego_set[set_id]" value={this.state.selectedSet.set_num} />
            <input type="hidden" name="lego_set[name]"  value={this.state.selectedSet.name} />
            <input type="hidden" name="lego_set[thumbnail_url]"  value={this.state.selectedSet.set_img_url} />
          </div>
        }
      </div>
    );
  }
}