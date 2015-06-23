<form action="/" method="post" class="drug-submittal">
  <input type="hidden" name="_token" value="{{{ csrf_token() }}}" />
  <div class="form-group">
    <label for="drug">Enter a drug name to start your search</label>
    <input type="text" class="form-control" id="drug" name="drug" value="{{ $drug or '' }}"placeholder="Drug name">
  </div>
  <button type="submit" class="btn btn-default center-block btn-primary">SEARCH</button>
</form>